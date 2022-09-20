let-env config = ($env.config | merge {
  {
    color_config: $light_theme
    disable_table_indexes: true
    cd_with_abbreviations: true
    show_banner: false
    keybindings: [
      {
        name: pm_switch
        modifier: control
        keycode: char_p
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

source env-dan.nu
use lib.nu *
use ~/src/pm/pm.nu *
use git.nu *
use git-stash.nu *
source prompt.nu
source init-local.nu
source alias.nu
