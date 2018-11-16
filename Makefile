CFLAGS=-g
CC=gcc

PROG=update-cache show-diff init-db write-tree read-tree commit-tree cat-file

all: $(PROG)

install: $(PROG)
	install $(PROG) $(HOME)/bin/

LIBS=-lssl -lz -lcrypto

init-db: init-db.o

update-cache: update-c.o read-c.o
	$(CC) $(CFLAGS) -o update-c update-c.o read-c.o $(LIBS)

show-diff: show-d.o read-c.o
	$(CC) $(CFLAGS) -o show-d show-d.o read-c.o $(LIBS)

write-tree: write-t.o read-c.o
	$(CC) $(CFLAGS) -o write-t write-t.o read-c.o $(LIBS)

read-tree: read-t.o read-c.o
	$(CC) $(CFLAGS) -o read-t read-t.o read-c.o $(LIBS)

commit-tree: commit-t.o read-c.o
	$(CC) $(CFLAGS) -o commit-t commit-t.o read-c.o $(LIBS)

cat-file: cat-f.o read-c.o
	$(CC) $(CFLAGS) -o cat-f cat-f.o read-c.o $(LIBS)

read-c.o: cache.h
show-d.o: cache.h

clean:
	rm -f *.o $(PROG) temp_git_file_*

backup: clean
	cd .. ; tar czvf dircache.tar.gz dir-cache
