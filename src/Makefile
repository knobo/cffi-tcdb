

SWIG=/usr/local/bin/swig
FLAGS=-cffi -generate-typedef -wall 

%.lisp : %.i
	$(SWIG) $(FLAGS) $< 

all: tcdb

tcdb: tchdb tctdb tcadb tcbdb tcutil

tchdb: tchdb-sys.lisp

tctdb: tctdb-sys.lisp

tcadb: tcadb-sys.lisp

tcbdb: tcbdb-sys.lisp

tcutil: tcutil-sys.lisp

clean:
	rm tc?db-sys.lisp
