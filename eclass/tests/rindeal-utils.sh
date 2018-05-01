source tests-common.sh

EAPI=6

inherit rindeal-utils

rindeal:dsf:eval "$1" 'payload'
