
%module "tctdb-sys"

%insert("lisphead") %{  
(defpackage #:tctdb-sys
 (:use #:cl #:cffi))
(in-package :tctdb-sys)
%} 

%typemap(cout) _Bool ":boolean"
%typemap(cout) _uint32_t ":unsigned-int";


%include "missing.h"

%include "/usr/lib/gcc/i486-linux-gnu/4.4/include/stdbool.h"
%include "tokyocabinet/tcutil.h"
%include "tokyocabinet/tctdb.h"



