
%module "tchdb-sys"

%insert("lisphead") %{  
(defpackage #:tchdb-sys
 (:use #:cl #:cffi))
(in-package :tchdb-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tchdb.h"



