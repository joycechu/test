# m4.m4 serial 9

# Copyright (C) 2000, 2006, 2007, 2008, 2009 Free Software Foundation,
# Inc.

# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without warranty of any kind.

# AC_PROG_GNU_M4
# --------------
# Check for GNU M4, at least 1.4.6 (all earlier versions had bugs in
# trace support and regexp support):
# http://lists.gnu.org/archive/html/bug-gnu-utils/2006-11/msg00096.html
# http://lists.gnu.org/archive/html/bug-autoconf/2009-07/msg00023.html
# Also, check whether --error-output (through 1.4.x) or --debugfile (2.0)
# is supported, and AC_SUBST M4_DEBUGFILE accordingly.
AC_DEFUN([AC_PROG_GNU_M4],
  [AC_ARG_VAR([M4], [Location of GNU M4 1.4.6 or later.  Defaults to the first
    program of `m4', `gm4', or `gnum4' on PATH that meets Autoconf needs.])
  AC_CACHE_CHECK([for GNU M4 that supports accurate traces], [ac_cv_path_M4],
    [rm -f conftest.m4f
ac_had_posixly_correct=${POSIXLY_CORRECT:+yes}
AS_UNSET([POSIXLY_CORRECT])
AC_PATH_PROGS_FEATURE_CHECK([M4], [m4 gm4 gnum4],
      [dnl Creative quoting here to avoid raw dnl and ifdef in configure.
      # Root out GNU M4 1.4.5, as well as non-GNU m4 that ignore -t, -F.
      ac_snippet=change'quote(<,>)in''dir(<if''def>,mac,bug)'
      ac_snippet=${ac_snippet}pat'subst(a,\(b\)\|\(a\),\1)d'nl
      test -z "`$ac_path_M4 -F conftest.m4f </dev/null 2>&1`" \
      && test -z "`echo $ac_snippet | $ac_path_M4 --trace=mac 2>&1`" \
      && test -f conftest.m4f \
      && ac_cv_path_M4=$ac_path_M4 ac_path_M4_found=:
      rm -f conftest.m4f],
      [AC_MSG_ERROR([no acceptable m4 could be found in \$PATH.
GNU M4 1.4.6 or later is required; 1.4.13 is recommended])])])
  M4=$ac_cv_path_M4
  AC_CACHE_CHECK([whether $ac_cv_path_M4 accepts --gnu],
    [ac_cv_prog_gnu_m4_gnu],
    [case `$M4 --help < /dev/null 2>&1` in
      *--gnu*) ac_cv_prog_gnu_m4_gnu=yes ;;
      *) ac_cv_prog_gnu_m4_gnu=no ;;
    esac])
  if test "$ac_cv_prog_gnu_m4_gnu" = yes; then
    M4_GNU=--gnu
  else
    M4_GNU=
  fi
  AC_SUBST([M4_GNU])
  if test x$ac_had_posixly_correct = xyes; then
    POSIXLY_CORRECT=:
    if test $ac_cv_prog_gnu_m4_gnu = no; then
      AC_MSG_WARN([The version of M4 that was found does not support -g.])
      AC_MSG_WARN([Using it with POSIXLY_CORRECT set may cause problems.])
    fi
  fi
  AC_CACHE_CHECK([how m4 supports trace files], [ac_cv_prog_gnu_m4_debugfile],
    [case `$M4 --help < /dev/null 2>&1` in
      *debugfile*) ac_cv_prog_gnu_m4_debugfile=--debugfile ;;
      *) ac_cv_prog_gnu_m4_debugfile=--error-output ;;
    esac])
  AC_SUBST([M4_DEBUGFILE], [$ac_cv_prog_gnu_m4_debugfile])
])

# Compatibility for bootstrapping with Autoconf 2.61.
dnl FIXME - replace this with AC_PREREQ([2.62]) after the release.
# AC_PATH_PROGS_FEATURE_CHECK was added the same time the slightly broken,
# undocumented _AC_PATH_PROG_FEATURE_CHECK was deleted.
m4_ifndef([AC_PATH_PROGS_FEATURE_CHECK],
  [m4_define([AC_PATH_PROGS_FEATURE_CHECK],
    [_AC_PATH_PROG_FEATURE_CHECK([$1], [$2], [$3], [$5])
])])