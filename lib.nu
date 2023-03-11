export def-env br [] {
  mkdir $env.TMPDIR
  let cmd_file = ([$env.TMPDIR (random uuid)] | path join)
  touch $cmd_file
  broot --outcmd $cmd_file
  let cmd = (open $cmd_file | str trim)
  rm $cmd_file | ignore
  let dir = if (not ($cmd | is-empty)) and ($cmd | str starts-with "cd") {
    $cmd | str replace "^cd" "" | str trim | str substring "1,-1"
  } else {
    $env.PWD
  }
  cd $dir
}

export def browse [dir: string = "."] {
  ls $dir | get name
          | sort -i
          | to text
          | fzf '--tac'
          | do {
            let i = $in
            log $'LAST_EXIT_CODE: ($env.LAST_EXIT_CODE)'
            $i
          } | if $env.LAST_EXIT_CODE != 130 {
            if ($in | is-empty) {
                browse $'($dir)/..'
            } else {
              if (($in | path type) == 'dir') {
                browse $in
              } else {
                code-with-workspace $in
              }
            }
          }
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


export def count-lines [] {
    par-each {|p| ^wc -l $p | parse -r '(?<n>\d+)'}
        | get n
        | into int
        | math sum
}

export def count-lines-in-subdirectories [pattern: string] {
    fd $pattern . | lines
                  | par-each {|p| ^wc -l $p | parse -r '(?<loc>\d+) ./(?<dir>[^/]+)'}
                  | group-by dir
                  | transpose dir data
                  | par-each {|r| {dir: $r.dir loc: ($r.data.loc | into int | math sum)}}
                  | sort-by loc
}



export def exec-async [commands: string] {
    bash -c $"nu -c '($commands)' &"
}

export def do-async [block: block] {
  # block may call bultins and external commands only
  bash -c $"nu -c 'do (view-source $block)' &"
}

export def 'duti set-application' [extension: string] {
  ($extension | str starts-with '.') or (error make {msg: $'Extension must start with \'.\': ($extension)'})
  ^duti -s com.microsoft.VSCodeInsiders $extension all
}

export def fzf [...args] {
  ^fzf --cycle --info hidden --ansi --color light --exact --prompt='  ' --bind right:accept,left:abort $args | str trim -r
}

export def json-cat [file: string] {
  ^jq -C . $file | less
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
        | take until {|line| $line =~ '\d+ files? changed'}
        | each { |line| echo $"($prefix) ($line)" }
    }
    # અજ
    git -c delta.paging=never diff --stat --color=always strato/src strato/docs
    git -c delta.paging=never diff --stat --cached --color=always strato/src strato/docs
}

export def python-profile-viz [pstats_file_path: string] {
  if ($pstats_file_path | is-empty) {
    print "python -m cProfile -o out.prof foo.py"
    print "python-profile-viz out.prof"
  } else {
    gprof2dot --colour-nodes-by-selftime -f pstats $pstats_file_path | dot -T svg -o /tmp/out.svg
    ^open /tmp/out.svg  
  }
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

export def sockets [--abbreviate-java-class-paths (-j)] {
  let input = (^lsof +c 0xFFFF -i -n -P)
  let header = ($input | lines
                       | take 1
                       | each { str downcase | str replace ' name$' ' name state' })
  let body = ($input | lines
                     | skip 1
                     | each { str replace '([^)])$' '$1 (NONE)' | str replace ' \((.+)\)$' ' $1' })
  [$header] | append $body
            | to text
            | detect columns
            | upsert 'pid' { |r| $r.pid | into int }
            | rename -c ['name' 'connection']
            | reject 'command'
            | join (ps -l) 'pid'
            | if $abbreviate_java_class_paths {
                upsert 'classpath' { |r| $r.command | java-cmd classpath }
                | upsert 'command' { |r| $r.command | java-cmd abbreviate-classpath }
              } else { $in }
}

export def join-table [table: table, left_on: string, right_on: string] {
  # into df | join ($table | into df) --outer $left_on $right_on | into nu
  $in
}

export def 'java-cmd classpath' [] {
  str replace '.* -classpath +(.+\.jar) +.*' '$1' | split row ':'
}

export def 'java-cmd abbreviate-classpath' [] {
  str replace '[^ ]*\.jar' '*.jar'
}

export def kill-all [name: string] {
  ps | where name == $name | get pid | each { |it| kill -9 $it }
}

def log [msg: string] {
  $msg | str replace '$' "\n" | save -a '/tmp/log.txt'
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

export def 'github checkout' [] { # input: e.g. 'raccmonteiro:command-url-parse'
  let i = ($in | parse '{user}:{branch}' | get 0)
  if (git remote | find $i.user | is-empty) {
    let repo = ((git remote get-url origin | parse '{_1}@github.com:{_2}/{repo}').repo.0 | str trim -r)
    git remote add $i.user $'git@github.com:($i.user)/($repo)'
  }
  git fetch $i.user
  git checkout -B $'($i.user)-($i.branch)' $'($i.user)/($i.branch)'
}

export def pid [] {
  pstree | rg -B 5 $nu.pid
}

export def rg-delta [
  pattern: string,
  path: string = "",
  --before-context (-A): int,
  --after-context (-B): int,
  --context (-C): int,
  --fixed-strings (-F),
  --glob (-g): string,
  --ignore-case (-i),
  --no-filename (-I),
  --files-with-matches (-l),
] {
  let path = if ($path | is-empty) {
    if ('GIT_DEFAULT_PATH' in $env) {
      $env.GIT_DEFAULT_PATH
    } else {
      '.'
    }
  } else {
    $path
  }
  let rg_args = ([
    (if not ($before_context | is-empty) { ['-B' $before_context] } else { null })
    (if not ($after_context | is-empty) { ['-A' $after_context] } else { null })
    (if not ($context | is-empty) { ['-C' $context] } else { null })
    (if $fixed_strings { '-F' } else { null })
    (if not ($glob | is-empty) { ['-g' $glob] } else { null })
    (if $ignore_case { '-i' } else { null })
    (if $no_filename { '-I' } else { null })
  ] | flatten | where { not ($in | is-empty) })
  if $files_with_matches {
    rg -l $rg_args $pattern $path | lines
                                  | each {|p| $'file-line-column://($env.PWD)/($p)'
                                  | str hyperlink $p}
                                  | to text
  } else {
    # print $'rg ($rg_args | str join " ") --json ($pattern) ($path) | delta'
    rg $rg_args --json $pattern $path | delta
  }
}

export def 'set difference' [s2: table] {
  # nushell doesn't have a hash table so quadratic time complexity
  let s1 = $in
  let s2 = ($s2 | sort | uniq)
  $s1 | sort | uniq | where {|x| not ($x in $s2)}
}

export def 'set intersection' [s2: list] {
  # nushell doesn't have a hash table so quadratic time complexity
  let s1 = ($in | sort | uniq)
  let s2 = ($s2 | sort | uniq)
  $s1 | where {|x| not ($x in $s2)}
}


export def 'str hyperlink' [text: string] {
  # fn format_osc8_hyperlink(url: &str, text: &str) -> String {
  #     format!(
  #         "{osc}8;;{url}{st}{text}{osc}8;;{st}",
  #         url = url,
  #         text = text,
  #         osc = "\x1b]",
  #         st = "\x1b\\"
  #     )
  # }
  let url = $in
  let osc8 = (ansi -o '8;;')
  let st = (ansi st)
  $"($osc8)($url)($st)($text)($osc8)($st)"
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

export def code-with-workspace [path: string] {
  let dir = if (($path | path type) == 'dir') { $path } else { $path | path dirname }
  let repo_root = (^git -C $dir rev-parse --show-toplevel | str trim -r)
  ^code $repo_root # TODO: How to detect whether VSCode workspace already exists?

  # TODO: There might be a race condition here (i.e. might it open $path before workspace is ready?), but it's
  # worked correctly so far. It's unclear how to query for whether the workspace exists and is ready.
  ^code -g $path
}

# Open a file or directory in VSCode.
# With no input, select a project and open the editor in that project.
export def edit [path?: string --emacs] { # -> Void
  if ($path | is-empty) {
    pm switch $nothing 'edit .'
  } else {
    if $emacs {
        ^emacsclient -n $path
    } else {
        code-with-workspace $path
    }
  }
}

export def kill-less [] {
  let t = (ps | where name =~ less)
  if not ($t | is-empty) {
   $t | get pid | each {|n| kill -9 $n}
  }
}