;;; This file was automatically generated by SWIG (http://www.swig.org).
;;; Version 1.3.40
;;;
;;; Do not make changes to this file unless you know what you are doing--modify
;;; the SWIG interface file instead.
 
(defpackage #:tcadb-sys
 (:use #:cl #:cffi))
(in-package :tcadb-sys)



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

(cl:export 'true)

(cl:defconstant false 0)

(cl:export 'false)

(cl:defconstant __bool_true_false_are_defined 1)

(cl:export '__bool_true_false_are_defined)

(cffi:defcstruct TCADB
	(omode :int)
	(mdb :pointer)
	(ndb :pointer)
	(hdb :pointer)
	(bdb :pointer)
	(fdb :pointer)
	(tdb :pointer)
	(capnum :pointer)
	(capsiz :pointer)
	(capcnt :pointer)
	(cur :pointer)
	(skel :pointer))

(cl:export 'TCADB)

(cl:export 'omode)

(cl:export 'mdb)

(cl:export 'ndb)

(cl:export 'hdb)

(cl:export 'bdb)

(cl:export 'fdb)

(cl:export 'tdb)

(cl:export 'capnum)

(cl:export 'capsiz)

(cl:export 'capcnt)

(cl:export 'cur)

(cl:export 'skel)

(defanonenum 
	ADBOVOID
	ADBOMDB
	ADBONDB
	ADBOHDB
	ADBOBDB
	ADBOFDB
	ADBOTDB
	ADBOSKEL)

(cl:export 'ADBOVOID)

(cl:export 'ADBOMDB)

(cl:export 'ADBONDB)

(cl:export 'ADBOHDB)

(cl:export 'ADBOBDB)

(cl:export 'ADBOFDB)

(cl:export 'ADBOTDB)

(cl:export 'ADBOSKEL)

(cffi:defcfun ("tcadbnew" tcadbnew) :pointer)

(cl:export 'tcadbnew)

(cffi:defcfun ("tcadbdel" tcadbdel) :void
  (adb :pointer))

(cl:export 'tcadbdel)

(cffi:defcfun ("tcadbopen" tcadbopen) :boolean
  (adb :pointer)
  (name :string))

(cl:export 'tcadbopen)

(cffi:defcfun ("tcadbclose" tcadbclose) :boolean
  (adb :pointer))

(cl:export 'tcadbclose)

(cffi:defcfun ("tcadbput" tcadbput) :boolean
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cl:export 'tcadbput)

(cffi:defcfun ("tcadbput2" tcadbput2) :boolean
  (adb :pointer)
  (kstr :string)
  (vstr :string))

(cl:export 'tcadbput2)

(cffi:defcfun ("tcadbputkeep" tcadbputkeep) :boolean
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cl:export 'tcadbputkeep)

(cffi:defcfun ("tcadbputkeep2" tcadbputkeep2) :boolean
  (adb :pointer)
  (kstr :string)
  (vstr :string))

(cl:export 'tcadbputkeep2)

(cffi:defcfun ("tcadbputcat" tcadbputcat) :boolean
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int))

(cl:export 'tcadbputcat)

(cffi:defcfun ("tcadbputcat2" tcadbputcat2) :boolean
  (adb :pointer)
  (kstr :string)
  (vstr :string))

(cl:export 'tcadbputcat2)

(cffi:defcfun ("tcadbout" tcadbout) :boolean
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int))

(cl:export 'tcadbout)

(cffi:defcfun ("tcadbout2" tcadbout2) :boolean
  (adb :pointer)
  (kstr :string))

(cl:export 'tcadbout2)

(cffi:defcfun ("tcadbget" tcadbget) :pointer
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (sp :pointer))

(cl:export 'tcadbget)

(cffi:defcfun ("tcadbget2" tcadbget2) :string
  (adb :pointer)
  (kstr :string))

(cl:export 'tcadbget2)

(cffi:defcfun ("tcadbvsiz" tcadbvsiz) :int
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int))

(cl:export 'tcadbvsiz)

(cffi:defcfun ("tcadbvsiz2" tcadbvsiz2) :int
  (adb :pointer)
  (kstr :string))

(cl:export 'tcadbvsiz2)

(cffi:defcfun ("tcadbiterinit" tcadbiterinit) :boolean
  (adb :pointer))

(cl:export 'tcadbiterinit)

(cffi:defcfun ("tcadbiternext" tcadbiternext) :pointer
  (adb :pointer)
  (sp :pointer))

(cl:export 'tcadbiternext)

(cffi:defcfun ("tcadbiternext2" tcadbiternext2) :string
  (adb :pointer))

(cl:export 'tcadbiternext2)

(cffi:defcfun ("tcadbfwmkeys" tcadbfwmkeys) :pointer
  (adb :pointer)
  (pbuf :pointer)
  (psiz :int)
  (max :int))

(cl:export 'tcadbfwmkeys)

(cffi:defcfun ("tcadbfwmkeys2" tcadbfwmkeys2) :pointer
  (adb :pointer)
  (pstr :string)
  (max :int))

(cl:export 'tcadbfwmkeys2)

(cffi:defcfun ("tcadbaddint" tcadbaddint) :int
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (num :int))

(cl:export 'tcadbaddint)

(cffi:defcfun ("tcadbadddouble" tcadbadddouble) :double
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (num :double))

(cl:export 'tcadbadddouble)

(cffi:defcfun ("tcadbsync" tcadbsync) :boolean
  (adb :pointer))

(cl:export 'tcadbsync)

(cffi:defcfun ("tcadboptimize" tcadboptimize) :boolean
  (adb :pointer)
  (params :string))

(cl:export 'tcadboptimize)

(cffi:defcfun ("tcadbvanish" tcadbvanish) :boolean
  (adb :pointer))

(cl:export 'tcadbvanish)

(cffi:defcfun ("tcadbcopy" tcadbcopy) :boolean
  (adb :pointer)
  (path :string))

(cl:export 'tcadbcopy)

(cffi:defcfun ("tcadbtranbegin" tcadbtranbegin) :boolean
  (adb :pointer))

(cl:export 'tcadbtranbegin)

(cffi:defcfun ("tcadbtrancommit" tcadbtrancommit) :boolean
  (adb :pointer))

(cl:export 'tcadbtrancommit)

(cffi:defcfun ("tcadbtranabort" tcadbtranabort) :boolean
  (adb :pointer))

(cl:export 'tcadbtranabort)

(cffi:defcfun ("tcadbpath" tcadbpath) :string
  (adb :pointer))

(cl:export 'tcadbpath)

(cffi:defcfun ("tcadbrnum" tcadbrnum) :pointer
  (adb :pointer))

(cl:export 'tcadbrnum)

(cffi:defcfun ("tcadbsize" tcadbsize) :pointer
  (adb :pointer))

(cl:export 'tcadbsize)

(cffi:defcfun ("tcadbmisc" tcadbmisc) :pointer
  (adb :pointer)
  (name :string)
  (args :pointer))

(cl:export 'tcadbmisc)

(cffi:defcstruct ADBSKEL
	(opq :pointer)
	(del :pointer)
	(open :pointer)
	(close :pointer)
	(put :pointer)
	(putkeep :pointer)
	(putcat :pointer)
	(out :pointer)
	(get :pointer)
	(vsiz :pointer)
	(iterinit :pointer)
	(iternext :pointer)
	(fwmkeys :pointer)
	(addint :pointer)
	(adddouble :pointer)
	(sync :pointer)
	(optimize :pointer)
	(vanish :pointer)
	(copy :pointer)
	(tranbegin :pointer)
	(trancommit :pointer)
	(tranabort :pointer)
	(path :pointer)
	(rnum :pointer)
	(size :pointer)
	(misc :pointer)
	(putproc :pointer)
	(foreach :pointer))

(cl:export 'ADBSKEL)

(cl:export 'opq)

(cl:export 'del)

(cl:export 'open)

(cl:export 'close)

(cl:export 'put)

(cl:export 'putkeep)

(cl:export 'putcat)

(cl:export 'out)

(cl:export 'get)

(cl:export 'vsiz)

(cl:export 'iterinit)

(cl:export 'iternext)

(cl:export 'fwmkeys)

(cl:export 'addint)

(cl:export 'adddouble)

(cl:export 'sync)

(cl:export 'optimize)

(cl:export 'vanish)

(cl:export 'copy)

(cl:export 'tranbegin)

(cl:export 'trancommit)

(cl:export 'tranabort)

(cl:export 'path)

(cl:export 'rnum)

(cl:export 'size)

(cl:export 'misc)

(cl:export 'putproc)

(cl:export 'foreach)

(cffi:defctype ADBMAPPROC :pointer)

(cl:export 'ADBMAPPROC)

(cffi:defcfun ("tcadbsetskel" tcadbsetskel) :boolean
  (adb :pointer)
  (skel :pointer))

(cl:export 'tcadbsetskel)

(cffi:defcfun ("tcadbomode" tcadbomode) :int
  (adb :pointer))

(cl:export 'tcadbomode)

(cffi:defcfun ("tcadbreveal" tcadbreveal) :pointer
  (adb :pointer))

(cl:export 'tcadbreveal)

(cffi:defcfun ("tcadbputproc" tcadbputproc) :boolean
  (adb :pointer)
  (kbuf :pointer)
  (ksiz :int)
  (vbuf :pointer)
  (vsiz :int)
  (proc :pointer)
  (op :pointer))

(cl:export 'tcadbputproc)

(cffi:defcfun ("tcadbforeach" tcadbforeach) :boolean
  (adb :pointer)
  (iter :pointer)
  (op :pointer))

(cl:export 'tcadbforeach)

(cffi:defcfun ("tcadbmapbdb" tcadbmapbdb) :boolean
  (adb :pointer)
  (keys :pointer)
  (bdb :pointer)
  (proc :pointer)
  (op :pointer)
  (csiz :pointer))

(cl:export 'tcadbmapbdb)

(cffi:defcfun ("tcadbmapbdbemit" tcadbmapbdbemit) :boolean
  (map :pointer)
  (kbuf :string)
  (ksiz :int)
  (vbuf :string)
  (vsiz :int))

(cl:export 'tcadbmapbdbemit)


