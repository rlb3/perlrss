#ifndef LIBETPAN_CONFIG_H
#define LIBETPAN_CONFIG_H
#ifdef _MSC_VER
# define MMAP_UNAVAILABLE
# define inline __inline
#endif
#include <limits.h>
#include <sys/param.h>
#include <inttypes.h>
#define MAIL_DIR_SEPARATOR '/'
#define MAIL_DIR_SEPARATOR_S "/"
#ifdef _MSC_VER
# ifdef LIBETPAN_DLL
# define LIBETPAN_EXPORT __declspec(dllexport)
# else
# define LIBETPAN_EXPORT __declspec(dllimport)
# endif
#else
# define LIBETPAN_EXPORT
#endif
#endif
