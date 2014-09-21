CFLAGS := -O3 -g -Xcompiler -Wall 

.PHONY: all clean unit acceptance

all: Codfns.dyalog

unit: Codfns.dyalog ut.dyalog
	LD_LIBRARY_PATH=. mapl ws/unit

acceptance: at.dyalog ut.dyalog Codfns.dyalog
	LD_LIBRARY_PATH=. mapl ws/acceptance

clean:
	rm -rf libcodfns.so Codfns.dyalog ut.dyalog at.dyalog

libcodfns.so: rt/*.c rt/*.h
	nvcc -shared -Xcompiler -fPIC ${CFLAGS} -o $@ rt/*.c
	
Codfns.dyalog: ns/*.cd libcodfns.so
	echo ':Namespace Codfns' > Codfns.dyalog
	bin/assemble ns/*.cd >> Codfns.dyalog

ut.dyalog: ut/*.cd
	echo ':Namespace ut' > ut.dyalog
	bin/assemble ut/*.cd >> ut.dyalog

at.dyalog: at/*.cd
	echo ':Namespace at' > at.dyalog
	bin/assemble at/*.cd >> at.dyalog

