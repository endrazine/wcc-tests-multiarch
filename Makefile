#
#
# Cross-architecture build for WCC
# Jonathan Brossard // endrazine@gmail.com
# Wed Aug 27 08:14:30 CEST 2025
#

all::
	docker build --platform=linux/arm64/v8 . -t wcc-aarch64:latest --no-cache|| :
	docker build --platform=linux/arm/v7 . -t wcc-arm:latest --no-cache|| :
	docker build --platform=linux/s390x . -t wcc-s390x:latest --no-cache|| :
	docker build --platform=linux/ppc64le . -t wcc-ppc64le:latest --no-cache|| :
	docker build --platform=linux/386 . -f Dockerfile-i386 -t wcc-386:latest --no-cache|| :
	docker build --platform=linux/amd64 . -t wcc-amd64:latest --no-cache|| :
	cd unofficial && make

export-lightweight::
	mkdir -p /tmp/wsh

	# Export wsh/aarch64
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/aarch64/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/ld-linux-aarch64.so.1 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libc.so.6 /tmp/static/aarch64/"|| :
	# Export aarch64 apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /usr/sbin/apache2 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libpcre2-8.so.0 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libaprutil-1.so.0 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libapr-1.so.0 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libexpat.so.1 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libcrypt.so.1 /tmp/static/aarch64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/aarch64 wcc-aarch64:latest bash -c "cp /lib/aarch64-linux-gnu/libuuid.so.1 /tmp/static/aarch64/"|| :


	# Export wsh/armv7
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/armv7l
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/ld-linux-armhf.so.3 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libc.so.6 /tmp/static/armv7l/"|| :
	# Export armv7 apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /usr/sbin/apache2 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libpcre2-8.so.0 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libaprutil-1.so.0 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libapr-1.so.0 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libc.so.6 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libexpat.so.1 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libcrypt.so.1 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libuuid.so.1 /tmp/static/armv7l/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/arm/v7 wcc-arm:latest bash -c "cp /lib/arm-linux-gnueabihf/libgcc_s.so.1 /tmp/static/armv7l/"|| :


	# Export wsh/s390
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/s390x/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/ld64.so.1 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libc.so.6 /tmp/static/s390x/"|| :
	# Export s390 apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /usr/sbin/apache2 /tmp/static/s390x/"|| :

	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libpcre2-8.so.0 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libaprutil-1.so.0 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libapr-1.so.0 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libc.so.6 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libexpat.so.1 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libcrypt.so.1 /tmp/static/s390x/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/s390x wcc-s390x:latest bash -c "cp /lib/s390x-linux-gnu/libuuid.so.1 /tmp/static/s390x/"|| :


	# Export mips64
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/mips64le wcc-mips64le:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/mips64/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/mips64le wcc-mips64le:latest bash -c "cp /lib64/ld.so.1 /tmp/static/mips64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/mips64le wcc-mips64le:latest bash -c "cp /lib/mips64el-linux-gnuabi64/libc.so.6 /tmp/static/mips64/"|| :

	# Export ppc64le
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64le wcc-ppc64le:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/ppc64le/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64le wcc-ppc64le:latest bash -c "cp /lib64/ld64.so.2 /tmp/static/ppc64le/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64le wcc-ppc64le:latest bash -c "cp /lib/powerpc64le-linux-gnu/libc.so.6 /tmp/static/ppc64le/"|| :

	# Export 
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/386 wcc-386:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/amd64 wcc-amd64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :

	# Export alpha
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/alpha wcc-alpha:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/alpha/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/alpha wcc-alpha:latest bash -c "cp /lib/ld-linux.so.2 /tmp/static/alpha/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/alpha wcc-alpha:latest bash -c "cp /lib/alpha-linux-gnu/libc.so.6.1 /tmp/static/alpha/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/alpha wcc-alpha:latest bash -c "cp /lib/alpha-linux-gnu/libc.so.6.1 /tmp/static/alpha/libc.so.6"|| :


	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/hppa wcc-hppa:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/loong64 wcc-loong64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :

	# Export m68k
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/m68k/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/ld.so.1 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libc.so.6 /tmp/static/m68k/"|| :
	# Export m68k apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /usr/sbin/apache2 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libpcre2-8.so.0 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libaprutil-1.so.0 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libapr-1.so.0 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libexpat.so.1 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libcrypt.so.1 /tmp/static/m68k/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/m68k wcc-m68k:latest bash -c "cp /lib/m68k-linux-gnu/libuuid.so.1 /tmp/static/m68k/"|| :

	# Export ppc
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/ppc/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/ld.so.1 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libc.so.6 /tmp/static/ppc/"|| :
	# Export ppc apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /usr/sbin/apache2 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libpcre2-8.so.0 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libaprutil-1.so.0 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libapr-1.so.0 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libexpat.so.1 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libcrypt.so.1 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libuuid.so.1 /tmp/static/ppc/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc wcc-ppc:latest bash -c "cp /lib/powerpc-linux-gnu/libc.so.6 /tmp/static/ppc/"|| :

	# Export ppc64
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64 wcc-ppc64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/ppc64/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64 wcc-ppc64:latest bash -c "cp /lib64/ld64.so.1 /tmp/static/ppc64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/ppc64 wcc-ppc64:latest bash -c "cp /lib/powerpc64-linux-gnu/libc.so.6 /tmp/static/ppc64/"|| :

	# Export riscv
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/riscv64 wcc-riscv64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :

	# Export sh4
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/sh4/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/ld-linux.so.2 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libc.so.6 /tmp/static/sh4/"|| :
	# Export sh4 apache2 and its dependencies
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /usr/sbin/apache2 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libpcre2-8.so.0 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libaprutil-1.so.0 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libapr-1.so.0 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libexpat.so.1 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libcrypt.so.1 /tmp/static/sh4/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sh4 wcc-sh4:latest bash -c "cp /lib/sh4-linux-gnu/libuuid.so.1 /tmp/static/sh4/"|| :

	# Export sparc64
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sparc64 wcc-sparc64:latest bash -c "cp /root/wcc/src/wsh/wsh-* /tmp/static/"|| :
	mkdir -p /tmp/wsh/sparc64/
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sparc64 wcc-sparc64:latest bash -c "cp /lib64/ld-linux.so.2 /tmp/static/sparc64/"|| :
	docker run -v /tmp/wsh:/tmp/static -it --platform=linux/sparc64 wcc-sparc64:latest bash -c "cp /lib/sparc64-linux-gnu/libc.so.6 /tmp/static/sparc64/"|| :

testlightweight::
	LD_LIBRARY_PATH=/tmp/wsh/armv7l:$LD_LIBRARY_PATH /tmp/wsh/armv7l/ld-linux-armhf.so.3 /tmp/wsh/wsh-armv7l -q < basic.wsh
	LD_LIBRARY_PATH=/tmp/wsh/aarch64:$LD_LIBRARY_PATH /tmp/wsh/aarch64/ld-linux-aarch64.so.1 /tmp/wsh/wsh-aarch64 -q < basic.wsh
	LD_LIBRARY_PATH=/tmp/wsh/s390x:$LD_LIBRARY_PATH /tmp/wsh/s390x/ld64.so.1 /tmp/wsh/wsh-s390x -q < basic.wsh
#	LD_LIBRARY_PATH=/tmp/wsh/mips64/:$LD_LIBRARY_PATH /tmp/wsh/mips64/ld.so.1 /tmp/wsh/wsh-mips64 -q < basic.wsh
	LD_LIBRARY_PATH=/tmp/wsh/ppc64le/:$LD_LIBRARY_PATH /tmp/wsh/ppc64le/ld64.so.2 /tmp/wsh/wsh-ppc64le -q < basic.wsh
#	LD_LIBRARY_PATH=/tmp/wsh/alpha/:$LD_LIBRARY_PATH /tmp/wsh/alpha/ld-linux.so.2 /tmp/wsh/wsh-alpha -q < basic.wsh
	LD_LIBRARY_PATH=/tmp/wsh/ppc:$LD_LIBRARY_PATH /tmp/wsh/ppc/ld.so.1 /tmp/wsh/wsh-ppc -q < basic.wsh
	LD_LIBRARY_PATH=/tmp/wsh/ppc64:$LD_LIBRARY_PATH /tmp/wsh/ppc64/ld64.so.1 /tmp/wsh/wsh-ppc64 -q < basic.wsh
#	LD_LIBRARY_PATH=/tmp/wsh/m68k:$LD_LIBRARY_PATH /tmp/wsh/m68k/ld.so.1 /tmp/wsh/wsh-m68k -q < basic.wsh
#	LD_LIBRARY_PATH=/tmp/wsh/sh4:$LD_LIBRARY_PATH /tmp/wsh/sh4/ld-linux.so.2 /tmp/wsh/wsh-sh4 -q < basic.wsh || :
#	LD_LIBRARY_PATH=/tmp/wsh/sparc64:$LD_LIBRARY_PATH /tmp/wsh/sparc64/ld-linux.so.2 /tmp/wsh/wsh-sparc64 -q < basic.wsh || :

testlightweight-apache::
	export LD_PRELOAD=""
	LD_LIBRARY_PATH=/tmp/wsh/armv7l:$LD_LIBRARY_PATH /tmp/wsh/armv7l/ld-linux-armhf.so.3 /tmp/wsh/wsh-armv7l -q /tmp/wsh/armv7l/apache2 < apache-banner.wsh
	LD_LIBRARY_PATH=/tmp/wsh/ppc:$LD_LIBRARY_PATH /tmp/wsh/ppc/ld.so.1 /tmp/wsh/wsh-ppc -q /tmp/wsh/ppc/apache2 < apache-banner.wsh
	LD_LIBRARY_PATH=/tmp/wsh/m68k:$LD_LIBRARY_PATH /tmp/wsh/m68k/ld.so.1 /tmp/wsh/wsh-m68k -q /tmp/wsh/m68k/apache2 < apache-banner.wsh || :
	LD_LIBRARY_PATH=/tmp/wsh/sh4:$LD_LIBRARY_PATH /tmp/wsh/sh4/ld-linux.so.2 /tmp/wsh/wsh-sh4 -q /tmp/wsh/sh4/apache2 < apache-banner.wsh || :



#	LD_LIBRARY_PATH=/tmp/wsh/aarch64:$LD_LIBRARY_PATH /tmp/wsh/aarch64/ld-linux-aarch64.so.1 /tmp/wsh/wsh-aarch64 /tmp/wsh/aarch64/apache2 < apache-banner.wsh
#	LD_LIBRARY_PATH=/tmp/wsh/s390x:$LD_LIBRARY_PATH /tmp/wsh/s390x/ld64.so.1 /tmp/wsh/wsh-s390x /tmp/wsh/s390x/apache2 < apache-banner.wsh


testrelinking:
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/arm/v7 -it wcc-arm:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/s390x -it wcc-s390x:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/mips64le -it wcc-mips64le:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/386 -it wcc-386:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/amd64 -it wcc-amd64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/riscv64 -it wcc-riscv64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/sparc64 -it wcc-sparc64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/alpha -it wcc-alpha:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/hppa -it wcc-hppa:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/loong64 -it wcc-loong64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/m68k -it wcc-m68k:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/ppc -it wcc-ppc:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
	docker run --platform=linux/ppc64 -it wcc-ppc64:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :
#	docker run --platform=linux/sh4 -it wcc-sh4:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :

testwsh:
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/arm/v7 -it wcc-arm:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/s390x -it wcc-s390x:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/mips64le -it wcc-mips64le:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/386 -it wcc-386:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/amd64 -it wcc-amd64:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/riscv64 -it wcc-riscv64:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/sparc64 -it wcc-sparc64:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/alpha -it wcc-alpha:latest sh -c "which wsh && wsh --version"|| :
#	docker run --platform=linux/hppa -it wcc-hppa:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/m68k -it wcc-m68k:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/ppc -it wcc-ppc:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/ppc64 -it wcc-ppc64:latest sh -c "which wsh && wsh --version"|| :
	docker run --platform=linux/sh4 -it wcc-sh4:latest sh -c "which wsh && wsh --version"|| :
#	docker run --platform=linux/loong64 -it wcc-loong64:latest sh -c "which wsh && wsh --version"|| :

testwld:
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/arm/v7 -it wcc-arm:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/s390x -it wcc-s390x:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/mips64le -it wcc-mips64le:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/386 -it wcc-386:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/amd64 -it wcc-amd64:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/riscv64 -it wcc-riscv64:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/sparc64 -it wcc-sparc64:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/alpha -it wcc-alpha:latest sh -c "which wsh && wld"|| :
#	docker run --platform=linux/hppa -it wcc-hppa:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/m68k -it wcc-m68k:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/ppc -it wcc-ppc:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/ppc64 -it wcc-ppc64:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/sh4 -it wcc-sh4:latest sh -c "which wsh && wld"|| :
	docker run --platform=linux/loong64 -it wcc-loong64:latest sh -c "which wsh && wld"|| :

testcomplex:
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest ./complex.sh|| :
	docker run --platform=linux/arm/v7 -it wcc-arm:latest ./complex.sh|| :
	docker run --platform=linux/s390x -it wcc-s390x:latest ./complex.sh|| :
	docker run --platform=linux/mips64le -it wcc-mips64le:latest ./complex.sh|| :
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest ./complex.sh|| :
	docker run --platform=linux/386 -it wcc-386:latest ./complex.sh|| :
	docker run --platform=linux/amd64 -it wcc-amd64:latest ./complex.sh|| :
#	docker run --platform=linux/riscv64 -it wcc-riscv64:latest ./complex.sh|| :
	docker run --platform=linux/sparc64 -it wcc-sparc64:latest ./complex.sh|| :
	docker run --platform=linux/alpha -it wcc-alpha:latest ./complex.sh|| :
	docker run --platform=linux/hppa -it wcc-hppa:latest ./complex.sh|| :
#	docker run --platform=linux/loong64 -it wcc-loong64:latest ./complex.sh|| :
	docker run --platform=linux/m68k -it wcc-m68k:latest ./complex.sh|| :
	docker run --platform=linux/ppc -it wcc-ppc:latest ./complex.sh|| :
	docker run --platform=linux/ppc64 -it wcc-ppc64:latest ./complex.sh|| :
	docker run --platform=linux/sh4 -it wcc-sh4:latest ./complex.sh|| :

