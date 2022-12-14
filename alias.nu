alias b = (git branch-by-date | ^head -n 30)
# git branch-by-date | parse -r '(?P<branch>[^ ]+) +(?P<when>.+)\n' | take 30
alias bash = SHELL=bash bash
alias bat = ^bat --theme GitHub --style header,grid
alias cat  = bat --style header,grid
alias cd = pm cd
alias cdd = pm cd
alias clipboard-restart  = killall pboard
alias code = code with-workspace
alias eg  = emacs-magit-status
alias egs  = emacs-magit-show
alias en = exec nu
alias gs  = git show
alias gss = git show --stat=256,256
alias ga  = git add
alias gb  = git branch
alias gbcz  = git branch -C z
alias gbl = git blame
alias gc = git checkout
alias gcb = git checkout -b
alias gcc = git-checkout
alias gcm = (git-branch main | and-then { git-checkout $in })
alias gcoa  = git commit --amend
alias gcom = (git-branch origin-main | and-then { git-checkout $in })
alias gcp  = git cherry-pick
alias gd = git-diff
alias gdc = git-diff --cached
alias gdcs = gdsc
alias gdom = git diff $"(git-branch origin-main)..."
alias gds = git-diff --stat
alias gdsc = git-diff --cached --stat
alias gfom = git fetch origin (git-branch main)
alias gfrhom = (git fetch origin; git-reset --hard (git-branch origin-main))
alias git-untracked-files = git ls-files --others --exclude-standard
alias git-user-public = (git config user.name "Dan Davison"; git config user.email "dandavison7@gmail.com")
alias gl = git log --stat
alias glp  = git log --stat -p
alias glob = git log $"origin/(git rev-parse --abbrev-ref HEAD | str trim -r)"
alias glom = git log (git-branch origin-main)
alias gp = git pull
alias gpd = async-git-prompt-delete-cache
alias grv  = git revert --no-edit
alias gpob = git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)
alias gr = git-reset
alias grb  = git rebase
alias grbc  = grb --continue
alias grbom = git rebase (git-branch origin-main)
alias grh = git-reset --hard
alias grh1 = (gr 1; grhh)
alias grhh = git-stash save /tmp/grhh.diff
alias grhom = git-reset --hard (git-branch origin-main)
alias gri = git-rebase-interactive
alias grim = git rebase --interactive (git-branch main)
alias gco  = git commit
alias griom = git rebase --interactive (git-branch origin-main)
alias grba  = grb --abort
alias grm = git remote
alias gsta = git-stash apply
alias gsts = git-stash save
alias gstsp = git-stash show
alias gu = git status -uall
alias ha = $nu.scope.aliases
alias hc = help commands
alias hf = help-find
alias lss = (ls | get name | str collect $"  ")
alias mk = mkdir
alias mv = mv --force
alias np  = ping -c 1 www.gov.uk
alias p = pm
alias r = async-git-prompt-refresh-cache
alias rgd = rg-delta
alias te = table -e
alias tn = to nuon
alias v = vscode
alias vs = view-source
alias vscode = edit
alias z = zed
