

(in-package :cl-user)

(defun fqsn (stream object colon-p atsign-p &rest format-args)
  "helper function for def-db-class"
  (declare (ignore colon-p atsign-p format-args))
  (let ((*package* (find-package :keyword)))
    (write object :stream stream :readably t)))

(in-package #:tcadb)

(defmethod object-to-list (object)
  "Takes an object and returns it in list form like this: (:slot value :slot value)"  
  (let ((slots  (moptilities:direct-slot-names (class-of object))))
    (loop for slot in slots
       when (slot-boundp object slot)
       append `(,(intern (symbol-name slot) :keyword) ,(slot-value object slot)))))

(defmethod make-search-definition (object)
  "Helper function for query
Returns a list of conditions that should be passed to a query"
  (let ((slots (object-to-list object)))
    (loop for (slot val) on slots by #'cddr
       collect `(:|cond| ,slot "str" ,val))))

(defun normalize-slots (slots)
  "Helper function for def-db-class
used to convert type-key-values from index slots to 'normal' type (without 'index)"
  (loop for def in (copy-tree slots)
     collect (destructuring-bind (slot &key type &allow-other-keys) def
	       (declare (ignore slot))
	       (cond
		 ((equal type :index)
		  (remf (rest def) :type))
		 ((and (listp type) (equal (car type) :index))
		  (setf (getf def :type) (second type))))
	       def)))

(defmethod get-index-slots (slots)
  "Helper function for def-db-class
Returns a list of slots that are used as indexses."
  (loop 
     for def in (copy-tree slots)
     when (destructuring-bind (slot &key type &allow-other-keys) def
		  (when  (or (eql type :index)
			     (and (listp type)
				  (eql (car type) :index)))
		    slot))
     collect it))



(defgeneric index-of (slots))
(defgeneric class-name-string (slots))

(defmacro def-db-class (name inherit slots)
  `(progn (defclass ,name ,inherit
	    ,(normalize-slots slots))
	  (defmethod index-of ((object ,name))
	    (with-slots ,(get-index-slots slots) object
	      (format nil "~/fqsn/+~{~a~^+~}" (type-of object)  (list ,@(get-index-slots slots)))))
	  (defmethod class-name-string ((object ,name))
	    (format nil "~/fqsn/" (type-of object)))))

(defmethod db-insert (object &optional (db *db*))
  "Inserts an object into the database"
  (let ((object-list (object-to-list object))
	(index (index-of object)))
    (assert (connected db) (db) "not connected")
    (db-put db `(,index ,@object-list))))

(export 'db-insert)

(defmethod db-find (object &optional (db *db*))
  "finds objects in the a data base"
  (let ((search-definition (make-search-definition object))
	(object-type (class-name-string object)))
    (db-search db (list* `(:|cond| "" "BW" ,object-type) search-definition))))

(export 'db-find)

(defmethod parse-db-response (object list)
  (declare (ignore object))
  (loop
     for (key val) on list by #'cddr
     append (list (intern key :keyword) val)))   ;; TODO add a reader for slot types

(defmethod db-fetch (object &optional (db *db*))
  (let* ((index (index-of object))
	 (db-string-list (db-get db (list index))))
    (when db-string-list
      (let ((db-object-list (parse-db-response object db-string-list)))
	(apply #'make-instance (type-of object) db-object-list)))))

(export 'db-fetch)
