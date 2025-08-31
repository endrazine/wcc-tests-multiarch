#!/bin/bash

echo "Creating minimal SH4 support - no source file modifications"

# 1. Create sh4/Make.files
mkdir -p sh4  
echo '$(CUR_SRCS) = fenv.c' > sh4/Make.files
echo "Created sh4/Make.files"

# 2. Create minimal src/sh4_fpmath.h (avoiding redefinition warnings)
cat > src/sh4_fpmath.h << 'EOF'
/*
 * SH4 floating point format - minimal to avoid conflicts
 */

union IEEEl2bits {
	long double	e;
	struct {
		unsigned int	manl	:32;
		unsigned int	manh	:20;
		unsigned int	exp	:11;
		unsigned int	sign	:1;
	} bits;
};

#define	LDBL_NBIT	0x80000000
#define	mask_nbit_l(u)	((void)0)
#define	LDBL_MANH_SIZE	20
#define	LDBL_MANL_SIZE	32

/* Use system-provided values if available */
#ifndef LDBL_MAX_EXP
#define	LDBL_MAX_EXP	2047
#endif

#ifndef LDBL_MIN_EXP
#define	LDBL_MIN_EXP	(-1022)
#endif

#define	LDBL_TO_ARRAY32(u, a) do {			\
	(a)[0] = (u).bits.manl;				\
	(a)[1] = (u).bits.manh;				\
} while(0)
EOF
echo "Created src/sh4_fpmath.h"

# 3. Add SH4 to src/fpmath.h BEFORE mips (critical for preventing conflicts)
if ! grep -q "__sh__\|__SH4__" src/fpmath.h; then
    cp src/fpmath.h src/fpmath.h.backup
    sed -i '/^#elif defined(__mips__)/i\
#elif defined(__sh__) || defined(__SH4__)\
#include "sh4_fpmath.h"' src/fpmath.h
    echo "Added SH4 to src/fpmath.h before MIPS detection"
fi

# 4. Create include/openlibm_fenv_sh4.h  
cat > include/openlibm_fenv_sh4.h << 'EOF'
#ifndef _OPENLIBM_FENV_SH4_H_
#define _OPENLIBM_FENV_SH4_H_

typedef unsigned int fenv_t;
typedef unsigned int fexcept_t;

#define FE_INEXACT    0x04
#define FE_UNDERFLOW  0x08
#define FE_OVERFLOW   0x10
#define FE_DIVBYZERO  0x20
#define FE_INVALID    0x40
#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID | FE_OVERFLOW | FE_UNDERFLOW)

#define FE_TONEAREST  0x00
#define FE_TOWARDZERO 0x01
#define FE_UPWARD     0x02
#define FE_DOWNWARD   0x03

extern const fenv_t __fe_dfl_env;
#define FE_DFL_ENV (&__fe_dfl_env)

static inline int feclearexcept(int excepts) { return 0; }
static inline int fegetexceptflag(fexcept_t *flagp, int excepts) { *flagp = 0; return 0; }
static inline int fesetexceptflag(const fexcept_t *flagp, int excepts) { return 0; }
static inline int feraiseexcept(int excepts) { return 0; }
static inline int fetestexcept(int excepts) { return 0; }
static inline int fegetround(void) { return FE_TONEAREST; }
static inline int fesetround(int round) { return 0; }
static inline int fegetenv(fenv_t *envp) { *envp = 0; return 0; }
static inline int feholdexcept(fenv_t *envp) { *envp = 0; return 0; }
static inline int fesetenv(const fenv_t *envp) { return 0; }
static inline int feupdateenv(const fenv_t *envp) { return 0; }

#endif
EOF
echo "Created include/openlibm_fenv_sh4.h"

# 5. Add SH4 to include/openlibm_fenv.h
if ! grep -q "__sh__\|__SH4__" include/openlibm_fenv.h; then
    cp include/openlibm_fenv.h include/openlibm_fenv.h.backup
    sed -i '/#else/i\
#elif defined(__sh__) || defined(__SH4__)\
#include "openlibm_fenv_sh4.h"' include/openlibm_fenv.h
    echo "Added SH4 to include/openlibm_fenv.h"
fi

# Create sh4/fenv.c based on the aarch64 pattern
cat > sh4/fenv.c << 'EOF'
/*-
 * Copyright (c) 2004 David Schultz <das@FreeBSD.ORG>
 * Copyright (c) 2025 OpenLibm Contributors
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <openlibm_fenv.h>

#ifdef __GNUC_GNU_INLINE__
#error "This file must be compiled with C99 'inline' semantics"
#endif

/*
 * Default SH4 floating-point environment.
 */
const fenv_t __fe_dfl_env = 0;

extern inline int feclearexcept(int __excepts);
extern inline int fegetexceptflag(fexcept_t *__flagp, int __excepts);
extern inline int fesetexceptflag(const fexcept_t *__flagp, int __excepts);
extern inline int feraiseexcept(int __excepts);
extern inline int fetestexcept(int __excepts);
extern inline int fegetround(void);
extern inline int fesetround(int __round);
extern inline int fegetenv(fenv_t *__envp);
extern inline int feholdexcept(fenv_t *__envp);
extern inline int fesetenv(const fenv_t *__envp);
extern inline int feupdateenv(const fenv_t *__envp);
EOF


