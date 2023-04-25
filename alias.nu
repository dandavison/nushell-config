export def git-branch-by-date [] {
    git branch-by-date | lines | parse '{branch}@{when}'
}
export def b [] { git-branch-by-date | first 10 }
old-alias bash = SHELL=bash bash
alias bat = ^bat --theme GitHub --style header,grid
# def 'bazel query' [query: string] {
#     ^bazel query --noshow_progress --noshow_loading_progress --ui_event_filters $"'($query)'"
# }
# alias bazel-query = ^bazel query --noshow_progress --noshow_loading_progress --ui_event_filters
alias cat = ^bat --plain --theme GitHub
alias cd = pm cd
alias cdd = pm cd
alias clipboard-restart  = killall pboard
alias code = code-with-workspace
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
alias gcc = git-checkout
export def gcm [] {
    git-branch main | and-then { git-checkout $in }
}
alias gcoa  = git commit --amend
alias gcoan  = git commit --amend --no-edit
alias gcon  = git commit --no-edit
export def gcom [] {
    git-branch origin-main | and-then { git-checkout $in }
}
alias gcp  = git cherry-pick
alias gd = git diff
alias gdc = git diff --cached
alias gdom = git diff origin/master
alias gds = git diff --stat=250
alias gdsom = gds origin/master...
alias gdsc = gds --cached
alias gdcs = gdsc
alias gfom = git fetch origin (git-branch main)
export def gfrhom [] {
    git fetch origin; git-reset --hard (git-branch origin-main)
}
alias git-untracked-files = git ls-files --others --exclude-standard
export def git-user-public [] {
    git config user.name "Dan Davison"; git config user.email "dandavison7@gmail.com"
}
alias gl = git log --stat
alias glp  = git log --stat -p
alias glob = git log $"origin/(git rev-parse --abbrev-ref HEAD | str trim -r)"
export def glom [] {
    git log (git-branch origin-main)
}
alias gp = git pull
alias gpd = async-git-prompt-delete-cache
alias grv  = git revert --no-edit
export def gpob [] {
    git pull origin (git rev-parse --abbrev-ref HEAD | str trim -r)
}
alias gr = git-reset
alias grb  = git rebase
alias grbc  = grb --continue
alias grbom = git rebase (git-branch origin-main)
alias grh = git-reset --hard
alias grhh = git reset --hard HEAD # git-stash save /tmp/grhh.diff
export def grh1 [] {
    gr 1; grhh
}
export def grhom [] {
    git-reset --hard (git-branch origin-main)
}
alias gri = git-rebase-interactive
export def grim [] {
    git rebase --interactive (git-branch main)
}
alias gco  = git commit
export def griom [] {
    git rebase --interactive (git-branch origin-main)
}
alias grba  = grb --abort
alias grm = git remote
alias gsta = git-stash apply
alias gsts = git-stash save
alias gstsp = git-stash show
alias gu = git status -uall
alias ha = $nu.scope.aliases
alias hc = help commands
alias hf = help-find
export def lss [] {
    ls | get name | str collect $"  "
}
alias mk = mkdir
alias np  = ping -c 1 www.gov.uk
alias p = pm
alias r = async-git-prompt-refresh-cache
alias rgd = rg-delta
alias te = table -e
alias tn = to nuon
alias vs = view-source
alias vscode = edit
alias v = vscode
alias z = zed
