(defpackage #:tcadb-example
  (:nicknames #:tca-ex)
  (:use #:cl #:tcadb))

(in-package #:tcadb-example)

;;; insert some records into a database
(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-put db '("test1" :foo "bar" "baz" "bam"))
    (db-put db '("test2" :foo "bar" "baz" "snafu"))
    (db-put db '("test3" :foo "baz" :first :next))
    (db-put db '("test3" :foo "baz" :first :last))))

;;; Search with one condition (returns multiple results)
(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-search db  '((:|cond| :foo "str" "bar")))))

;;; Search with multiple conditions. (this example returns one key)
(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-search db  '((:|cond| :foo   "str" "baz")
		     (:|cond| :first "str" :last)))))

(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (tcadb::db-simple-search db  '(:foo "baz" :first :last))))

;;; class to be used in examples
;;; Would be nice to take type in to account.
;;; and, how to deal with ID's
;;; Maybe ID = class-name+ID?




(def-db-class example-class ()
  ((id   :accessor id-of   :initarg :id :type :index)
   (foo  :accessor foo-of  :initarg :foo)
   (bar  :accessor bar-of  :initarg :bar)
   (test :accessor test-of :initarg :test)
   (dill :accessor dill-of :initarg :dill)))

 
 ;; This could be optimized

;; (format t "~/fqsn/" (type-of (make-instance 'tcadb-example::example-class)))




;; I'm thinking db structure like this
;;
;; KEY -> Objects:
;; NAME-OF-CLASS+id1+idn -> (:ID1 "id1" :IDn "idn" :SLOTS "values")
;; The key is compesed of the name of the class, and the ID's of the
;; class converted to string seperated by "+" (or some characther) in 
;; the order they are defined.

;;; Insert an object into database
(defun insert-example ()
  (let ((object (make-instance 'example-class :id 1 :foo "tofu" :bar "wisky")))
    (with-tcdb (db "/tmp/test1.tct")
      (with-transaction (db)
	(db-insert object)))))

;;; Search for objects in a database (return keys)
(defun search-example ()
  (let ((object (make-instance 'example-class :foo "tofu" :bar "wisky")))
    (with-tcdb (db "/tmp/test1.tct")
      (with-transaction (db)
	(db-find object)))))

;;; Fetch an object from a database
(defun fetch-example ()
  (let ((object (make-instance 'example-class :id 1)))
    (with-tcdb (db "/tmp/test1.tct")
      (with-transaction (db)
	(db-fetch object)))))


