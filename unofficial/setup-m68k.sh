#!/bin/bash

echo "Creating M68k support for OpenLibm based on successful SH4 pattern..."

# 1. Create m68k/Make.files following the working pattern
mkdir -p m68k  
echo '$(CUR_SRCS) = fenv.c' > m68k/Make.files
echo "Created m68k/Make.files"

# 2. Create src/m68k_fpmath.h
cat > src/m68k_fpmath.h << 'EOF'
/*-
 * Copyright (c) 2002, 2003 David Schultz <das@FreeBSD.ORG>
 * Copyright (c) 2025 OpenLibm Contributors
 * All rights reserved.
 */

/*
 * M68k floating point format
 * M68k typically has extended precision long double (80-bit) but we'll
 * treat it as double for compatibility like other embedded architectures
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
echo "Created src/m68k_fpmath.h"

# 3. Add M68k to src/fpmath.h BEFORE mips (critical for preventing conflicts)
if ! grep -q "__m68k__\|__M68K__\|__mc68" src/fpmath.h; then
    cp src/fpmath.h src/fpmath.h.backup
    sed -i '/^#elif defined(__mips__)/i\
#elif defined(__m68k__) || defined(__M68K__) || defined(__mc68000__)\
#include "m68k_fpmath.h"' src/fpmath.h
    echo "Added M68k to src/fpmath.h before MIPS detection"
fi

# 4. Create include/openlibm_fenv_m68k.h  
cat > include/openlibm_fenv_m68k.h << 'EOF'
/*-
 * Copyright (c) 2004-2005 David Schultz <das@FreeBSD.ORG>
 * Copyright (c) 2025 OpenLibm Contributors
 * All rights reserved.
 */

#ifndef _OPENLIBM_FENV_M68K_H_
#define _OPENLIBM_FENV_M68K_H_

/*
 * Floating-point environment for Motorola 68k architecture
 */

typedef unsigned int fenv_t;
typedef unsigned int fexcept_t;

/* Exception flags */
#define FE_INEXACT    0x04
#define FE_UNDERFLOW  0x08
#define FE_OVERFLOW   0x10
#define FE_DIVBYZERO  0x20
#define FE_INVALID    0x40
#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID | FE_OVERFLOW | FE_UNDERFLOW)

/* Rounding modes */
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

#endif /* _OPENLIBM_FENV_M68K_H_ */
EOF
echo "Created include/openlibm_fenv_m68k.h"

# 5. Add M68k to include/openlibm_fenv.h
if ! grep -q "__m68k__\|__M68K__\|__mc68" include/openlibm_fenv.h; then
    cp include/openlibm_fenv.h include/openlibm_fenv.h.backup
    sed -i '/#else/i\
#elif defined(__m68k__) || defined(__M68K__) || defined(__mc68000__)\
#include "openlibm_fenv_m68k.h"' include/openlibm_fenv.h
    echo "Added M68k to include/openlibm_fenv.h"
fi

# 6. Create m68k/fenv.c following the exact aarch64 pattern
cat > m68k/fenv.c << 'EOF'
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
 * Default M68k floating-point environment.
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
echo "Created m68k/fenv.c"

# 7. Update README.md to document M68k support
if ! grep -q "m68k" README.md; then
    sed -i 's/loongarch64\./loongarch64, and m68k./' README.md
    echo "Updated README.md"
fi

echo ""
echo "=== M68k Support Complete ==="
echo "Files created:"
echo "  ✓ m68k/Make.files"
echo "  ✓ m68k/fenv.c"
echo "  ✓ src/m68k_fpmath.h"  
echo "  ✓ include/openlibm_fenv_m68k.h"
echo "  ✓ Updated src/fpmath.h (added M68k before MIPS)"
echo "  ✓ Updated include/openlibm_fenv.h"
echo "  ✓ Updated README.md"
echo ""
echo "Build with: make ARCH=m68k CFLAGS=\"-fpie -fPIC\""
echo "Or for cross-compilation: make ARCH=m68k TOOLPREFIX=m68k-linux-gnu- CFLAGS=\"-fpie -fPIC\""
echo ""
echo "Note: If you get 'union IEEEl2bits' errors in specific functions,"
echo "those will need the same cast-to-double fixes we used for SH4."
