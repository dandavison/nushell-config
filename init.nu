let-env keybindings = $env.config.keybindings ++ [
  {
    name: reload_config
    modifier: alt
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand,
      cmd: $"source '($nu.env-path)'; source '($nu.config-path)'"
    }
  }
  {
    name: pm_switch
    modifier: control
    keycode: space
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand,
        cmd: "pm switch"
      }
    ]
  }
  {
    name: M-x
    modifier: alt
    keycode: char_x
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand,
        cmd: "M-x"
      }
    ]
  }
  {
    name: browse
    modifier: alt
    keycode: char_.
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand,
        cmd: "browse"
      }
    ]
  }
]

let-env table = ($env.config.table | merge {
  index_mode: "never"
})

let-env config = ($env.config | merge {
  color_config: $light_theme
  show_banner: false
  keybindings: $env.keybindings
  table: $env.table
})

ulimit -Sn 65535

use stdlib.nu *
use lib.nu *
use M-x.nu *
use ~/src/pm/pm.nu *
use git.nu *
use git-stash.nu *
source prompt.nu
source init-local.nu
source alias.nu
