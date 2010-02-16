(defpackage #:tcdb-object-example
  (:use #:cl #:tcadb #:cl-store #:flexi-streams)
  (:export #:test-class #:vector-key-value #:cl-store-object))

(in-package #:tcdb-object-example)

(defclass test-class ()
  ((foo :accessor foo-of :initarg :foo :initform "testing foo")
   (bar :accessor bar-of :initarg :bar :initform "testing barå")))

(defun vector-key-value ()
  (with-tcdb (db "/tmp/test2.tch")
    (with-transaction (db)
      (setf (tcget-vector "testæøå" db) "123123123æøå")
      (tcget-vector "testæøå" db :return-element-type :string))))

(defun db-store (db key object)
  (setf (tcget-vector key db)
	(string-to-octets
	 (with-output-to-sequence (store)
	   (store object store)))))

(defun db-restore (db key) 
  (let* ((array (tcget-vector key db :return-element-type :unsigned-char))
	 (vect (make-array (length array)
			   :element-type  '(unsigned-byte 8)
			   :fill-pointer t :adjustable t
			   :initial-contents array)))
    (with-input-from-sequence (s vect)
      (restore s))))

(defun cl-store-object ()
  (with-tcdb (db-test "/tmp/test3.tch")
    (let ((object (make-instance 'test-class)))
      (db-store db-test "tofu" (list "object"))
      ;; I don't understand why this does not work
      ;; There is something about converting to and from (byte 8)
      (db-restore db-test "tofu"))))


