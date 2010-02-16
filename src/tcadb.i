
%module "tcadb-sys"

%insert("lisphead") %{ 
(defpackage #:tcadb-sys
 (:use #:cl #:cffi))
(in-package :tcadb-sys)
%}

%typemap(cout) _Bool ":boolean";
%typemap(cout) _uint32_t ":unsigned-int";

%feature("export");

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tcadb.h"



