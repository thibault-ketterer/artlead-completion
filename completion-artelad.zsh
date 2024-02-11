
#compdef artelad

_generate_artelad_completions() {
    local -a commands
    local state
    local curcontext="$curcontext" ret=1

    typeset -A opt_args
    local cur prev opts line

    _arguments -C \
        '1: :->command' \
        '2: :->subcommand' \
        '3: :->subsubcommand' \
        '*::arg:->args'

    case $state in
    command)
        commands=("${(@f)$(artelad --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')}")
        commands+=("${(@f)$(artelad --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)}")
        _describe 'command' commands
        ;;
    subcommand)
        local command=$words[2]
        commands=("${(@f)$(artelad $command --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')}")
        commands+=("${(@f)$(artelad $command --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)}")
        _describe 'subcommand' commands
        ;;
    subsubcommand)
        local command=$words[2]
        local subcommand=$words[3]
        commands=("${(@f)$(artelad $command $subcommand --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')}")
        commands+=("${(@f)$(artelad $command $subcommand --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)}")
        _describe 'subsubcommand' commands
        ;;
    esac

    return ret
}

compdef _generate_artelad_completions artelad

