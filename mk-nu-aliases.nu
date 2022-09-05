(open ~/src/devenv/shell-config/alias.sh
    | lines
    # Exclude things other than one-liner alias definitions
    | where ($it | str starts-with 'alias')
    # Exclude bash/zsh subshells
    | where not ($it | str contains '$(')
    # Exclude for/while loops
    | where not ($it | str contains '; do ')
    # Exclude/handle aliases conflicting with builtins
    | where not ($it | str starts-with 'alias ls=')
    | where not ($it | str starts-with 'alias mk=')
    | where not ($it | str starts-with 'alias path=')
    | str replace -a 'open' '^open'
    # Exclude zsh global aliases
    | where not ($it | str starts-with 'alias -g')
    # Use ; for 'AND' semantics
    | str replace -a '&&' ';'
    # Strip quotes
    | str replace "alias ([^=]+) *=' *([^']+)'" 'alias $1 = $2'
    | str replace 'alias ([^=]+) *=" *([^"]+)"' 'alias $1 = $2'
    # Wrap pipelines and command-sequences in ()
    | str replace 'alias ([^=]+) *= *([^(#]*[|;][^#]*)(.*)' 'alias $1 = ($2)$3'
    # Ensure there are spaces around '='
    | str replace 'alias ([^=]+) *= *(.+)' 'alias $1 = $2'
    # Save
    | save 'alias-generated.nu'
)
