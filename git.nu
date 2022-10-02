export def git-diff [revision?: string, --cached, --stat] {
    if ($cached && (not ($revision | is-empty))) {
        error make {msg: "--cached may not be used with a revision"}
    }
    let args = (
        [
            (if $cached { '--cached' } else { null })
            (if $stat { '--stat=200,200' } else { null })
            (if not ($revision | is-empty) { $revision } else { null })
        ] | where -b { not ($in | is-empty) }
    )
    git diff $args -- $env.GIT_PATHS
}

export def 'git-diff origin-main' [] {
    git-diff $'(git-branch origin-main)...'
} 

export def 'git-branch origin-main' [] {
    git-branch-main-or-master -r 'origin/main' 'origin/master'
}

export def 'git-branch main' [] {
    git-branch-main-or-master 'main' 'master'
}

def git-branch-main-or-master [name1: string, name2: string, --remote (-r)] {
    let branches = if $remote {
        git branch -r --format %(refname:short)  
    } else {
        git branch --format %(refname:short)  
    }
    let candidates = (
      $branches | lines
                | find -r $"^\(($name1)|($name2)\)$"
    )
    if ($candidates | is-empty) {
        print $'Error: neither ($name1) nor ($name2) exist'
    } else if ($candidates | length) != 1 {
        print $"Error: multiple candidates for main branch: ($candidates)"
    } else {
        $candidates | first
    }
}

export def git-checkout [n: int = 8] {
    $in | or-else { (^git branch-by-date | take $n | fzf-cmd | split words | first) }
        | and-then { git checkout $in }
}

export def 'git-checkout origin-main' [] {
    let main = (git-branch origin-main)
    print $"git checkout ($main)"
    git checkout $main
}

export def 'git-log origin-branch' [] {

}

export def 'git-rebase origin-main' [] {
    let main = (git-branch origin-main)
    print $"git rebase ($main)"
    git rebase $main
}

export def 'git-reset origin-main' [--hard (-h)] {
    let main = (git-branch origin-main)
    if $hard {
        git reset --hard $main
    }
}


export def 'git-untracked' [] {
    git status -uall
}