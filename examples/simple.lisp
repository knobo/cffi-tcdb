(defpackage #:tchdb-simple-example
  (:use #:cl #:tchdb)
  (:export :test-class :vector-key-value :cl-store-object))

(in-package #:tchdb-simple-example)

(defclass test-class ()
  ((foo :accessor foo-of :initarg :foo :initform "testing foo")
   (bar :accessor bar-of :initarg :bar :initform "testing barå")))

(defun simple-key-value ()
    (with-tchdb (db-test "/tmp/tchdb")
      (tc-put db-test "foo" "baræøå")
      (tc-get db-test "foo")))

(defun vector-key-value ()
  (with-tchdb (db "/tmp/tch")
    (tcput-vector db "test" "1234123412341234")
    (octets-to-string (tcget-vector db "test"))))

(defun cl-store-object ()
  (with-tchdb (db-test "/tmp/tchdb")
    (let ((object (make-instance 'test-class)))
      (tchdb-store db-test "tofu" (list "æøåobject" object)) ;; æøå
      (tchdb-restore db-test "tofu"))))


