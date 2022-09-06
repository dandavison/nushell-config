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

export def chrome [path: string] {
  ^open -a `/Applications/Google Chrome.app/` $path
}

export def do-async [commands: string] {
    bash -c $"nu -c '($commands)' &"
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

export def help-find [pattern: string] {
  help --find $pattern
}

export def rg-delta [pattern: string, path: string = ".", ...rg_args: string] {
    rg $rg_args --json $pattern $path | delta
}

export def time-now [] {
  let time = (date format '%s %f' | split column ' ' sec ns | first)
  (($time | get sec | into int) * 1sec) + (($time | get ns | into int) * 1ns)
}

export def time [block: block] {
  let t0 = (time-now)
  do $block
  let t1 = (time-now)
  $t1 - $t0
}

export def which-follow [name: string] {
  which -a $name | each {|it| echo $it | path expand -c ['path'] }
}