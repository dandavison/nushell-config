# Open a file or directory in VSCode.
# With no input, select a project file.
export def vscode [path?: string] {
  let path = (if $path == null {
      (fzf-project-path)
    } else {
      $path
    }
  )
  if (not ($path | is-empty)) {
    ^code $path
  }
}

# Select a project dir to cd to.
export def-env 'project cd' [] {
  let dir = (fzf-project-dir)
  # The cd call must not be in a block in order to maintain def-env semantics.
  cd (if ($dir | is-empty) { '.' } else { $dir })
}

# Open all projects in VSCode (so that VSCode will thereafter open files in the correct workspace)
export def 'project open-all' [] {
  project-dirs | each { |dir| ^code $dir } | save /dev/null # vscode warns (on stdout) that it is being passed stdin
}

# Register a new project file
export def 'project add' [path: string] {
  $'($path)\n' | save --append (project-paths-file)
}

export def 'project edit-project-paths' [] {
  ^code (project-paths-file)
}

def fzf-project-path [] {
  project-paths | fzf-cmd | str trim -r
}

def fzf-project-dir [] {
  project-dirs | fzf-cmd | str trim -r
}

def project-paths-file [] { '~/.project-paths.txt' | path expand }

def project-paths [] {
  open (project-paths-file)
  | lines
  | where { |line| not ($line | str starts-with '#')}
  | sort
}

def project-dirs [] {
  project-paths
  | each { $in | path expand }
  | each { if (($in | path type) == 'dir') { $in } else { $in | path dirname }}
  | each { containing-repo $in }
  | uniq
  | where -b { (not ($in | is-empty)) }
  | sort
}

def containing-repo [dir: string, stack: int = 0] { # string | null
    if ($dir | path join '.git' | path exists) {
      $dir
    } else if ($dir != '/' && $dir != '') {
      if $stack > 20 {
        print $'Error: infinite recursion for $($dir)'
        null
      } else {
        containing-repo ($dir | path dirname) ($stack + 1)
      }
    } else {
      null
    }
}
