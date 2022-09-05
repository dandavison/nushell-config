def unstaged-symbol [] { 'અ' }
def staged-symbol [] { 'જ' }
def in-progress-symbol [] { '…' }
def git-status-prompt-cache-file [] { '.nu-git-status-prompt-cache'}

export def git-status-prompt [] {
    let cache_path = (git-status-prompt-cache-path)
    if ($cache_path | empty?) {
        ""
    } else if ($cache_path | path exists) {
        open $cache_path | str trim
    } else {
        compute-git-status-prompt
    }
}

export def compute-git-status-prompt [] {
    let unstaged = {
        let symbol = if ((git diff --quiet | complete).exit_code == 1) {
            (unstaged-symbol)
        } else {
            ''
        }
        { unstaged: $symbol}        
    }
    let staged = {
        let symbol = if ((git diff --cached --quiet | complete).exit_code == 1) {
            (staged-symbol)
        } else {
            ''
        }
        { staged: $symbol}
    }
    # Execute the two slow git commands in parallel and merge the results into a single record
    let symbols = ([ $unstaged $staged ] | par-each { |it| do $it } | reduce {|a b| $a | merge {$b}})

    $"($symbols | get 'unstaged') ($symbols | get 'staged')" | str trim
}

export def git-status-prompt-refresh-cache [] {
    let cache_path = (git-status-prompt-cache-path)
    echo (in-progress-symbol) | save $cache_path
    do-async $"use ($nu.config-path | path expand | path dirname)/git-status-prompt.nu *; compute-git-status-prompt | save ($cache_path)"
}

export def git-status-prompt-delete-cache [] {
    rm -f (git-status-prompt-cache-path)
}

def git-status-prompt-cache-path [] {
    let dir = if ('.git' | path exists) {
        '.'
    } else {
        do -i { git rev-parse --show-toplevel | str trim -r }
    }
    if ($dir | empty?) {
        null
    } else {
        $dir | path join (git-status-prompt-cache-file)
    }
}
