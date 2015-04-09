
CPP=i586-mingw32msvc-g++
CC=i586-mingw32msvc-gcc
WINDRES=i586-mingw32msvc-windres

OBJS_RELEASE=obj/siframe.o obj/sihook.o obj/sisw.o obj/tabctl.o obj/utils.o obj/mdiclient.o

Release: bin/sihook.dll bin/msimg32.dll

bin/msimg32.dll: msimg32/msimg32.c
	@echo Building dynamic library bin/msimg32.dll
	@${CC} -shared -Wl,--output-def=bin/libmsimg32.dll.def -Wl,--out-implib=bin/libmsimg32.dll.a -W -fexceptions -O2 -DWIN32 -DNDEBUG -D_WINDOWS -D_USRDLL -DMSIMG32_EXPORTS  msimg32/msimg32.c -o bin/msimg32.dll -s -luser32 -lgdi32 -lcomctl32 -lkernel32 -lwinspool -lcomdlg32 -ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32

bin/sihook.dll: $(OBJS_RELEASE)
	@echo Building dynamic library bin/sihook.dll
	@${CC} -shared -Wl,--output-def=bin/libsihook.dll.def -Wl,--out-implib=bin/libsihook.dll.a $(OBJS_RELEASE)  -o bin/sihook.dll -s  -luser32 -lgdi32 -lcomctl32 

obj/siframe.o: siframe.c
	@echo Compiling: siframe.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c siframe.c -o obj/siframe.o

obj/sihook.o: sihook.c
	@echo Compiling: sihook.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c sihook.c -o obj/sihook.o

obj/sisw.o: sisw.c
	@echo Compiling: sisw.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c sisw.c -o obj/sisw.o

obj/tabctl.o: tabctl.c
	@echo Compiling: tabctl.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c tabctl.c -o obj/tabctl.o

obj/utils.o: utils.c
	@echo Compiling: utils.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c utils.c -o obj/utils.o

obj/mdiclient.o: mdiclient.c
	@echo Compiling: mdiclient.c
	@${CC}  -O2 -Wall -DBUILD_DLL -c mdiclient.c -o obj/mdiclient.o

siframe.c: siframe.h tabctl.h const.h

sihook.c: siframe.h mdiclient.h

mdiclient.c: mdiclient.h sisw.h tabctl.h const.h

tabctl.c: const.h utils.h tabctl.h

sisw.c: tabctl.h const.h utils.h sisw.h

utils.c: utils.h

.PHONY: clean

clean: 
	rm -rf bin/*
	rm -rf obj/*


