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

export def fzf-cmd [--help (-h)] {
  str collect "\n" | ^fzf --info=hidden | str trim -r
}

export def fzf-app [] {
  ^open (ls /Applications/*.app | get name | fzf-cmd)
}

export def git-rebase-interactive [arg] {
  let commit = if ($arg | describe) == int {
    $"HEAD~($arg)"
  } else {
    $arg
  }
  git rebase --interactive $commit
}

export def git-reset [arg, --hard] {
  let commit = if ($arg | describe) == int {
    $"HEAD~($arg)"
  } else {
    $arg
  }
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

export def kill-all [name: string] {
  ps | where name == $name | get pid | each { |it| kill -9 $it }
}

export def nu-binary [which?: string] {
  let link = '~/bin/nu'
  if ($which != null) {
    let target = if $which == 'release' {
      '~/src/nushell/nushell/target/release/nu'
    } else if $which == 'debug' {
      '~/src/nushell/nushell/target/debug/nu'
    } else if $which == 'homebrew' {
      '/usr/local/bin/nu'
    } else {
      1 / 0
    }
    ^ln -fs ($target | path expand) $link
  }
  echo (ls -ld ($link | path dirname))
  | where name =~ 'nu$'
  | where type == 'symlink'
  | select name type target
}

export def rg-delta [
  pattern: string,
  path: string = ".",
  --fixed-strings (-F),
  --ignore-case (-i),
] {
  let fixed_strings = if $fixed_strings { "-F" } else { "" }
  let ignore_case = if $ignore_case { "-i" } else { "" }
  let rg_args = ([$fixed_strings $ignore_case] | str join " " | str trim)
  # echo $"rg ($rg_args) --json ($pattern) ($path) | delta"
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
