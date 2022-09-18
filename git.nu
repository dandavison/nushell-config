export def git-diff [revision?: string, --stat] {
    if not ($revision | is-empty) {
        git diff $revision -- $env.GIT_PATHS
    } else {
        git diff -- $env.GIT_PATHS
    }
}

export def 'git-diff origin-main' [] {
    git-diff $'(git-branch origin-main)...'
} 

export def 'git-branch origin-main' [] {
    let candidates = (
      git branch -r --format "%(refname:short)"
        | lines
        | find 'origin/main' 'origin/master'
    )
    if ($candidates | is-empty) {
        print "Error: neither origin/main nor origin/master exist"
    } else if ($candidates | length) != 1 {
        print $"Error: multiple candidates for main branch: ($candidates)"
    } else {
        $candidates | first
    }
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