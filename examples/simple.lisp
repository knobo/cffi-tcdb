(defpackage #:tchdb-simple-example
  (:use #:cl #:tchdb))

(in-package #:tchdb-simple-example)

(defclass test-class ()
  ((foo :accessor foo-of :initarg :foo :initform "testing foo")
   (bar :accessor bar-of :initarg :bar :initform "testing barå")))

(with-tchdb (db "/tmp/tch")
  (tcput-vector db "test" "1234123412341234")
  (octets-to-string (tcget-vector db "test")))

(with-tchdb (db-test "/tmp/tchdb")
  (tc-put db-test "foo" "baræøå")
  (tc-get db-test "foo"))

(with-tchdb (db-test "/tmp/tchdb")
  (let ((object (make-instance 'test-class)))
    (tchdb-store db-test "tofu" (list "æøåobject" object)) ;; æøå
    (tchdb-restore db-test "tofu")))


