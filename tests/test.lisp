(defpackage #:tchdb-tests
  (:use #:cl #:tchdb #:fiveam)
  (:export :test-tchdb))

(in-package #:tchdb-tests)

(defclass empty-test-object ()
  ())

(defparameter *empty-test-object* (make-instance 'empty-test-object))

(defun store-restore-object (object)
  (with-tchdb (db "/tmp/test-db")
    (tchdb-store db "test" object)
    (tchdb-restore db "test")))

(def-suite test-db :description "testing the database")
(in-suite test-db)

(def-fixture dbx/fixture ()
  (with-tchdb (db "/tmp/test-db")
    (&body)))


(test sore-object 
  "First test" 
  (with-fixture dbx/fixture ()
    (is (eql (type-of (tchdb-store db "test" *empty-test-object*))
	     (type-of (tchdb-restore db "test"))))))

(test sore-utf-8-object 
  "First test"
  (is (string-equal (store-restore-object "æøå")
		    "æøå")))

(defun test-tchdb ()
  (explain! (run 'test-db)))
