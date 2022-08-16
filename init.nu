let-env PATH = (
  '/opt/twitter_mde/bin:/opt/twitter_mde/homebrew_minimal/mde_bin:/Users/ddavison/.nvm/versions/node/v14.9.0/bin:/Users/ddavison/.pyenv/shims:/Users/ddavison/bin:/Users/ddavison/.local/bin:/Users/ddavison/src/emacs-config/bin:/Users/ddavison/.cargo/bin:/opt/homebrew/opt/postgresql/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/sbin:/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/twitter_mde/data/node/bin:/Users/ddavison/.npm-global/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Applications/Sublime Text.app/Contents/SharedSupport/bin:/opt/twitter_mde/data/gcloud/current/mde_bin'
  | split row ':'
)

source '~/src/devenv/dotfiles/nu/alias-generated.nu'
alias bat = ^bat --theme GitHub --style header,grid
alias hc = help commands
alias hf = help-find
alias lss = (ls | get name | str collect $"  ")
alias mk = mkdir

alias gpob = git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)

# 1..9 | each { |it| alias $"gri($it)" = git rebase --interactive $"HEAD~($it)" }
alias gri1 = git rebase --interactive HEAD~1
alias gri2 = git rebase --interactive HEAD~2
alias gri3 = git rebase --interactive HEAD~3
alias gri4 = git rebase --interactive HEAD~4
alias gri5 = git rebase --interactive HEAD~5
alias gri6 = git rebase --interactive HEAD~6
alias gri7 = git rebase --interactive HEAD~7
alias gri8 = git rebase --interactive HEAD~8
alias gri9 = git rebase --interactive HEAD~9

alias grh1 = git reset --hard HEAD~1

alias rgd = rg-delta

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
let-env OPEN_IN_EDITOR = '~/bin/code'

source '~/src/devenv/dotfiles/nu/init-local.nu'

def help-find [pattern: string] {
  help --find $pattern
}

def rg-delta [pattern: string, path: string = "."] {
    ^rg --json $pattern $path | ^delta
}

def git-status [] {
    def print-line [prefix: string] {
        lines | take until $it =~ '\d+ files? changed' | each { |line| echo $"($prefix) ($line)" }
    }
    # અજ
    git -c delta.paging=never diff --stat --color=always strato/src strato/docs
    git -c delta.paging=never diff --stat --cached --color=always strato/src strato/docs
}

