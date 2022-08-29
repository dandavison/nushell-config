export def do-async [commands: string] {
    bash -c $"nu -c '($commands)' &"
}

export def bsp-project [] {
  if ((".bloop" | path type) == "symlink") {
    ".bloop"
    | path expand
    | path dirname
    | path basename
  } else {
    ""
  }
}

export def help-find [pattern: string] {
  help --find $pattern
}

export def rg-delta [pattern: string, path: string = "."] {
    rg --json $pattern $path | delta
}

export def git-rebase-interactive [n: int] {
  git rebase --interactive $"HEAD~($n)"
}

export def git-reset [n: int, --hard] {
  let commit = $"HEAD~($n)"
  if $hard {
    git reset --hard $commit
  } else {
    git reset $commit
  }
}

export def git-status [] {
    def print-line [prefix: string] {
        lines
        | take until $it =~ '\d+ files? changed'
        | each { |line| echo $"($prefix) ($line)" }
    }
    # અજ
    git -c delta.paging=never diff --stat --color=always strato/src strato/docs
    git -c delta.paging=never diff --stat --cached --color=always strato/src strato/docs
}
