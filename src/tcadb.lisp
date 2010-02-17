;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;
;;; tcadb.lisp -- Interface for The Abstract Database API of Tokyo
;;; Cabinet
;;; 
;;; Copyright (c) 2010 by Knut Olav Bøhmer
;;; <bohmer@gmail.com>
;;;
;;; Users are granted the rights to distribute and use this software
;;; as governed by the terms of the Lisp Lesser GNU Public License
;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.
;;;
;;;

(defpackage #:tcadb
  (:use #:cl #:cffi)
  (:export #:with-tcdb #:with-transaction #:tcget-vector #:db-put #:db-search #:db-get)) 


(in-package :tcadb)

(declaim (optimize debug))

(defparameter *default-db-name* "*")
(defparameter *db* nil)


(defclass tcadb (tcdb::tcdb)
  ((db :accessor db-of     :initarg :db   :initform nil)
   (file :accessor file-of :initarg :file :initform *default-db-name*)))

(defun opendb (db path)
  (let ((openstatus (tcadb-sys::tcadbopen db path)))
    (unless openstatus
      (let ((ecode (tcutil:errormsg db)))
	(error "~a" (tcutil-sys::tcerrmsg ecode))))))

(defmacro with-tcdb ((db path &key mode) &body body)
  "mode is not used here. Just here for compability with other
modules. Use #name=value appended to path"
  (declare (ignorable mode))
  `(let* ((,db (tcadb-sys::tcadbnew))
	  (*db* ,db))
     (declare (special *db*))
     (opendb ,db ,path)
     (unwind-protect
          (progn ,@body)
       (tcadb-sys::tcadbclose ,db)
       (tcadb-sys::tcadbdel ,db))))

(defmacro with-transaction ((db) &body body)
  `(progn
     (tcadb-sys::tcadbtranbegin ,db)
     (handler-case
	 (progn ,@body)
       (error (err)
	 (tcadb-sys::tcadbtranabort ,db)
	 (error err))
       (:no-error (&rest args)
	 (tcadb-sys::tcadbtrancommit ,db)
	 (apply 'values args)))))


(defmethod tcmkmap ((list list))
  (let* ((length (/ (length list) 2))
	 (map (tcutil-sys::tcmapnew2 length)))
    (loop for (key val) on list by #'cddr
       do (tcutil-sys::tcmapput2 map (format nil "~a" key)  (format nil "~a" val)))
    map))

(defmethod tclistpush2 (list (element string))
  (tcutil-sys::tclistpush2 list element))

(defmethod tclistpush2 (list (element symbol))
  (tcutil-sys::tclistpush2 list (symbol-name element)))

(defmethod tclistpush2 (list element)
  (tcutil-sys::tclistpush2 list element))

(defmethod tclistpush2 (list (element fixnum))
  (tcutil-sys::tclistpush2 list (format nil "~a" element)))

(defmethod tclist (list)
  (let ((tclist (tcutil-sys::tclistnew)))
    (loop for element in list
       do (tclistpush2 tclist element))
    tclist))

(defmethod db-put (db (list list))
  (db-misc db "put" (tclist list)))

(defmethod db-get (db (list list))
  (db-misc db "get" (tclist list)))

(defmethod db-search (db (list list))
  (let ((tclist (tcutil-sys::tclistnew)))
    (with-foreign-object (size-ptr :int)
      (loop 
	 for qrycond in list
	 for array-ptr = (tcutil-sys::tcstrjoin2 (tclist qrycond) size-ptr)
	 for size = (mem-aref size-ptr :int)
	 do (tcutil-sys::tclistpush tclist array-ptr size)))
    (db-misc db "search" tclist)))

(defmethod db-misc (db op tclist)
  (unwind-protect
       (let ((result (tcadb-sys::tcadbmisc db op tclist)))
	 (loop for i below  (tcutil-sys::tclistnum result)
	    collect (tcutil-sys::tclistval2 result i)))
    (tcutil-sys::tclistdel tclist)))

(defmethod tcget-vector :around ((key string) db &key (return-element-type :char))
  "Wrapping string keys. Probably this peaple are going to use"
  (cffi:with-foreign-string  ((foreign-string size) key)
    (multiple-value-bind (value-ptr length) 
	(tcget-vector foreign-string db :size size)
      (case return-element-type
	(:string (convert-from-foreign value-ptr :string))
	(t (convert-from-foreign value-ptr `(:array ,return-element-type ,length)))))))

(defmethod tcget-vector (key db &key (size 0)) 
  "Used to get records. Key must be of foreign pointer type. Maybe I'll do etypecase later (I love typecase)"
  (assert (typep key 'cffi:foreign-pointer) (key))
  (cffi:with-foreign-object (length :int)
    (values 
     (tcadb-sys::tcadbget db key size length)
     (cffi:mem-aref length :int 0))))

(defun tcget (key db &optional (default nil))
  "Used to get strings
same interface as gethash, maybe it shoulod be called get2tcadb (no!)
Please, help me with the naming convetion"
  (declare (ignore default))
  (tcadb-sys::tcadbget2 db key))

(defmethod (setf tcget-vector) ((val string) (key string) db)
  "why not just use tcget2?"
  (with-foreign-strings (((key-ptr k-length) key) ((val-ptr v-length) val))
    (tcadb-sys::tcadbput db key-ptr k-length val-ptr v-length)))

(defmethod (setf tcget-vector) ((val array) (key string) db)
  "Still assuming keys to be strings."
  (assert (typep val '(array (unsigned-byte 8))) (val)) ;; or (coerce val '(array  (unsigned-byte 8))) ?
  (with-foreign-string ((key-ptr k-length) key)
    (let* ((v-length (length val))
	   (val-ptr (cffi:convert-to-foreign val `(:array :char ,v-length))))
      (unwind-protect
	   (tcadb-sys::tcadbput db key-ptr k-length val-ptr v-length)
	(cffi:foreign-free val-ptr)))))

(defmethod (setf tcget) (val key db)
  (tcadb-sys::tcadbput2 db key val))

