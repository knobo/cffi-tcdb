(in-package #:tcadb)

(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-put db '("test1" :foo "bar" "baz" "bam"))
    (db-put db '("test2" :foo "bar" "baz" "snafu"))
    (db-put db '("test3" :foo "baz" :first :next))
    (db-put db '("test3" :foo "baz" :first :last))))

(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-search db  '((:|cond| :foo "str" "bar")))))

(with-tcdb (db "/tmp/test1.tct")
  (with-transaction (db)
    (db-search db  '((:|cond| :foo   "str" "baz")
		     (:|cond| :first "str" :last)))))

