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

(def-db-class example-class ()
  ((id   :accessor id-of   :initarg :id :type :index)
   (foo  :accessor foo-of  :initarg :foo)
   (bar  :accessor bar-of  :initarg :bar)
   (test :accessor test-of :initarg :test)
   (dill :accessor dill-of :initarg :dill)))

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


