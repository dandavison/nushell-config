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

export def exec-async [commands: string] {
    bash -c $"nu -c '($commands)' &"
}

export def do-async [block: block] {
  # block may call bultins and external commands only
  bash -c $"nu -c 'do (view-source $block)' &"
}

export def 'duti set-application' [extension: string] {
  ($extension | str starts-with '.') || (error make {msg: $'Extension must start with \'.\': ($extension)'})
  ^duti -s com.microsoft.VSCodeInsiders $extension all
}

export def fzf-cmd [] {
  str join "\n" | ^fzf --cycle --info hidden --ansi --color light --exact --prompt='  ' | str trim -r
}

export def app [] {
  ^open (fd -d 1 '.+\.app' /Applications /System/Applications /System/Applications/Utilities | fzf-cmd)
}

export def lit [] {
  ^open (fd -d 1 '.+\.pdf' `~/GoogleDrive/Literature/Computer Science/` | ^fzf --cycle --info hidden --ansi --color light --exact --prompt='  ' -d / --with-nth 7 | str trim -r)
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

export def "html table" [--body-only (-b)] {
  if $body_only {
    '<table>
    <tbody>
        <tr>
            <td></td>
        </tr>
    </tbody>
  </table>'
  } else {
    '<table>
    <thead>
        <tr>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
        </tr>
    </tbody>
  </table>'
  }
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

export def pid [] {
  pstree | rg -B 5 $nu.pid
}

export def rg-delta [
  pattern: string,
  path: string = ".",
  --before-context (-A): int,
  --after-context (-B): int,
  --context (-C): int,
  --fixed-strings (-F),
  --ignore-case (-i),
] {
  let rg_args = ([
    (if not ($before_context | is-empty) { ['-B' $before_context] } else { null })
    (if not ($after_context | is-empty) { ['-A' $after_context] } else { null })
    (if not ($context | is-empty) { ['-C' $context] } else { null })
    (if $fixed_strings { '-F' } else { null })
    (if $ignore_case { '-i' } else { null })
  ] | flatten | where -b { not ($in | is-empty) })
  print $'rg ($rg_args | str join " ") --json ($pattern) ($path) | delta'
  rg $rg_args --json $pattern $path | delta
}

def tee [] {
    let out = $in
    print $out
    $out
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
