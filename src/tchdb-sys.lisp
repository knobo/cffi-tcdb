;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 1.3.40
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.
  
(defpackage #:tchdb-sys
 (:use #:cl #:cffi))
(in-package :tchdb-sys)



;;;SWIG wrapper code starts here

(cl:defmacro defanonenum (&body enums)
   "Converts anonymous enums to defconstants."
  `(cl:progn ,@(cl:loop for value in enums
                        for index = 0 then (cl:1+ index)
                        when (cl:listp value) do (cl:setf index (cl:second value)
                                                          value (cl:first value))
                        collect `(cl:defconstant ,value ,index))))

(cl:eval-when (:compile-toplevel :load-toplevel)
  (cl:unless (cl:fboundp 'swig-lispify)
    (cl:defun swig-lispify (name flag cl:&optional (package cl:*package*))
      (cl:labels ((helper (lst last rest cl:&aux (c (cl:car lst)))
                    (cl:cond
                      ((cl:null lst)
                       rest)
                      ((cl:upper-case-p c)
                       (helper (cl:cdr lst) 'upper
                               (cl:case last
                                 ((lower digit) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:lower-case-p c)
                       (helper (cl:cdr lst) 'lower (cl:cons (cl:char-upcase c) rest)))
                      ((cl:digit-char-p c)
                       (helper (cl:cdr lst) 'digit 
                               (cl:case last
                                 ((upper lower) (cl:list* c #\- rest))
                                 (cl:t (cl:cons c rest)))))
                      ((cl:char-equal c #\_)
                       (helper (cl:cdr lst) '_ (cl:cons #\- rest)))
                      (cl:t
                       (cl:error "Invalid character: ~A" c)))))
        (cl:let ((fix (cl:case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (cl:t ""))))
          (cl:intern
           (cl:concatenate
            'cl:string
            fix
            (cl:nreverse (helper (cl:concatenate 'cl:list name) cl:nil cl:nil))
            fix)
           package))))))

;;;SWIG wrapper code ends here


(cl:defconstant true 1)

(cl:defconstant false 0)

(cl:defconstant __bool_true_false_are_defined 1)

(cffi:defcstruct TCHDB
	(mmtx :pointer)
	(rmtxs :pointer)
	(dmtx :pointer)
	(tmtx :pointer)
	(wmtx :pointer)
	(eckey :pointer)
	(rpath :string)
	(type :pointer)
	(flags :pointer)
	(bnum :pointer)
	(apow :pointer)
	(fpow :pointer)
	(opts :pointer)
	(path :string)
	(fd :int)
	(omode :pointer)
	(rnum :pointer)
	(fsiz :pointer)
	(frec :pointer)
	(dfcur :pointer)
	(iter :pointer)
	(map :string)
	(msiz :pointer)
	(xmsiz :pointer)
	(xfsiz :pointer)
	(ba32 :pointer)
	(ba64 :pointer)
	(align :pointer)
	(runit :pointer)
	(zmode :pointer)
	(fbpmax :pointer)
	(fbpool :pointer)
	(fbpnum :pointer)
	(fbpmis :pointer)
	(async :pointer)
	(drpool :pointer)
	(drpdef :pointer)
	(drpoff :pointer)
	(recc :pointer)
	(rcnum :pointer)
	(enc :pointer)
	(encop :pointer)
	(dec :pointer)
	(decop :pointer)
	(ecode :int)
	(fatal :pointer)
	(inode :pointer)
	(mtime :pointer)
	(dfunit :pointer)
	(dfcnt :pointer)
	(tran :pointer)
	(walfd :int)
	(walend :pointer)
	(dbgfd :int)
	(cnt_writerec :pointer)
	(cnt_reuserec :pointer)
	(cnt_moverec :pointer)
	(cnt_readrec :pointer)
	(cnt_searchfbp :pointer)
	(cnt_insertfbp :pointer)
	(cnt_splicefbp :pointer)
	(cnt_dividefbp :pointer)
	(cnt_mergefbp :pointer)
	(cnt_reducefbp :pointer)
	(cnt_appenddrp :pointer)
	(cnt_deferdrp :pointer)
	(cnt_flushdrp :pointer)
	(cnt_adjrecc :pointer)
	(cnt_defrag :pointer)
	(cnt_shiftrec :pointer)
	(cnt_trunc :pointer))

(defanonenum 
	(HDBFOPEN #.(cl:ash 1 0))
	(HDBFFATAL #.(cl:ash 1 1)))

(defanonenum 
	(HDBTLARGE #.(cl:ash 1 0))
	(HDBTDEFLATE #.(cl:ash 1 1))
	(HDBTBZIP #.(cl:ash 1 2))
	(HDBTTCBS #.(cl:ash 1 3))
	(HDBTEXCODEC #.(cl:ash 1 4)))

(defanonenum 
	(HDBOREADER #.(cl:ash 1 0))
	(HDBOWRITER #.(cl:ash 1 1))
	(HDBOCREAT #.(cl:ash 1 2))
	(HDBOTRUNC #.(cl:ash 1 3))
	(HDBONOLCK #.(cl:ash 1 4))
	(HDBOLCKNB #.(cl:ash 1 5))
	(HDBOTSYNC #.(cl:ash 1 6)))

(cffi:defcfun ("tchdberrmsg" tchdberrmsg) :string
  (ecode :int))

(cffi:defcfun ("tchdbnew" tchdbnew) :pointer)

(cffi:defcfun ("tchdbdel" tchdbdel) :void
  (hdb :pointer))

(cffi:defcfun ("tchdbecode" tchdbecode) :int
  (hdb :pointer))

(cffi:defcfun ("tchdbsetmutex" tchdbsetmutex) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbtune" tchdbtune) :boolean
  (hdb :pointer)
  (bnum :pointer)
  (apow :pointer)
  (fpow :pointer)
  (opts :pointer))

(cffi:defcfun ("tchdbsetcache" tchdbsetcache) :boolean
  (hdb :pointer)
  (rcnum :pointer))

(cffi:defcfun ("tchdbsetxmsiz" tchdbsetxmsiz) :boolean
  (hdb :pointer)
  (xmsiz :pointer))

(cffi:defcfun ("tchdbsetdfunit" tchdbsetdfunit) :boolean
  (hdb :pointer)
  (dfunit :pointer))

(cffi:defcfun ("tchdbopen" tchdbopen) :boolean
  (hdb :pointer)
  (path :string)
  (omode :int))

(cffi:defcfun ("tchdbclose" tchdbclose) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbput" tchdbput) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cffi:defcfun ("tchdbput2" tchdbput2) :boolean
  (hdb :pointer)
  (kstr :string)
  (vstr :string))

(cffi:defcfun ("tchdbputkeep" tchdbputkeep) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cffi:defcfun ("tchdbputkeep2" tchdbputkeep2) :boolean
  (hdb :pointer)
  (kstr :string)
  (vstr :string))

(cffi:defcfun ("tchdbputcat" tchdbputcat) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cffi:defcfun ("tchdbputcat2" tchdbputcat2) :boolean
  (hdb :pointer)
  (kstr :string)
  (vstr :string))

(cffi:defcfun ("tchdbputasync" tchdbputasync) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cffi:defcfun ("tchdbputasync2" tchdbputasync2) :boolean
  (hdb :pointer)
  (kstr :string)
  (vstr :string))

(cffi:defcfun ("tchdbout" tchdbout) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int))

(cffi:defcfun ("tchdbout2" tchdbout2) :boolean
  (hdb :pointer)
  (kstr :string))

(cffi:defcfun ("tchdbget" tchdbget) :pointer
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (sp :pointer))

(cffi:defcfun ("tchdbget2" tchdbget2) :string
  (hdb :pointer)
  (kstr :string))

(cffi:defcfun ("tchdbget3" tchdbget3) :int
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (max :int))

(cffi:defcfun ("tchdbvsiz" tchdbvsiz) :int
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int))

(cffi:defcfun ("tchdbvsiz2" tchdbvsiz2) :int
  (hdb :pointer)
  (kstr :string))

(cffi:defcfun ("tchdbiterinit" tchdbiterinit) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbiternext" tchdbiternext) :pointer
  (hdb :pointer)
  (sp :pointer))

(cffi:defcfun ("tchdbiternext2" tchdbiternext2) :string
  (hdb :pointer))

(cffi:defcfun ("tchdbiternext3" tchdbiternext3) :boolean
  (hdb :pointer)
  (kxstr :pointer)
  (vxstr :pointer))

(cffi:defcfun ("tchdbfwmkeys" tchdbfwmkeys) :pointer
  (hdb :pointer)
  (pbuf :pointer)
  (psiz :int)
  (max :int))

(cffi:defcfun ("tchdbfwmkeys2" tchdbfwmkeys2) :pointer
  (hdb :pointer)
  (pstr :string)
  (max :int))

(cffi:defcfun ("tchdbaddint" tchdbaddint) :int
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (num :int))

(cffi:defcfun ("tchdbadddouble" tchdbadddouble) :double
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (num :double))

(cffi:defcfun ("tchdbsync" tchdbsync) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdboptimize" tchdboptimize) :boolean
  (hdb :pointer)
  (bnum :pointer)
  (apow :pointer)
  (fpow :pointer)
  (opts :pointer))

(cffi:defcfun ("tchdbvanish" tchdbvanish) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbcopy" tchdbcopy) :boolean
  (hdb :pointer)
  (path :string))

(cffi:defcfun ("tchdbtranbegin" tchdbtranbegin) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbtrancommit" tchdbtrancommit) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbtranabort" tchdbtranabort) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbpath" tchdbpath) :string
  (hdb :pointer))

(cffi:defcfun ("tchdbrnum" tchdbrnum) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbfsiz" tchdbfsiz) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbsetecode" tchdbsetecode) :void
  (hdb :pointer)
  (ecode :int)
  (filename :string)
  (line :int)
  (func :string))

(cffi:defcfun ("tchdbsettype" tchdbsettype) :void
  (hdb :pointer)
  (type :pointer))

(cffi:defcfun ("tchdbsetdbgfd" tchdbsetdbgfd) :void
  (hdb :pointer)
  (fd :int))

(cffi:defcfun ("tchdbdbgfd" tchdbdbgfd) :int
  (hdb :pointer))

(cffi:defcfun ("tchdbhasmutex" tchdbhasmutex) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbmemsync" tchdbmemsync) :boolean
  (hdb :pointer)
  (phys :pointer))

(cffi:defcfun ("tchdbcacheclear" tchdbcacheclear) :boolean
  (hdb :pointer))

(cffi:defcfun ("tchdbbnum" tchdbbnum) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbalign" tchdbalign) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbfbpmax" tchdbfbpmax) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbxmsiz" tchdbxmsiz) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbinode" tchdbinode) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbmtime" tchdbmtime) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbomode" tchdbomode) :int
  (hdb :pointer))

(cffi:defcfun ("tchdbtype" tchdbtype) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbflags" tchdbflags) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbopts" tchdbopts) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbopaque" tchdbopaque) :string
  (hdb :pointer))

(cffi:defcfun ("tchdbbnumused" tchdbbnumused) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbsetcodecfunc" tchdbsetcodecfunc) :boolean
  (hdb :pointer)
  (enc :pointer)
  (encop :pointer)
  (dec :pointer)
  (decop :pointer))

(cffi:defcfun ("tchdbcodecfunc" tchdbcodecfunc) :void
  (hdb :pointer)
  (ep :pointer)
  (eop :pointer)
  (dp :pointer)
  (dop :pointer))

(cffi:defcfun ("tchdbdfunit" tchdbdfunit) :pointer
  (hdb :pointer))

(cffi:defcfun ("tchdbdefrag" tchdbdefrag) :boolean
  (hdb :pointer)
  (step :pointer))

(cffi:defcfun ("tchdbputproc" tchdbputproc) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int)
  (proc :pointer)
  (op :pointer))

(cffi:defcfun ("tchdbgetnext" tchdbgetnext) :pointer
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (sp :pointer))

(cffi:defcfun ("tchdbgetnext2" tchdbgetnext2) :string
  (hdb :pointer)
  (kstr :string))

(cffi:defcfun ("tchdbgetnext3" tchdbgetnext3) :string
  (hdb :pointer)
  (kbuf :string)
  (ksiz :int)
  (sp :pointer)
  (vbp :pointer)
  (vsp :pointer))

(cffi:defcfun ("tchdbiterinit2" tchdbiterinit2) :boolean
  (hdb :pointer)
  (kbuf :pointer)
  (ksiz :int))

(cffi:defcfun ("tchdbiterinit3" tchdbiterinit3) :boolean
  (hdb :pointer)
  (kstr :string))

(cffi:defcfun ("tchdbforeach" tchdbforeach) :boolean
  (hdb :pointer)
  (iter :pointer)
  (op :pointer))

(cffi:defcfun ("tchdbtranvoid" tchdbtranvoid) :boolean
  (hdb :pointer))


