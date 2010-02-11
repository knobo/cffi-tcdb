
%module "tcutil-sys"

%insert("lisphead") %{  
(defpackage #:tcutil-sys
 (:use #:cl #:cffi))
(in-package :tcutil-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tcutil.h"



