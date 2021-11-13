-- You need to define the script version for compatibility check.
-- See https://github.com/sayanarijit/xplr/wiki/Upgrade-Guide.
--
version = "0.16.3"

local xplr = xplr

-- Config
---- General
------ Show hidden
xplr.config.general.show_hidden = true

------ Read only
xplr.config.general.read_only = false

------ Recover mode
xplr.config.general.enable_recover_mode = false

------ Start FIFO
xplr.config.general.start_fifo = nil

------ Prompt
xplr.config.general.prompt.format = "❯ "
xplr.config.general.prompt.style.add_modifiers = nil
xplr.config.general.prompt.style.sub_modifiers = nil
xplr.config.general.prompt.style.bg = nil
xplr.config.general.prompt.style.fg = nil

------ Initial layout
xplr.config.general.initial_layout = "default"

------ Initial mode
xplr.config.general.initial_mode = "default"

------ Initial sorting
xplr.config.general.initial_sorting = {
  { sorter = "ByCanonicalIsDir", reverse = true },
  { sorter = "ByIRelativePath", reverse = false },
}

xplr.config.modes.builtin.default.key_bindings.on_key["D"] = {
  help = "dotfiles mode",
  messages = {
    { SwitchModeCustom = "dotfiles" },
  },
}


xplr.config.modes.custom.dotfiles = {
  name = "dotfiles",
  key_bindings = {
    on_key = {
      ["."] = {
        help = "show hidden",
        messages = {
          {
            ToggleNodeFilter = {
              filter = "RelativePathDoesNotStartWith",
              input = ".",
            },
          },
          "ExplorePwdAsync",
        },
      },
      ["?"] = {
        help = "global help menu",
        messages = {
          {
            BashExec = [===[
            [ -z "$PAGER" ] && PAGER="less -+F"
            cat -- "${XPLR_PIPE_GLOBAL_HELP_MENU_OUT}" | ${PAGER:?}
            ]===],
          },
        },
      },
      ["d"] = {
        help = "add current",
        messages = {
		{ 
			BashExec = "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $XPLR_FOCUS_PATH"
		},
	},
      },
     ["ctrl-a"] = {
        help = "select/unselect all",
        messages = { "ToggleSelectAll" },
      },
      ["ctrl-u"] = {
        help = "clear selection",
        messages = { "ClearSelection" },
      },
      ["ctrl-c"] = {
        help = "terminate",
        messages = { "Terminate" },
      },
      ["ctrl-f"] = {
        help = "search",
        messages = {
          "PopMode",
          { SwitchModeBuiltin = "search" },
          { SetInputBuffer = "" },
          "ExplorePwdAsync",
        },
      },
      ["ctrl-r"] = {
        help = "refresh screen",
        messages = { "ClearScreen" },
      },
      ["q"] = {
        help = "Exit Mode",
        messages = { "PopMode" },
      },
      space = {
        help = "toggle selection",
        messages = { "ToggleSelection", "FocusNext" },
      },
      ["~"] = {
        help = "go home",
        messages = {
          {
            BashExecSilently = [===[
            echo ChangeDirectory: "'"${HOME:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
      up = {
        help = "up",
        messages = { "FocusPrevious" },
      },
      right = {
        help = "Folder down",
        messages = { "Enter" },
      },
      left = {
        help = "Folder up",
        messages = { "Back" },
      },
      down = {
        help = "down",
        messages = { "FocusNext" },
      },
    },
  },
}

xplr.config.modes.custom.dotfiles.key_bindings.on_key["h"] =
xplr.config.modes.custom.dotfiles.key_bindings.on_key.left

xplr.config.modes.custom.dotfiles.key_bindings.on_key["j"] =
xplr.config.modes.custom.dotfiles.key_bindings.on_key.down

xplr.config.modes.custom.dotfiles.key_bindings.on_key["k"] =
xplr.config.modes.custom.dotfiles.key_bindings.on_key.up

xplr.config.modes.custom.dotfiles.key_bindings.on_key["l"] =
xplr.config.modes.custom.dotfiles.key_bindings.on_key.right

package.path = os.getenv("HOME") .. '/.config/xplr/plugins/?/src/init.lua'

require("nvim-ctrl").setup{
  mode = "dotfiles",
}

