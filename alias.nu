source '~/src/devenv/dotfiles/nu/alias-generated.nu'

alias bat = ^bat --theme GitHub --style header,grid
alias git-user-public = (git config user.name "Dan Davison"; git config user.email "dandavison7@gmail.com")
alias gpd = async-git-prompt-delete-cache
alias gpob = git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)
alias grh = git-reset --hard
alias gr = git-reset
alias gri = git-rebase-interactive
alias ha = $nu.scope.aliases
alias hc = help commands
alias hf = help-find
alias lss = (ls | get name | str collect $"  ")
alias mk = mkdir
alias r = async-git-prompt-refresh-cache
alias rgd = rg-delta
