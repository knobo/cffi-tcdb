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
  (:export #:tchdb-restore #:tchdb-store))

(in-package #:tchdb)

(defmethod tc-put (db key val)
  (cffi-tchdb::tchdbput2 db key val))

(defmethod tc-get (db key)
  (cffi-tchdb::tchdbget2 db key))

(defun convert-to-seq (object)                 ;; rename to someting like make storeable vector (or something)
  (octets-to-string
   (with-output-to-sequence (store)
     (store object store))))

(defun tchdb-store (db key  object) 
  (tcput-vector db key (convert-to-seq object)))

(defun tchdb-restore (db key)
  (str-to-object (tcget-vector db key)))

