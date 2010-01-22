;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cffi-tchdb
    :name "cffi-tchdb"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LGPL"
    :description "Bindings for Tokyo Cabinet"
    :depends-on (:cffi :flexi-streams :cl-store)
    :components ((:file "cffi-tchdb") (:file "tchdb")))


