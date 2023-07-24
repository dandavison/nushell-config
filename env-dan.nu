let-env NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path expand)
  ($nu.config-path | path dirname | path expand | path join "lib")
]
let-env PATH = (
  '/Users/dan/.pyenv/shims:/Users/dan/bin:/Users/dan/.local/bin:/Users/dan/src/devenv/emacs-config/bin:/Users/dan/.cargo/bin:/opt/homebrew/opt/postgresql/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/sbin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/dan/.npm-global/bin'
  | split row ':'
)
let-env ALTERNATE_EDITOR = 'emacs -nw -q'
let-env BAT_THEME = 'GitHub'
let-env DELTA_PAGER = 'less -FRSX'
let-env EDITOR = 'emacsclient -n'
let-env FZF_DEFAULT_COMMAND = 'fd --type file --color=always'
let-env FZF_DEFAULT_OPTS = '--ansi'
let-env GIT_SEQUENCE_EDITOR = 'emacsclient'
let-env HOMEBREW_NO_AUTO_UPDATE = 1
let-env INFOPATH = '/opt/homebrew/share/info'
let-env LESS = '-FIRXS'
let-env LS_COLORS = (^vivid generate one-light | str trim)
let-env MANPATH = '/opt/homebrew/share/man'
let-env NU_MAX_NORMALIZED_EDIT_DISTANCE_FOR_SUGGESTIONS = 0.6
let-env NU_MIN_WORD_LENGTH_FOR_SUGGESTIONS = 3
let-env OPEN_IN_EDITOR = '/Users/dan/bin/code'


ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
