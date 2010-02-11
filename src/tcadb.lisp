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
  (:use #:cl #:cffi))

(in-package :tcadb)

(declaim (optimize debug))

(defparameter *default-db-name* "*")

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
  `(let ((,db (tcadb-sys::tcadbnew)))
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

(defmethod table-store ((item list))
  (format t "~{~s	~s~}" item))

(defmethod tcget-vector :around ((key string) db &key (return-element-type :char))
  "Wrapping string keys. Probably this peaple are going to use"
  (cffi:with-foreign-string  ((foreign-string size) key)
    (multiple-value-bind (value-ptr length) 
	(tcget-vector foreign-string db :size size)
      (convert-from-foreign value-ptr `(:array ,return-element-type ,length)))))

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

