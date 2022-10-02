let-env config = ($env.config | merge {
  {
    color_config: $light_theme
    table_index_mode: never
    cd_with_abbreviations: true
    show_banner: false
    quick_completions: true
    keybindings: [
      {
        name: reload_config
        modifier: control
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
    ]
  }
})

use stdlib.nu *
use lib.nu *
use ~/src/pm/pm.nu *
use git.nu *
use git-stash.nu *
source prompt.nu
source init-local.nu
source alias.nu
