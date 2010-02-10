
%module "tcadb-sys"

%insert("lisphead") %{ 
(defpackage #:tcadb-sys
 (:use #:cl #:cffi))
(in-package :tcadb-sys)
%}

%typemap(cout) _Bool ":boolean";

%feature("export");

%include "tokyocabinet/tcadb.h"



