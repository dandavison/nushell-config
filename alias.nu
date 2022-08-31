source '~/src/devenv/dotfiles/nu/alias-generated.nu'

alias bat = ^bat --theme GitHub --style header,grid
alias git-user-public = (git config user.name "Dan Davison"; git config user.email "dandavison7@gmail.com")
alias gpd = git-status-prompt-delete-cache
alias gpob = git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)
alias r = git-status-prompt-refresh-cache
alias grh = git-reset --hard
alias gr = git-reset
alias gri = git-rebase-interactive
alias ha = $nu.scope.aliases
alias hc = help commands
alias hf = help-find
alias lss = (ls | get name | str collect $"  ")
alias mk = mkdir
alias rgd = rg-delta
