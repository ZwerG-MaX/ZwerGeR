# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rindeal-utils.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: Collection of handy functions for my overlay
# @DESCRIPTION:

if [ -z "${_RINDEAL_UTILS_ECLASS}" ] ; then

case "${EAPI:-0}" in
	6) ;;
	*) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac


#
# @EXAMPLE:
#
# 	_rindeal:dsf:print_conjunction a b c "cat/pkg"
#
# Prints:
#
# 	a? ( b? ( c? (
# 		cat/pkg
# 	) ) )
#
_rindeal:dsf:print_conjunction() {
	(( $# < 2 )) && die
	local conditions=( "${@:1:$(($#-1))}" )
	local payload="${@: -1}"

	printf '%s? ( ' "${conditions[@]}"
	printf '\n\t%s\n' "${payload}"
	printf ' )%.0s' "${conditions[@]}"
	printf '\n'
}

#
# @EXAMPLE:
#
# 	tokens=()
# 	_rindeal:dsf:tokenize 'a&b&(c|d)' tokens
# 	_rindeal:dsf:eval_cnf tokens "cat/pkg"
#
# Prints:
#
# 	a? ( b? ( c? (
# 		cat/pkg
# 	) ) )
# 	a? ( b? ( d? (
# 		cat/pkg
# 	) ) )
#
_rindeal:dsf:eval_cnf() {
	(( $# != 2 )) && die
	local -n _tokens="${1}"
	local payload="${2}"

	# algorithm:
	#  1. split to groups split by '&'
	#  2. permute all memebers of these groups
	#  3. print_conjunction() each permutation

	local grp_cnt=1
	local i

	_get_grp_name() {
		echo "_grp_${1}"
	}

	### group the conditions
	local t
	for t in "${_tokens[@]}" ; do
		case "${t}" in
		'&' )
			# start a new group
			(( grp_cnt++ ))
		;;
		'(' | ')' | '|' )
			: # pass, not important for us
		;;
		*)
			local grp_name="$(_get_grp_name "${grp_cnt}")"

			# create the group if it doesn't exist already
			[[ -z "${!grp_name}" ]] && eval "local -a ${grp_name}=()"

			# add "${t}" to group #grp_cnt
			eval "${grp_name}+=( \"\${t}\" )"
		;;
		esac
	done

	local grp_ptrs=()
	# TODO: delete this loop
	for (( i=1; i<=grp_cnt; i++ )) ; do
		grp_ptrs[i]=0
	done

	### print the permutations
	local end_loop_1=0
	while ! (( end_loop_1 )) ; do

		## gather values from each group
		local conditions=()
		for (( i = 1; i <= grp_cnt; i++ )) ; do
			local grp_name="$(_get_grp_name ${i})"
			eval "conditions+=( \${${grp_name}[${grp_ptrs[i]}]} )"
		done
		## print them
		_rindeal:dsf:print_conjunction "${conditions[@]}" "${payload}"

		## re-adjust pointers
		local end_loop_2=0
		local bump_group=1
		while ! (( end_loop_2 )) ; do
			local grp_name="$(_get_grp_name "${bump_group}")"

			# first bump whatever group we're looping through at the moment
			(( grp_ptrs[bump_group]++ ))
			# now check if we've run past the last member of the current group
			if (( grp_ptrs[bump_group] >= $(eval "echo \${#${grp_name}[*]}") )) ; then
				# if so, reset the pointer in the group
				(( grp_ptrs[bump_group]=0 ))
				# and move on to the next group
				(( bump_group++ ))
				# and check if we've run past the last group
				if (( bump_group > grp_cnt )) ; then
					# if so, then we're at the end of our mission
					end_loop_2=1
					end_loop_1=1
				fi
			else
				# if we've bumped the pointer successfully, there is no more work for us in this loop
				end_loop_2=1
			fi
		done
	done
}

#
# @EXAMPLE:
#
# 	tokens=()
# 	_rindeal:dsf:tokenize 'a|b|(c&d)' tokens
# 	_rindeal:dsf:eval_dnf tokens "cat/pkg"
#
# Prints:
#
# 	a? (
# 		cat/pkg
# 	)
# 	b? (
# 		cat/pkg
# 	)
# 	c? ( d?
# 		cat/pkg
# 	) )
#
_rindeal:dsf:eval_dnf() {
	(( $# != 2 )) && die
	local -n _tokens="${1}"
	local payload="${2}"

	local t conditions=()
	for t in "${_tokens[@]}" ; do
		case "${t}" in
		'|' )
			# at the end of a group, print the buffer
			_rindeal:dsf:print_conjunction "${conditions[@]}" "${payload}"
			# and empty it
			conditions=()
		;;
		'(' | ')' | '&' )
			: # pass
		;;
		*)
			conditions+=( "${t}" )
		;;
		esac
	done

	# print the last buffer
	_rindeal:dsf:print_conjunction "${conditions[@]}" "${payload}"
}

# @EXAMPLE:
#
# 	tokens=()
# 	_rindeal:dsf:tokenize 'ab&bc&(cd|de)' tokens
#
# Creates:
#
# 	tokens=(
# 		'ab'  '&'  'bc'  '&'  '('  'cd'  '|'  'de'  ')'
# 	)
#
# @NOTE: tokenizer ignores WS
_rindeal:dsf:tokenize() {
	(( $# != 2 )) && die
	local str="${1}"
	local -n _tokens="${2}"

	local token_regexes=(
		'\('
		'\)'
		'\&'
		'\|'
		'[a-zA-Z0-9_-]+'
	)
	local regex="^\s*($(IFS=\|; echo "${token_regexes[*]}"))\s*"

	while (( ${#str} )) ; do
		# regex match the token
		[[ "${str}" =~ ${regex} ]] || die
		local m="${BASH_REMATCH[1]}"
		local whole_match="${BASH_REMATCH[0]}"

		# save the token
		_tokens+=( "${m}" )

		# strip the token (+spaces) from the string
		str="${str#${whole_match}}"
	done
}

#
# @EXAMPLE:
#
# 	type= tokens=()
# 	_rindeal:dsf:tokenize 'ab&bc&(cd|de)' tokens
# 	_rindeal:dsf:get_expr_type tokens type
#
# Creates:
#
# 	type="cnf"
#
_rindeal:dsf:get_expr_type() {
	(( $# != 2 )) && die
	local -n _tokens="${1}"
	local -n _type="${2}"

	# algorithm: find the first &/| character outside of a group
	local t in_group=0
	for t in "${tokens[@]}" ; do
		case "${t}" in
		'(' ) in_group=1 ;;
		')' ) in_group=0 ;;
		'&' | '|' )
			(( in_group )) && continue

			case "${t}" in
			'&' )	_type=cnf; ;;
			'|' )	_type=dnf ;;
			*)		die ;;
			esac

			return 0
			;;
		* ) : # pass
			;;
		esac
	done

	die "${ECLASS}: ${FUNCNAME[0]}: Unknown type"
}

#
# @EXAMPLE:
#
# 	rindeal:dsf:eval 'a|b|(c&d)' 'cat/pkg'
#
# Prints:
#
# 	a? (
# 		cat/pkg
# 	)
# 	b? (
# 		cat/pkg
# 	)
# 	c? ( d?
# 		cat/pkg
# 	) )
#
rindeal:dsf:eval() {
	(( $# != 2 )) && die
	local condition="${1}"
	local payload="${2}"

	local tokens=()
	_rindeal:dsf:tokenize "${condition}" tokens
	local type=
	_rindeal:dsf:get_expr_type tokens type

	_rindeal:dsf:eval_${type} tokens "${payload}"
}

rindeal:expand_vars() {
	local f_in="${1}"
	local f_out="${2}"
	(( $# > 2 || $# < 1 )) && die

	local sed_args=()
	local v vars=( $( grep -Eo '@[A-Z0-9_]+@' -- "${f_in}" | tr -d '@') )
	for v in "${vars[@]}" ; do
		if [[ -v "${v}" ]] ; then
			sed_args+=( -e "s|@${v}@|${!v}|g" )
		else
			einfo "${FUNCNAME}: var '${v}' doesn't exist"
		fi
	done

	local basedir="$(dirname "${WORKDIR}")"
	echo "Converting '${f_in#"${basedir}/"}' -> '${f_out#"${basedir}/"}"

	sed "${sed_args[@]}" -- "${f_in}" >"${f_out}" || die
}

rindeal:dsf:prefix_flags() {
	(( $# < 2 )) && die

	local prefix="$1" ; shift
	local f flags=( "$@" )
	local regex="^([+-])?(.*)"

	for f in "${flags[@]}" ; do
		[[ "${f}" =~ ${regex} ]] || die
		printf "%s%s%s\n" "${BASH_REMATCH[1]}" "${prefix}" "${BASH_REMATCH[2]}"
	done
}


_RINDEAL_UTILS_ECLASS=1
fi
