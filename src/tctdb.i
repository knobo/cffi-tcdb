
%module "tctdb-sys"

%insert("lisphead") %{  
(defpackage #:tctdb-sys
 (:use #:cl #:cffi))
(in-package :tctdb-sys)
%} 

%typemap(cout) _Bool ":boolean"



%include "missing.h"

%include "tokyocabinet/tcutil.h"
%include "tokyocabinet/tctdb.h"



