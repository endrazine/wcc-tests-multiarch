#
#
# Cross-architecture build for WCC
# Jonathan Brossard // endrazine@gmail.com
# Mon Apr 28 11:07:40 CEST 2025
#

all::
	docker build --platform=linux/arm64/v8 . -t wcc-aarch64:latest --no-cache|| :
	docker build --platform=linux/arm/v7 . -t wcc-arm:latest --no-cache|| :
	docker build --platform=linux/s390x . -t wcc-s390x:latest --no-cache|| :
	docker build --platform=linux/mips64le . -t wcc-mips64le:latest --no-cache|| :
	docker build --platform=linux/ppc64le . -t wcc-ppc64le:latest --no-cache|| :
	docker build --platform=linux/386 . -t wcc-386:latest --no-cache|| :
	docker build --platform=linux/amd64 . -t wcc-amd64:latest --no-cache|| :
	cd riscv64 && make

run-aarch64::
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest /bin/bash

run-arm::
	docker run --platform=linux/arm/v7 -it wcc-arm:latest /bin/bash

run-s390x::
	docker run --platform=linux/s390x -it wcc-s390x:latest /bin/bash

run-mips64le::
	docker run --platform=linux/mips64le -it wcc-mips64le:latest /bin/bash

run-ppc64le::
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest /bin/bash

run-386::
	docker run --platform=linux/386 -it wcc-386:latest /bin/bash

run-amd64::
	docker run --platform=linux/amd64 -it wcc-amd64:latest /bin/bash

run-riscv64:
	docker run --platform=linux/riscv64 -it wcc-riscv64:latest /bin/bash

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
	docker run --platform=linux/sh4 -it wcc-sh4:latest sh -c "cd /root/apache_relink/ && ./ap2loglevel info"|| :

testwsh:
	docker run --platform=linux/arm64/v8 -it wcc-aarch64:latest wsh --version|| :
	docker run --platform=linux/arm/v7 -it wcc-arm:latest wsh --version|| :
	docker run --platform=linux/s390x -it wcc-s390x:latest wsh --version|| :
	docker run --platform=linux/mips64le -it wcc-mips64le:latest wsh --version|| :
	docker run --platform=linux/ppc64le -it wcc-ppc64le:latest wsh --version|| :
	docker run --platform=linux/386 -it wcc-386:latest wsh --version|| :
	docker run --platform=linux/amd64 -it wcc-amd64:latest wsh --version|| :
	docker run --platform=linux/riscv64 -it wcc-riscv64:latest wsh --version|| :
	docker run --platform=linux/sparc64 -it wcc-sparc64:latest wsh --version|| :
	docker run --platform=linux/alpha -it wcc-alpha:latest wsh --version|| :
	docker run --platform=linux/hppa -it wcc-hppa:latest wsh --version|| :
	docker run --platform=linux/loong64 -it wcc-loong64:latest wsh --version|| :
	docker run --platform=linux/m68k -it wcc-m68k:latest wsh --version|| :
	docker run --platform=linux/ppc -it wcc-ppc:latest wsh --version|| :
	docker run --platform=linux/ppc64 -it wcc-ppc64:latest wsh --version|| :
	docker run --platform=linux/sh4 -it wcc-sh4:latest wsh --version|| :

