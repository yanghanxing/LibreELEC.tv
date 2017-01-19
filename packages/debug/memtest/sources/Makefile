
all: memtest

memtest: main.c
	$(CC) -o memtest main.c

install: memtest
	mkdir -p $(DESTDIR)/usr/bin
	cp memtest $(DESTDIR)/usr/bin
