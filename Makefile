CHK_SOURCES = test.c
CHK_SOURCES_C = $(filter %.c,$(CHK_SOURCES))

.PHONY: debug static windows-static clean check-syntax check-syntax \
	check-syntax-gcc check-syntax-clang

all:
	gcc -w -O3 $(CHK_SOURCES_C) -o test

debug:
	gcc -ggdb3 $(CHK_SOURCES_C) -o test

static:
	gcc -w -static -m32 -Os $(CHK_SOURCES_C) -o test
	upx --ultra-brute -q test

windows-static:
	i686-w64-mingw32-cc -w -static -Os $(CHK_SOURCES_C) -o test.exe
	upx --ultra-brute -q test.exe

clean:
	-rm test test.exe

check-syntax: check-syntax-gcc check-syntax-clang
check-syntax-gcc:
	gcc -fsyntax-only -Wall -Wextra -pedantic -Wno-variadic-macros \
		-Wmissing-prototypes -Wstrict-prototypes \
		-Wold-style-definition -std=c89 $(CHK_SOURCES_C)

check-syntax-clang:
	clang -fsyntax-only -Wall -Wextra -pedantic -Wno-variadic-macros \
		-Wmissing-prototypes -Wstrict-prototypes \
		-Wold-style-definition -std=c89 $(CHK_SOURCES_C)
