;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;
;;; tchdb.lisp -- The lispy bindings
;;; 
;;; Copyright (c) 2010 by Knut Olav Bøhmer
;;; <bohmer@gmail.com>
;;;
;;; Users are granted the rights to distribute and use this software
;;; as governed by the terms of the Lisp Lesser GNU Public License
;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.

(defpackage #:tchdb
  (:use #:cl #:cl-store #:flexi-streams #:cffi-tchdb)
  (:export #:with-tchdb #:tc-put #:tc-get #:tcput #:tcget #:tchdb-restore #:tchdb-store))

(in-package #:tchdb)

(defmethod tc-put (db key val)
  (cffi-tchdb::tchdbput2 db key val))

(defmethod tc-get (db key)
  (cffi-tchdb::tchdbget2 db key))

(defmacro with-tchdb ((db path &optional (mode '(cffi-tchdb::HDBOWRITER cffi-tchdb::HDBOCREAT))) &body body)
  `(let ((,db (cffi-tchdb::tchdbnew)))
     (cffi-tchdb::tchdbopen ,db ,path (logior ,@mode))
     (unwind-protect 
	  (progn ,@body)
       (cffi-tchdb::tchdbclose ,db)
       (cffi-tchdb::tchdbdel ,db))))

(defun convert-to-seq (object)                 ;; rename to someting like make storeable vector (or something)
  (octets-to-string
   (with-output-to-sequence (store)       
     (store object store))))

(defun str-to-object (vector)   ;; TODO make in to multimethod and specialise on vector and string
  ;; and rename function to something more sane.
  (let ((vect (make-array (length vector) :fill-pointer t :adjustable t :initial-contents vector)))
    (with-input-from-sequence (s vect)
      (restore s))))

(defun string-to-vector (string)
  (let ((vec (string-to-octets string )))
    (cffi:foreign-alloc :unsigned-char
			:count (length vec)
			:initial-contents vec)))

(defmethod tcput-vector (db key-arg vector-arg) ;; TODO specialise on string and vector. 
  (let* ((key (string-to-vector key-arg))
	 (key-len (length key-arg))
	 (val (string-to-vector vector-arg))
	 (val-len (length vector-arg))
	 (done (cffi:pointer-address (cffi-tchdb::tchdbput db key key-len val val-len))))
    (case done
      (1 t)
      (0 nil))))

(defmethod tcget-vector (db key)         ;; TODO specialise on string and vector. 
  (let* ((dbkey (string-to-vector key))
	 (dbklen (length key))
	 (len (cffi:foreign-alloc :int))
	 (db-result (cffi-tchdb::tchdbget db dbkey dbklen len))
	 (result-len (cffi:mem-aref len :int))
	 (result-val (make-array result-len)))

    (loop for i below result-len
       do (setf (aref result-val i) (cffi:mem-aref db-result :unsigned-char i)))
    result-val))

(defun tchdb-store (db key  object) 
  (tcput-vector db key (convert-to-seq object)))

(defun tchdb-restore (db key)
  (str-to-object (tcget-vector db key)))

