_faker.php()
{
    COMPREPLY=()
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    local line=${COMP_LINE}
    local cmd="${1##*/}"
    local subcommand=${COMP_WORDS[1]}

    local PARAM_LOCALE=''
    local subcommands='list-types'
    local opts="-l --locale -s --seed -p --pattern -d --delimiter -e --enclosure -E --escape -f --format -c --count"

    if [[ ${COMP_CWORD} == 1 ]]; then
        local types=$(faker.php list-types ${PARAM_LOCALE} 2> /dev/null | awk '{print $1}')
        COMPREPLY=( $(compgen -W "${subcommands} ${types} ${opts}" -- ${cur}) )
        return 0
    fi

    if [[ ${subcommand} != -* ]]; then
        return 0
    fi

    for index in "${!COMP_WORDS[@]}"; do
        local arg=${COMP_WORDS[$index]}

        case "$arg" in
            -l) [[ -n "${COMP_WORDS[$index+1]}" ]] && PARAM_LOCALE=" -l ${COMP_WORDS[$index+1]}"
                break
                ;;
            --locale) [[ -n ${COMP_WORDS[$index+1]} ]] && PARAM_LOCALE=" -l ${COMP_WORDS[$index+1]}"
                break
                ;;
        esac
    done

    if [[ ${cur} == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    if type awk >/dev/null 2>/dev/null; then
        local types=$(faker.php list-types ${PARAM_LOCALE} 2> /dev/null | awk '{print $1}')
        COMPREPLY=( $(compgen -W "${types}" -- ${cur}) )
    fi

    return 0
}

complete -F _faker.php faker.php
complete -F _faker.php faker.phar

