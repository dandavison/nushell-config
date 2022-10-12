use stdlib.nu and-then
use lib.nu fzf
use ~/src/pm/pm.nu 'pm switch'

export def COMMANDS [] {
  ['app' 'book' 'project']
}

export def open-app [] {
  fd -d 1 '.+\.app' /Applications /System/Applications /System/Applications/Utilities
    | rg -r '$2$1' '^(.*/([^/]+)\.app)/$'
    | fzf '--with-nth' 1 '-d' /
    | str replace '[^/]+/' '/'
    | and-then { ^open $in }
}

export def open-book [] {
  fd -d 1 '.+\.pdf' `~/GoogleDrive/Literature/Computer Science/`
  | fzf '-d' / '--with-nth' 7
  | str trim -r
  | and-then { ^open $in }
}

export def M-x [] {
  let cmd = (COMMANDS | str join "\n"
                      | fzf '--height' 10 '--layout' reverse-list)
  if $cmd == 'app' {
    open-app
  } else if $cmd == 'book' {
    open-book
  } else if $cmd == 'project' {
    pm switch
  }
}
