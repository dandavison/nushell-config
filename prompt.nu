use async-git-prompt.nu *

def prompt-concat [parts: table] {
    $parts
    | where (not ($it.text | is-empty))
    | each { |it| $"($it.color)($it.text)(ansi reset)" }
    | str join ' '
}

def prompt-git-branch [] {
    do -i { git rev-parse --abbrev-ref HEAD | str trim -r}
}

def prompt-overlays [] {
    overlay list | skip 1 | str join ' '
}

def prompt-create-left-prompt [] {
    let pwd = ($env.PWD | str replace $env.HOME '~' | path basename)
    prompt-concat [
        {text: (prompt-overlays), color: (ansi green_bold)}
        # {text: $pwd, color: (ansi green_bold)}
        {text: (prompt-git-branch), color: (ansi blue_bold)}
        {text: (async-git-prompt-string), color: (ansi green_bold)}
    ]
}

let-env PROMPT_COMMAND = { prompt-create-left-prompt }
let-env PROMPT_COMMAND_RIGHT = { $nothing }
let-env PROMPT_INDICATOR = { $" (ansi green_bold)〉" }
