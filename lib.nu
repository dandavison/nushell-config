def bsp-project [] {
  if ((".bloop" | path type) == "symlink") {
    ".bloop"
    | path expand
    | path dirname
    | path basename
  } else {
    ""
  }
}

def help-find [pattern: string] {
  help --find $pattern
}

def rg-delta [pattern: string, path: string = "."] {
    rg --json $pattern $path | delta
}

def git-rebase-interactive [n: int] {
  git rebase --interactive $"HEAD~($n)"
}

def git-status [] {
    def print-line [prefix: string] {
        lines
        | take until $it =~ '\d+ files? changed'
        | each { |line| echo $"($prefix) ($line)" }
    }
    # અજ
    git -c delta.paging=never diff --stat --color=always strato/src strato/docs
    git -c delta.paging=never diff --stat --cached --color=always strato/src strato/docs
}
