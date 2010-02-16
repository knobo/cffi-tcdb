
%module "tchdb-sys"

%insert("lisphead") %{  
(defpackage #:tchdb-sys
 (:use #:cl #:cffi))
(in-package :tchdb-sys)
%} 

%typemap(cout) _Bool ":boolean";
%typemap(cout) _uint32_t ":unsigned-int";

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tchdb.h"



