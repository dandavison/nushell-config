let-env NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path expand)
  ($nu.config-path | path dirname | path expand | path join "lib")
]
let-env PATH = (
  '/opt/twitter_mde/bin:/opt/twitter_mde/homebrew_minimal/mde_bin:/Users/ddavison/.nvm/versions/node/v14.9.0/bin:/Users/ddavison/.pyenv/shims:/Users/ddavison/bin:/Users/ddavison/.local/bin:/Users/ddavison/src/emacs-config/bin:/Users/ddavison/.cargo/bin:/opt/homebrew/opt/postgresql/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/sbin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/twitter_mde/data/node/bin:/Users/ddavison/.npm-global/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Applications/Sublime Text.app/Contents/SharedSupport/bin:/opt/twitter_mde/data/gcloud/current/mde_bin:~/tmp/3p/fzf_browser'
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
let-env OPEN_IN_EDITOR = '/Users/ddavison/bin/code'


ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
