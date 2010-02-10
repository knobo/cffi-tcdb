
%module "tchdb-sys"

%insert("lisphead") %{  
(defpackage #:tchdb-sys
 (:use #:cl #:cffi))
(in-package :tchdb-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "tokyocabinet/tchdb.h"



