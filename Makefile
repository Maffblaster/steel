CC=gcc
override CFLAGS+=-std=c99 -Wall

SHELL=/bin/bash

DESTDIR=/
PREFIX=/usr/local
SHAREDIR = $(PREFIX)/share
BINDIR = $(PREFIX)/bin
MANDIR = $(SHAREDIR)/man

LDFLAGS=-L. -lmhash -lmcrypt -lsqlite3 -lbcrypt
.PHONY: crypt_blowfish

all: steel

steel: libbcrypt.a bcrypt.o steel.o status.o cmd_ui.o entries.o backup.o database.o crypto.o
	$(CC) $(CFLAGS) bcrypt.o steel.o status.o database.o entries.o backup.o cmd_ui.o crypto.o -o steel $(LDFLAGS)

libbcrypt.a: crypt_blowfish
	ar r libbcrypt.a crypt_blowfish/*.o

bcrypt.o: bcrypt.c
	$(CC) $(CFLAGS) -c bcrypt.c

crypt_blowfish:
	$(MAKE) -C crypt_blowfish

steel.o: steel.c
	$(CC) $(CFLAGS) -c steel.c

database.o: database.c
	$(CC) $(CFLAGS) -c database.c

entries.o: entries.c
	$(CC) $(CFLAGS) -c entries.c

crypto.o: crypto.c
	$(CC) $(CFLAGS) -c crypto.c

cmd_ui.o: cmd_ui.c
	$(CC) $(CFLAGS) -c cmd_ui.c

status.o: status.c
	$(CC) $(CFLAGS) -c status.c

backup.o: backup.c
	$(CC) $(CFLAGS) -c backup.c

clean:
	rm -f steel
	rm -f *.o
	rm -f libbcrypt.a
	cd crypt_blowfish; $(MAKE) clean

install: all
	@ if [ ! -d $(MANDIR)/man1 ]; then mkdir -p $(MANDIR)/man1; else printf "$(MANDIR)/man1 prevously created.\n"; fi

	cp steel.1 $(MANDIR)/man1/
	gzip -f $(MANDIR)/man1/steel.1

	@ if [ ! -d $(BINDIR) ]; then mkdir -p $(BINDIR); else printf "$(BINDIR) prevously created.\n"; fi
	cp steel $(BINDIR)/

uninstall:
	@ if [ -e $(BINDIR)/steel ]; then rm $(BINDIR)/steel; else printf "$(BINDIR) looks clean. Nothing removed.\n"; fi
	@ if [ -e  $(MANDIR)/man1/steel.1 ]; then rm $(MANDIR)/man1/steel.1.gz; else printf "$(MANDIR) looks clean. Nothing removed.\n"; fi
