CFLAGS=-g
CC=gcc

PROG=update-c show-d init-db write-t read-t commit-t cat-f

all: $(PROG)

install: $(PROG)
	install $(PROG) $(HOME)/bin/

LIBS= -lssl

init-db: init-db.o

update-c: update-c.o read-c.o
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
