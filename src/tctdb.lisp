(defpackage #:tctdb
  (:use #:cl #:tctdb-sys))

(in-package #:tctdb)



(defmethod query (db query &key (limit nil) (skip 0))
  (declare (optimize (debug 3)))
  (let ((qry (tctdb-sys::tctdbqrynew db)))
    (loop
       for (name op exp) on query by #'cdddr
       for opid = (tctdb-sys::tctdbqrystrtocondop op)
       do (tctdb-sys::tctdbqryaddcond qry name opid exp))
    (when limit
      (tctdb-sys::tctdbqrysetlimit qry limit skip))
    (let ((res (tctdb-sys::tctdbqrysearch qry)))
      (loop
	 for i below  (tctdb-sys::tclistnum res)
	 for cols = (get-listval db res i)
	 when cols
	 collect (itercols cols)
	 and
	 do (tctdb-sys::tcmapdel cols))
      (tctdb-sys::tclistdel res))
    (tctdb-sys::tclistdel qry)))

(defun itercols (cols)
  (tctdb-sys::tcmapiterinit cols)
  (loop for name = (tctdb-sys::tcmapiternext2 cols)
       while name
     collect (list name (tctdb-sys::tcmapget2 cols name))))

(defmethod table-store3 (db key val) 
  (unless (tctdb-sys::tctdbput3 db key (format nil "~{~a	search~a~^	~}" val)) ;; maybe us tcadbput
    (error (tcutil:errormsg db))))

(defun get-listval (db list i)
  (with-foreign-object (rsiz :int)
    (let ((rbuf (tctdb-sys::tclistval list i rsiz)))
      (tctdb-sys::tctdbget db rbuf (mem-aref rsiz :int)))))