#!/bin/bash

EAPI=6

. ./tests-common.sh

DEPEND_A=( {1,2,3} )
RDEPEND_A=( r{1,2,3} )
PDEPEND_A=( p{1,2,3} )
CDEPEND_A=( c{1,2,3} )

inherit arrays

for v in {,R,P,C}DEPEND ; do
    echo "${v}=${!v}"
done
