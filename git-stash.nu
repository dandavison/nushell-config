def STASH_DIR [] { "~/tmp/git-stash" | path expand }

def stash-file [stash?: string] {
    let stash = if ($stash | is-empty) {
        date now | date format '%y-%m-%d--%H-%M-%S%.f'
    } else {
        $stash
    }
    if not ($stash | str starts-with "/") {
        $"(STASH_DIR)/($stash)"
    } else {
        $stash
    }
}

export def 'git-stash save' [stash?: string] {
    let stash = (stash-file $stash)
    ^git diff HEAD -- $env.GIT_PATHS | save $stash
    open $stash | ^git apply -R
}

export def 'git-stash apply' [] {
    ls ~/tmp/git-stash | sort-by -r modified
                       | get name
                       | to text
                       | fzf '--delimiter' / '--with-nth' 6
                       | str trim -r
                       | tee
                       | and-then { ^git apply $in }
}

export def 'git-stash list' [] {
    ls (STASH_DIR)
}

export def 'git-stash show' [stash: string] {
    open (stash-file $stash) | ^delta
}
