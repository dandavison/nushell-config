export def git-diff [revision?: string] {
    if not ($revision | is-empty) {
        git diff $revision -- $env.GIT_PATHS
    } else {
        git diff -- $env.GIT_PATHS
    }
}

def git-branch-main [] {
    let candidates = (
      git branch -r --format "%(refname:short)"
        | lines
        | find 'origin/main' 'origin/master'
    )
    if ($candidates | is-empty) {
        print "Error: neither origin/main nor origin/master exist"
    }
    if not (($candidates | length) == 1) {
        print $"Error: multiple candidates for main branch: ($candidates)"
    }
    $candidates | first
}

export def 'git-checkout main' [] {
    let main = (git-branch-main)
    print $"git checkout ($main)"
    git checkout $main
}

export def 'git-rebase main' [] {
    let main = (git-branch-main)
    print $"git rebase ($main)"
    git rebase $main
}
