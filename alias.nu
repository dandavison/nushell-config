source ~/src/devenv/dotfiles/nu/alias-generated.nu

alias \ = exec nu
alias bat = ^bat --theme GitHub --style header,grid
alias cdd = project cd
alias en = exec nu
alias gd = git-diff
alias gdc = git diff --cached $env.GIT_PATHS
alias gdcs = gdsc
alias gds = git diff --stat=200,200 $env.GIT_PATHS
alias gdsc = git diff --cached --stat=200,200 $env.GIT_PATHS
alias git-untracked-files = git ls-files --others --exclude-standard
alias git-user-public = (git config user.name "Dan Davison"; git config user.email "dandavison7@gmail.com")
alias gpd = async-git-prompt-delete-cache
alias gpob = git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)
alias gr = git-reset
alias grh = git-reset --hard
alias grh1 = (gr 1; grhh)
alias grhh = git-stash save /tmp/grhh.diff
alias gri = git-rebase-interactive
alias gsta = git-stash apply
alias gsts = git-stash save
alias gstsp = git-stash show
alias ha = $nu.scope.aliases
alias hc = help commands
alias hf = help-find
alias lss = (ls | get name | str collect $"  ")
alias mk = mkdir
alias p = probable-path
alias r = async-git-prompt-refresh-cache
alias rgd = rg-delta
alias v = vscode
alias vs = view-source