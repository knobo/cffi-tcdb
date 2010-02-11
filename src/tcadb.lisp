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

(in-package #:tcadb)

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
  (let ((result (gensym "result")))
    `(let ((,result))
       (tcadb-sys::tcadbtranbegin ,db)
       (handler-case
	   (setf ,result (progn ,@body))
	 (error (tcadb-sys::tcadbtranabort ,db))
	 (:no-error (tcadb-sys::tcadbtrancommit ,db)))  
       ,result)))

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
  (assert (typep key 'cffi:foreign-pointer) key)
  (cffi:with-foreign-object (length :int)
    (values 
     (tcadb-sys::tcadbget db key size length)
     (cffi:mem-aref len :int 0))))

(defun tcget2 (key db &optional (default nil))
  "Used to get strings
same interface as gethash, maybe it shoulod be called get2tcadb (no!)
Please, help me with the naming convetion"
  (declare (ignore default))
  (tcadb-sys::tcadbget2 db key))

(defun (setf tcget-vector) (val key db)
  (with-foreign-strings ((keyp key) (valp val))
    (tcadb-sys::tcadbput db keyp (length key) valp (length val))))

(defun (setf tcget2) (val key db)
  (tcadb-sys::tcadbput2 db key val))



