
(in-package #:tcadb)

(defmethod object-to-list (object)
  (let ((slots  (moptilities:direct-slot-names (class-of object))))
    (loop for slot in slots
	 when (slot-boundp object slot)
       append `(,(intern (symbol-name slot) :keyword) ,(slot-value object slot)))))

(defmethod make-search-definition (object)
  (let ((slots (object-to-list object)))
    (loop for (slot val) on slots by #'cddr
       collect `(:|cond| ,slot "str" ,val))))

(defmethod index-slot-of (object)
  (assert (slot-exists-p object 'id) (object) "object has no index")
  'id)

(defmethod index-key-of (object)
  :id)

(defmethod connected (db)
  (tcadb-sys::tcadbpath db))

(defmethod db-insert (object &optional (db *db*))
  (let ((object-list (object-to-list object))
	(index (slot-value object (index-slot-of object)))
	(type (type-of object)))
    (assert (connected db) (db) "not connected")
    (assert (remf  object-list (index-key-of object)) (object) "no index in object")
    (db-put db `(,index ,@object-list :db-object-type ,type)))) ;; add db-type

(export 'db-insert)

(defmethod db-find (object &optional (db *db*))
  (let ((object-list (object-to-list object))
	(index (if (slot-boundp object (index-slot-of object)) (slot-value object (index-slot-of object))))
	(type (type-of object)))
    (remf object-list index)
    (db-search db (list* `(:|cond| :db-object-type "str" ,type) (make-search-definition object)))))

(export 'db-find)

(defmethod db-fetch (object &optional (db *db*))
  (let* ((index (index-slot-of object))
	 (type (type-of object))
	 (db-string-list (db-get db (list (slot-value object index)))))
    (when db-string-list
      (let ((db-object-list
	     (loop for (key val) on db-string-list by #'cddr
		append (list (intern key :keyword) val))))
	(destructuring-bind (&key db-object-type &allow-other-keys) db-object-list
	  (format t "~a" (list 'string-equal (symbol-name type) db-object-type))
	  (assert (string-equal (symbol-name type) db-object-type) () "db type and fetch types are not the same")
	  (remf db-object-list :db-object-type)
	  (apply #'make-instance type db-object-list))))))

(export 'db-fetch)