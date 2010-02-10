
%module "tcutil-sys"

%insert("lisphead") %{  
(defpackage #:tcutil-sys
 (:use #:cl #:cffi))
(in-package :tcutil-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "tokyocabinet/tcutil.h"



