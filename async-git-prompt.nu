# This module exports commands for creating a nushell prompt that computes git status (staged and
# unstaged changes) asynchronously. This can be useful in large git repos when it is slow to obtain
# this information synchronously.

# To use this module:
#
# 1. Use the command `async-git-prompt-string` in your own `PROMPT_COMMAND`.
#    (The file prompt.nu contains an example.)
#    At this point, your prompt will be computing the information synchronously, because the cache
#    file does not yet exist.

# 2. In a repo where git is slow, run the command `async-git-prompt-refresh-cache`.
#    Now, your prompt will be fast, but it also won't update automatically. You could investigate a good
#    way to invalidate the cache automatically, but the manual alternative is:

# 3. Whenever you think your prompt might be stale, re-run the command `async-git-prompt-refresh-cache`.
#    Your prompt will update on one of the next times that you hit <enter>.

# 4. It will probably be convenient to alias this, e.g.
#
#    alias r = async-git-prompt-refresh-cache

# 5. To go back to synchronous mode, run `async-git-prompt-delete-cache`.


def unstaged-symbol [] { 'અ' }
def staged-symbol [] { 'જ' }
def in-progress-symbol [] { '…' }
def cache-file [] { '.nu-async-git-prompt-cache'}

export def async-git-prompt-string [] {
    let cache_path = (cache-path)
    if ($cache_path | empty?) {
        ""
    } else if ($cache_path | path exists) {
        open $cache_path | str trim
    } else {
        async-git-prompt-compute-sync
    }
}

export def async-git-prompt-compute-sync [] {
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

export def async-git-prompt-refresh-cache [] {
    let cache_path = (cache-path)
    echo (in-progress-symbol) | save $cache_path
    do-async $"use ($nu.config-path | path expand | path dirname)/async-git-prompt.nu *; async-git-prompt-compute-sync | save ($cache_path)"
}

export def async-git-prompt-delete-cache [] {
    rm -f (cache-path)
}

def cache-path [] {
    let dir = if ('.git' | path exists) {
        '.'
    } else {
        do -i { git rev-parse --show-toplevel | str trim -r }
    }
    if ($dir | empty?) {
        null
    } else {
        $dir | path join (cache-file)
    }
}
