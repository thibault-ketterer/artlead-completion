
_generate_artelad_completions() {
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Identify the command or sub-command being used
    local command=""
    local subcommand=""
    local subsubcommand=""
    for ((i=1; i < COMP_CWORD; i++)); do
        if [[ "${COMP_WORDS[i]}" != -* ]]; then
            if [[ -z "$command" ]]; then
                command="${COMP_WORDS[i]}"
            elif [[ -z "$subcommand" ]]; then
                subcommand="${COMP_WORDS[i]}"
            else
                subsubcommand="${COMP_WORDS[i]}"
                break
            fi
        fi
    done

     # Fetch and parse options based on the current context
    if [[ -n "$subsubcommand" ]]; then
        # For sub-commands, parse their specific options
        # opts=$(artelad $command $subcommand --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)
        opts="$(artelad $command $subcommand $subsubcommand --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')"
        opts+=" $(artelad $command $subcommand $subsubcommand --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)"
    elif [[ -n "$subcommand" ]]; then
        # For sub-commands, parse their specific options
        # opts=$(artelad $command $subcommand --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)
        opts="$(artelad $command $subcommand --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')"
        opts+=" $(artelad $command $subcommand --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)"
    elif [[ -n "$command" ]]; then
        # For main commands without a sub-command, parse the main command's options
        # opts=$(artelad $command --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)
        opts="$(artelad $command --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')"
        opts+=" $(artelad $command --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)"
    else
        # For the base command, parse both global options and sub-commands
        opts="$(artelad --help 2>/dev/null | awk '/Commands:/,/^$/ {if (!/:/ && !/^$/ && $1) print $1}')"
        opts+=" $(artelad --help 2>/dev/null | grep -oE '\-\-[a-zA-Z0-9\-]+' | sort -u)"
    fi

    # Complete based on the current word
    if [[ "$cur" == --* ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    else
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    fi
}

complete -F _generate_artelad_completions artelad
