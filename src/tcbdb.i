
%module "tcbdb-sys"

%insert("lisphead") %{ 
(defpackage #:tcbdb-sys
  (:use #:cl #:cffi))
(in-package :tcbdb-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tcbdb.h"



