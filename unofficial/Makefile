all::
	cp ../apache_relink.tgz .
	docker build --platform=linux/alpha . -t wcc-alpha:latest --no-cache|| :
	docker build --platform=linux/hppa . -t wcc-hppa:latest --no-cache|| :
	docker build --platform=linux/loong64 . -t wcc-loong64:latest --no-cache|| :
	docker build --platform=linux/m68k . -t wcc-m68k:latest --no-cache|| :
	docker build --platform=linux/ppc . -t wcc-ppc:latest --no-cache|| :
	docker build --platform=linux/ppc64 . -t wcc-ppc64:latest --no-cache|| :
	docker build --platform=linux/riscv64 . -t wcc-riscv64:latest --no-cache|| :
	docker build --platform=linux/sh4 . -t wcc-sh4:latest --no-cache|| :
	docker build --platform=linux/sparc64 . -t wcc-sparc64:latest --no-cache|| :
	rm apache_relink.tgz
