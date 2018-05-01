#!/bin/bash

EAPI=6

. ./tests-common.sh || exit 1

inherit qt-pro-formatter

# disable inplace
qt_pro_awk_opts=()

cat <<'_EOF_' | format_qt_pro
EQ = 1 \
    2   \
    3
_EOF_

cat <<'_EOF_' | format_qt_pro
ADD+=1\
2\
3
_EOF_

cat <<'_EOF_' | format_qt_pro
SUB-=	1 	\
 2	 \
	3
_EOF_

cat <<'_EOF_' | format_qt_pro
COMMENT =	1 	\
 # hello world
	3
_EOF_

cat <<'_EOF_' | unix2dos | format_qt_pro
CRLF += 1 \
    2\
    3
_EOF_
