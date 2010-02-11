

SWIG=/usr/local/bin/swig
FLAGS=-cffi -generate-typedef -wall 

%.lisp : %.i
	$(SWIG) $(FLAGS) $< 

all: tcdb

tcdb: tchdb tctdb tcadb tcbdb tcutil

tchdb: tchdb.lisp

tctdb: tctdb.lisp

tcadb: tcadb.lisp

tcbdb: tcbdb.lisp

tcutil: tcutil.lisp

clean:
	rm tc?db-sys.lisp
