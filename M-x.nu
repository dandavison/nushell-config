use stdlib.nu and-then
use lib.nu fzf
use ~/src/pm/pm.nu 'pm switch'
# use ~/src/pm/pm.nu code-with-workspace

export def COMMANDS [] {
  ['app' 'book' 'project' 'vscode' 'vscode-project']
}

export def open-app [] {
  ^fd -d 1 '.+\.app' /Applications /System/Applications /System/Applications/Utilities
    | rg -r '$2$1' '^(.*/([^/]+)\.app)/$'
    | fzf '--with-nth' 1 '-d' /
    | str replace '[^/]+/' '/'
    | and-then { ^open $in }
}

export def open-book [] {
  ^fd -d 1 '.+\.pdf' `~/Drive/Literature/Computer Science/`
  | fzf '-d' / '--with-nth' 7
  | str trim -r
  | and-then { ^open $in }
}

export def main [] {
  COMMANDS | str join "\n" | fzf '--height' 10 '--layout' reverse-list out> '/tmp/M-x-cmd'
  let cmd = (open -r '/tmp/M-x-cmd')
  if $cmd == 'app' {
    open-app
  } else if $cmd == 'book' {
    open-book
  } else if $cmd == 'project' {
    pm switch
  } else if $cmd == 'vscode' {
    vscode .
  } else if $cmd == 'vscode-project' {
    vscode
  }
}
