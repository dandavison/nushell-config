alias ..  = cd ..
alias R  = R --silent --no-restore --no-save --vanilla
alias agp  = ag --python
alias ansifilter   = (perl -pe 's/\e\[[0-9;]*[mK]//g')
alias b   = (git branch-by-date|head)
alias bat  = bat --style header,grid
alias c  = cat
alias co  = code
alias con  = code --new-window
alias coi  = /Applications/Visual\ Studio\ Code\ -\ Insiders.app/Contents/Resources/app/bin/code
alias cargo-test-fzf  = fzf-cargo-test
alias cat  = bat --style header,grid
alias cb  = cargo build
alias clipboard-restart  = killall pboard
alias count   = (sort | uniq -c | sort -rn)
alias ct  = cargo-test-fzf
alias ddbg   = (ln -fs ~/src/delta/target/debug/delta ~/bin/delta ; delta --version)
alias ddev   = (ln -fs ~/src/delta/target/release/delta ~/bin/delta ; delta --version)
alias drel   = (ln -fs /opt/homebrew/bin/delta ~/bin/delta; delta --version)
alias dh   = (delta -h | less)
alias dhh   = (delta --help | less)
alias di  = docker images
alias docker-clean   = (docker-rm-all ; docker-prune)
alias ds  = delta-side-by-side
alias e  = emacsclient -n
alias ee  = emacs -nw -q
alias ef  = emacs-find-file
alias eg  = emacs-magit-status
alias egd  = emacs-magit-diff
alias egr  = emacs-grep
alias egs  = emacs-magit-show
alias emacs-byte-compile  = emacs --batch --eval '(package-initialize)' -f batch-byte-compile
alias es  = emacs-grep
alias f  = fzf
alias fs  = cat-file
alias fo  = open-file
alias fr  = resolve-file
alias fzf  = fzf --exact
alias facet  = rlwrap facet
alias ff  = find . -type f -iname
alias fromip   = (who | grep \^$USER\" | sed 1q | perl -n -e 's,.*\(([0-9.]+)\),\1, and print'")
alias g  = rg
alias ga  = git add
alias gap  = git add -p
alias gar  = git apply -R -
alias gb  = git branch
alias gbcz  = git branch -C z
alias gbl  = git blame
alias gcal  = gcalcli calw --calendar ddavison@twitter.com
alias gcbb  = git-force-create-branch
alias gcln  = git clean -nd
alias gclo  = git clone
alias gcl  = git clean
alias gcmm   = (git branch master origin/master ; git checkout master)
alias gcm   = (git checkout master || git checkout main)
alias gcoa  = git commit --amend
alias gcof  = git-commit-file
alias gconfl  = git config -l
alias gconf  = git config --global
alias gco  = git commit
alias gcpa  = git cherry-pick --abort
alias gcp  = git cherry-pick
alias gcpc  = git cherry-pick --continue
alias gc  = git checkout
alias gcz  = fzf-git-checkout
alias gd  = git diff
alias gdcs  = gd --cached --stat=200,200
alias gdcw  = gd --cached --word-diff=color
alias gdc  = gd --cached
alias gdom  = gd origin/master...
alias gdp  = git-diff-prod
alias gdsc  = gd --cached --stat=200,200
alias gdsom  = gd --stat=200,200 origin/master...
alias gds  = gd --stat=200,200
alias gdwc  = gd --cached --word-diff=color
alias gdwwc  = gdww --cached
alias gdww  = gd --word-diff=color --word-diff-regex="[a-zA-z_]+"
alias gdw  = gd --word-diff=color
alias gdz  = gd z
alias gfc  = git-fuzzy-checkout
alias gf  = git fixup
alias gfom  = git fetch origin master
alias gg  = git grep -n
alias ghci  = ghci -fwarn-incomplete-patterns
alias ghrvw  = gh repo view --web
alias gitk-all  = gitk --all --simplify-by-decoration
alias git-init   = (git init ; git-user-public ; git commit --allow-empty -m "∅")
alias git-no-config  = GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG=/dev/null HOME=/dev/null git
alias git-user-public   = (git config user.name "Dan Davison" ; git config user.email "dandavison7@gmail.com")
alias git-user-twitter   = (git config user.name "Dan Davison" ; git config user.email "ddavison@twitter.com")
alias _gl  = git log --date relative
alias gl  = _gl --stat
alias gl1  = _gl --stat -n1
alias gla  = _gl --format="%an"
alias gld  = _gl --author=dan
alias glf  = _gl --pretty=fuller
alias glh  = _gl --oneline -n 20
alias glme  = _gl --author=dan
alias glp  = _gl -p
alias glsp  = _gl -p --stat
alias gls  = _gl --stat
alias gm  = git merge
alias gnp  = git --no-pager
alias gpom   = (git fetch origin master ; git branch -d master ; git branch master origin/master)
alias gpo  = git pull origin
alias gp  = git pull
alias gr1  = git reset HEAD~1
alias gr2  = git reset HEAD~2
alias grba  = grb --abort
alias grbc  = grb --continue
alias grbi  = grb --interactive
alias grb  = git rebase
alias grep  = grep --color=auto
alias gres  = git remote -v show
alias gre  = git remote
alias grhh  = git reset --hard HEAD
alias grh  = git reset --hard
alias gri  = grb --interactive
alias gr  = git reset
alias grim   = (gri main || gri master)
alias grv  = git revert --no-edit
alias gs  = git show
alias grvs   = (git show | git apply -R -)
alias gss  = gs --stat=256,256
alias gsta  = git stash apply
alias gstd  = git stash drop
alias gstk  = git stash save --keep-index
alias gstl  = git stash list
alias gstp  = git stash pop
alias gstr   = (git stash save ; git stash drop stash@{1})
alias gstsd  = git stash save debugging
alias gstsp  = git stash show -p
alias gsts  = git stash save `date "+%Y-%m-%d %H:%M"`
alias gst  = git status
alias gsww  = gs --word-diff=color --word-diff-regex="[a-zA-z_]+"
alias gsw  = gs --word-diff=color
alias h  = head
alias hset  = redis-cli hset
alias hibernateoff  = sudo pmset -a hibernatemode 0
alias hibernateon  = sudo pmset -a hibernatemode 5
alias hz  = fzf-hist-cp
alias hzx  = fzf-hist-x
alias idea  = /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea
alias ip = ipython
alias isort  = isort --force_single_line_imports --lines 999999 --dont-skip __init__.py
alias jp = jsonpipe
alias json-cat  = (jq -C . | less -RSX)
alias jc  = json-cat<
alias l  = git log
alias latex  = latex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}
alias less  = less -S
alias ll  = ls -l
alias lr  = latexrun --latex-args="-shell-escape" -O .build
alias ls-gnu  = /opt/homebrew/opt/coreutils/libexec/gnubin/ls -N --color=tty --hide="*.pyc" --hide=__pycache__ # --git-ignore ; --hide="*."{aux,out,log} if you get very annoyed by LaTeX
alias lt  = ls -lt
alias lth   = (ls -lt | head)
alias lsof-ports   = (lsof -i -n -P | rg -i LISTEN)
alias lsof-ports-all  = lsof -i -n -P
alias make-explain   = (make -rnd | perl -p -e 's,(^ +),\1\1\1\1,')
alias mypy  = mypy --check-untyped-defs
alias np  = ping -c 1 www.gov.uk
alias nwp = wifi-poke
alias p = python
alias pdfjoin  = pdfjoin --rotateoversize false
alias pdflatex  = pdflatex -shell-escape -interaction nonstopmode -output-directory=${LATEX_OUTPUT_DIRECTORY:-.}
alias pf  = pip freeze
alias pi  = pip install
alias pipn  = pip --disable-pip-version-check
alias ps-me  = ps -u `whoami`
alias ps1  = ps -Af f
alias psl   = (ps auxwww | less)
alias pu  = pip uninstall
alias pv  = python-virtualenv-activate
alias pwdr   = (pwd | sed "s,.*$HOME/,,")
alias pytest  = pytest --no-header
alias python-pdb  = python -m pdb -c continue
alias rm-tex  = rm -v *.{aux,log,out,toc}
alias rm-pyc  = find . -type f -name '*.pyc' -delete
alias rg  = rg --hidden #  --max-columns 1000
alias rgc  = rg --color=always
alias rgf  = rg --files
alias rn  = rename
alias rs  = rsync -z --progress
alias s  = fzf-rg-preview
alias sgg  = src-git-grep-scala-strato
alias ssh  = ssh -A
alias sw  = switchto website
alias t  = lsd --tree
alias tail-messages  = tail -f /var/log/messages
alias ta  = tmux attach
alias tb  = tmux-back
alias tctl  = docker exec temporal-admin-tools tctl
alias tcs  = tmux-current-session
alias tls  = tmux list-sessions -F "#S"
alias tl  = topleft
alias tmux-current-session  = tmux display-message -p "#S"
alias tns  = tmux new-session
alias tsc  = tmux switch-client -l
alias virtualenv-temp   = (rm -fr /tmp/v ; virtualenv /tmp/v ; . /tmp/v/bin/activate)
alias vpro  = vagrant provision
alias vssh  = vagrant ssh
alias vscode-list-contexts  = (cd ~/src/vscode ; rg --color=always RawContextKey)
alias xenops-cache-size   = (fd . /tmp/xenops-cache | wc -l)
alias xhyve-nsenter  = docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i
alias z-exec  = exec zsh
