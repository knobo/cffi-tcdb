(defpackage #:tcdb-tests
  (:use #:cl #:tcdb #:fiveam)
  (:export :test-tcdb))

(in-package #:tcdb-tests)

(def-suite test-db :description "testing the database")
(in-suite test-db)

(def-fixture dbx/fixture ()
  (with-tcdb (db "/tmp/test-db")
    (&body)))

(test sore-object 
      "First test" 
      (with-fixture dbx/fixture ()
		    ))

(test sore-utf-8-object 
      "First test"
      (is (string-equal (store-restore-object "æøå")
			"æøå")))

(defun test-tcdb ()
  (explain! (run 'test-db)))
