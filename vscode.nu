export def vscode-open-in-workspace[path: string] {
  let path = ($path | path expand)
  let workspace_dir = containing_repo($path)
  if (not (workspace_dir in (current_workspace_dirs))) {
    # Open a VSCode workspace before opening the file
    ^code $workspace_dir
    sleep 5sec
  }
  ^code $path
}

def current_workspace_dirs [] {
    # ls `~/Library/Application Support/Code/User/workspaceStorage/*/workspace.json`
    # cat `~/Library/Application Support/Code/User/workspaceStorage/eeded081e840f28fecc1cd8c5b82e4f2/workspace.json`

}

def age_of_oldest_process [pattern: string] {
    let pids = (ps -l | where name =~ $pattern | get pid)
    let times = (
        ^ps -p $pids
        | lines
        | skip 1
        | split column --collapse-empty " " pid _ time
        | get time
        | each { |it|
            let time = ($it | str replace -as '.'  ':' | split column ':' hr min sec | get 0)
            ($time.hr | into int) * 1hr + ($time.min | into int) * 1min + ($time.sec | into int) * 1sec
        }
    )
    $times | math max
}
