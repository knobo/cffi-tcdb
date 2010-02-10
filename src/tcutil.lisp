(defpackage #:tcutil
  (:use #:cl #:tcutil-sys)
  (:export :errormsg))

(in-package #:tcutil)

(defun errormsg (ecode) 
  (tcutil-sys::tcerrmsg ecode))
