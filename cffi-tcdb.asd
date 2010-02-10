;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cffi-tcdb
    :name "cffi-tcdb"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
    :description "Bindings for Tokyo Cabinet"
    :depends-on (:cffi :flexi-streams :cl-store)
    :components ((:module :src
			  :components ((:file "cffi-tcdb") 
				       (:file "tcutil-sys"    :depends-on ("cffi-tcdb"))
				       (:file "tcutil"    :depends-on ("tcutil-sys"))
				       (:file "tcadb-sys" :depends-on ("cffi-tcdb"))
				       (:file "tctdb-sys" :depends-on ("cffi-tcdb"))
				       (:file "tctdb"     :depends-on ("cffi-tcdb"))
				       (:file "tcadb"     :depends-on ("tcutil" "cffi-tcdb" "tcadb-sys"))))))

(asdf:defsystem cffi-tchdb
    :name "cffi-tchdb"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
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
    :licence "LLGPL"
    :description "Tests for tchdb"
    :depends-on (:cffi-tchdb :fiveam)
    :components ((:module :tests
			  :components ((:file "test")))))

(asdf:defsystem cffi-tchdb-examples
    :name "cffi-tchdb-examples"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
    :description "Examples for tchdb"
    :depends-on (:cffi-tchdb)
    :components ((:module :examples
			  :components ((:file "simple")))))


