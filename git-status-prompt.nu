let dan_git_status_prompt_cache_file = '.dan-git-status-prompt-cache'
let dan_unstaged_symbol = 'અ'
let dan_staged_symbol = 'જ'
let dan_in_progress_symbol = '…'

def dan-git-status-prompt [] {
    let cache_path = (dan-git-status-prompt-cache-path)
    if ($cache_path | empty?) {
        ""
    } else if ($cache_path | path exists) {
        open $cache_path | str trim
    } else {
        dan-compute-git-status-prompt
    }
}

def dan-git-status-prompt-cache-path [] {
    let dir = if ('.git' | path exists) {
        '.'
    } else {
        do -i { git rev-parse --show-toplevel | str trim -r }
    }
    if ($dir | empty?) {
        null
    } else {
        $dir | path join $dan_git_status_prompt_cache_file
    }
}

def dan-compute-git-status-prompt [] {
    let unstaged = {
        let symbol = if ((git diff --quiet | complete).exit_code == 1) {
            $dan_unstaged_symbol
        } else {
            ''
        }
        { unstaged: $symbol}        
    }
    let staged = {
        let symbol = if ((git diff --cached --quiet | complete).exit_code == 1) {
            $dan_staged_symbol
        } else {
            ''
        }
        { staged: $symbol}
    }
    let symbols = ([ $unstaged $staged ] | par-each { |it| do $it } | reduce {|a b| $a | merge {$b}})

    $"($symbols | get 'unstaged') ($symbols | get 'staged')" | str trim
}

def git-status-prompt-refresh-cache [] {
    let cache_path = (dan-git-status-prompt-cache-path)
    echo $dan_in_progress_symbol | save $cache_path
    do-async $"source ~/src/devenv/dotfiles/nu/git-status-prompt.nu; dan-compute-git-status-prompt | save ($cache_path)"
}

def git-status-prompt-delete-cache [] {
    rm -f (dan-git-status-prompt-cache-path)
}
