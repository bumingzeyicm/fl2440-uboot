#ifndef CRC32_H
#define CRC32_H

/* JFFS2 Id: crc32.h,v 1.4 2002/01/03 15:20:44 dwmw2  Exp
 * $Id: crc32.h,v 3.2 2004/12/25 11:11:21 dedekind Exp $ */

#include <linux/types.h>

extern const uint32_t crc32_table[256];

/* Return a 32-bit CRC of the contents of the buffer. */

static inline uint32_t
crc32(uint32_t val, const void *ss, int len)
{
	const unsigned char *s = ss;
        while (--len >= 0)
                val = crc32_table[(val ^ *s++) & 0xff] ^ (val >> 8);
        return val;
}

#endif
