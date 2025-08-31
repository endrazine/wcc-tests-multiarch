all::
	docker build --platform=linux/ppc . -t wcc-ppc:latest --no-cache|| :
	docker build --platform=linux/ppc64 . -t wcc-ppc64:latest --no-cache|| :
	docker build --platform=linux/riscv64 . -t wcc-riscv64:latest --no-cache|| :
	docker build --platform=linux/mips64le . -t wcc-mips64le:latest --no-cache|| :

	docker build --platform=linux/sh4 -f Dockerfile-sh4 . -t wcc-sh4:latest --no-cache|| :
	docker build --platform=linux/m68k -f Dockerfile-m68k . -t wcc-m68k:latest --no-cache|| :
	docker build --platform=linux/sparc64 -f Dockerfile-sparc64 . -t wcc-sparc64:latest --no-cache|| :
	docker build --platform=linux/alpha -f Dockerfile-alpha . -t wcc-alpha:latest --no-cache|| :
	docker build --platform=linux/hppa -f Dockerfile-hppa . -t wcc-hppa:latest --no-cache|| :
	docker build --platform=linux/loong64 -f Dockerfile-loong64 . -t wcc-loong64:latest --no-cache|| :

