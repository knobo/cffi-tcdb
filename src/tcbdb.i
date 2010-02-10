
%module "tcbdb-sys"

%insert("lisphead") %{ 
(defpackage #:tcbdb-sys
  (:use #:cl #:cffi))
(in-package :tcbdb-sys)
%} 

%typemap(cout) _Bool ":boolean";

%include "tokyocabinet/tcbdb.h"



