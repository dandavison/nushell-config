def dan-concat [parts: table] {
    $parts
    | where (not ($it.text | empty?))
    | each { |it| $"($it.color)($it.text)" }
    | str collect ' '
}

def dan-create-left-prompt [] {
    let branch = (do -i { git rev-parse --abbrev-ref HEAD | str trim -r})
    let pwd = ($env.PWD | str replace $env.HOME '~' | str replace '~/workspace' '...')
    dan-concat [
        {text: $pwd, color: (ansi green_bold)}
        {text: (bsp-project), color: (ansi red_bold)}
        {text: $branch, color: (ansi blue_bold)}
    ]
}

def dan-create-right-prompt [] {
    $nothing
}

let-env PROMPT_COMMAND = { dan-create-left-prompt }
let-env PROMPT_COMMAND_RIGHT = { dan-create-right-prompt }
let-env PROMPT_INDICATOR = { $"(ansi green_bold)〉" }
