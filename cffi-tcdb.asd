;;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Base: 10 -*-

(asdf:defsystem cffi-tcdb
    :name "cffi-tcdb"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
    :description "Bindings for Tokyo Cabinet"
    :depends-on (:cffi :flexi-streams :cl-store :moptilities)
    :components ((:module :src
			  :components ((:file "cffi-tcdb") 
				       (:file "tcutil-sys"    :depends-on ("cffi-tcdb"))
				       (:file "tcutil"    :depends-on ("tcutil-sys"))
				       (:file "tcadb-sys" :depends-on ("cffi-tcdb"))
				       (:file "tctdb-sys" :depends-on ("cffi-tcdb"))
				       (:file "tctdb"     :depends-on ("tctdb-sys"))
				       (:file "tcadb"     :depends-on ("tcutil" "cffi-tcdb" "tcadb-sys" "tctdb-sys"))
				       (:file "tcadb-object-db" :depends-on ("tcadb"))))))

(asdf:defsystem tcadb-examples
    :name "tcadb-examples"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
    :description "Examples of Bindings for Tokyo Cabinet Abstract API"
    :depends-on (:cffi-tcdb)
    :components ((:module :examples
			  :components ((:file "tchdb-examples")))))

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

(asdf:defsystem cffi-tcadb-examples
    :name "cffi-tchdb-examples"
    :version "0.0.1"
    :maintainer "bohmer@gmail.com"
    :author "bohmer@gmail.com"
    :licence "LLGPL"
    :description "Examples for tcadb"
    :depends-on (:cffi-tchdb)
    :components ((:module :examples
			  :components ((:file "objects")
				       (:file "tcadb-example")))))


