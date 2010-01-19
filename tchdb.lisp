(defpackage #:tchdb
  (:use #:cl #:cl-store #:flexi-streams))

(in-package #:tchdb)

(defmethod tc-put (db key val)
  (cl-tc.tc-sys::tchdbput2 db key val))

(defmethod tc-get (db key)
  (cl-tc.tc-sys::tchdbget2 db key))

(defmacro with-tchdb ((db path &optional (mode '(cl-tc.tc-sys::HDBOWRITER cl-tc.tc-sys::HDBOCREAT))) &body body)
  `(let ((,db (cl-tc.tc-sys::tchdbnew)))
     (cl-tc.tc-sys::tchdbopen ,db ,path (logior ,@mode))
     (unwind-protect 
	  (progn ,@body)
       (cl-tc.tc-sys::tchdbclose ,db))))

(defun convert-to-seq (object)
  (octets-to-string
   (with-output-to-sequence (store)
     (store object store))))

(defun str-to-object (vector)
  (with-input-from-sequence (s vector)
    (restore s)))

(defvar *knobo* nil)

(defun mk-vec (vec)
  (cffi:foreign-alloc :char
		      :count (length vec)
		      :initial-contents (string-to-octets vec))) ;;

(defun tcput (db key-arg vector-arg)
  (let* ((key (mk-vec key-arg))
	 (key-len (length key-arg))
	 (val (mk-vec vector-arg))
	 (val-len (length vector-arg))
	 (done (cffi:pointer-address (cl-tc.tc-sys::tchdbput db key key-len val val-len))))
    (case done
      (1 t)
      (0 nil))))

(defun tcget (db key)
  (let* ((dbkey (mk-vec key))
	 (dbklen (length key))
	 (len (cffi:foreign-alloc :int))
	 (db-result (cl-tc.tc-sys::tchdbget db dbkey dbklen len))
	 (result-len (cffi:mem-aref len :int))
	 (result-val (make-array result-len)))

    (loop for i below result-len
       do (setf (aref result-val i) (cffi:mem-aref db-result :char i)))
    result-val))

(defun tchdb-store (db key  object) 
  (tcput db key (convert-to-seq object)))

(defun tchdb-restore (db key)
  (str-to-object (tcget db key)))

(defclass test-class ()
  ((foo :accessor foo-of :initarg :foo :initform "testing foo")
   (bar :accessor bar-of :initarg :bar :initform "testing bar")))

(with-tchdb (db "/tmp/tch")
  (tcput db "test" "1234123412341234")
  (tcget db "test"))

(with-tchdb (db-test "/home/knobo/temp/tchdb")
  (tc-put db-test "foo" "bar")
  (tc-get db-test "foo"))

(with-tchdb (db-test "/home/knobo/temp/tchdb")
   (let ((object (make-instance 'test-class)))
     (tchdb-store db-test "foo" (list "abcdefghijklmnopqrstuvwxyz" :knobo object :test object)) ;; æøå
     (tchdb-restore db-test "foo")))


(with-tchdb (db-test "/home/knobo/temp/tchdb")
  (tchdb-store db-test "foo" "xsssabcd")
  (format t "---~s---~%" (ignore-errors (tchdb-restore db-test "foo")))
  (tchdb-restore db-test "foo"))
