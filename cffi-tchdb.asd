;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cffi-tchdb
    :name "cffi-tchdb"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LGPL"
    :description "Bindings for Tokyo Cabinet"
    :depends-on (:cffi :flexi-streams :cl-store)
    :components ((:module :src
			  :components ((:file "cffi-tchdb") 
				       (:file "tchdb" :depends-on ("cffi-tchdb"))))))
(asdf:defsystem cffi-tchdb-tests
    :name "cffi-tchdb-tests"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LGPL"
    :description "Tests for tchdb"
    :depends-on (:cffi-tchdb :fiveam)
    :components ((:module :tests
			  :components ((:file "test")))))

(asdf:defsystem cffi-tchdb-examples
    :name "cffi-tchdb-examples"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LGPL"
    :description "Examples for tchdb"
    :depends-on (:cffi-tchdb)
    :components ((:module :examples
			  :components ((:file "simple")))))


