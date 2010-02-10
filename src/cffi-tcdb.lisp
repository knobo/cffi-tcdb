;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;
;;; cffi-tchdb.lisp -- The cffi-interface
;;; 
;;; Copyright (c) 2010 by Knut Olav Bøhmer
;;; <bohmer@gmail.com>
;;;
;;; Users are granted the rights to distribute and use this software
;;; as governed by the terms of the Lisp Lesser GNU Public License
;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.
;;;
;;;

(defpackage #:tcdb
  (:use #:common-lisp #:cffi)) ;;   (:export )

(in-package #:tcdb)

(define-foreign-library tokyocabinet
  (:unix (:or "libtokyocabinet.so.8" "libtokyocabinet.so"))
  (t (:default "libtokyocabinet")))

(use-foreign-library tokyocabinet)

(defclass tcdb ()
  ((db   :accessor db-of   :initarg :db   :initform nil)
   (file :accessor file-of :initarg :file :initform (error 'must-specify-db))))

#|(defmacro with-tchdb ((db path &optional (mode '(cffi-tchdb::HDBOWRITER cffi-tchdb::HDBOCREAT))) &body body)
  `(let ((,db (cffi-tchdb::tchdbnew)))
     (cffi-tchdb::tchdbopen ,db ,path (logior ,@mode))
     (unwind-protect 
          (progn ,@body)
       (cffi-tchdb::tchdbclose ,db)
       (cffi-tchdb::tchdbdel ,db))))|#

