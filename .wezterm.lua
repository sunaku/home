local wezterm = require 'wezterm';

local default_prog;
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  default_prog = { -- this is for Linux running inside WSL2
    os.getenv("USERPROFILE") ..
    "\\AppData\\Local\\Microsoft\\WindowsApps\\ubuntu2204.exe"
  };
end
default_prog = { "ssh", "skurapati@yield-sandbox-73.nvidia.com" };

-- start maximized (this is combined with `window_decorations` below)
-- https://github.com/wez/wezterm/issues/284#issuecomment-1177628870
local mux = wezterm.mux
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)

return {

  -- default_prog = default_prog,

  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  window_padding = {
    top    = "7px",
    left   = "0px",
    right  = "0px",
    bottom = "0px",
  },

  font_size = 10,
  font = wezterm.font_with_fallback {
    {
      -- TODO: it's picking BDF instead of TTF, hence it won't resize itself
      family = 'TamzenForPowerline', weight = 'Medium',
      -- this font lacks ligatures so disable them for it
      harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    },
    --{ family = 'JetBrains Mono', weight = 'Medium' },
    --{ family = 'Terminus', weight = 'Bold' },
    --'Noto Color Emoji',
  },

  colors = {
    -- Colors from everforest theme for Vim:
    -- https://github.com/sainnhe/everforest
    -- https://github.com/sunaku/home/blob/master/.Xdefaults.d/colors/everforest.xrdb
    foreground = "#d3c6aa", -- background=dark palette2=fg
    background = "#323d43", -- softness=soft background=dark palette1=bg0
    cursor_border = "#f57d26", -- background=light palette2=orange
    cursor_bg = "#f57d26", -- background=light palette2=orange
    cursor_fg = "#2f383e", -- bright black (taken from below)
    selection_bg = "#573e4c", -- Visual
    selection_fg = "#edead5", -- bright white (taken from below)
    ansi = {
      "#404c51", -- softness=medium background=dark palette1=bg2
      "#e67e80", -- background=dark palette2=red
      "#a7c080", -- background=dark palette2=green
      "#dbbc7f", -- background=dark palette2=yellow
      "#7fbbb3", -- background=dark palette2=blue
      "#d699b6", -- background=dark palette2=purple
      "#83c092", -- background=dark palette2=aqua
      "#dfdbc8", -- softness=medium background=light palette1=bg4
    },
    brights = {
      "#525c62", -- softness=medium background=dark palette1=bg4
      "#f85552", -- background=light palette2=red
      "#8da101", -- background=light palette2=green
      "#dfa000", -- background=light palette2=yellow
      "#3a94c5", -- background=light palette2=blue
      "#df69ba", -- background=light palette2=purple
      "#35a77c", -- background=light palette2=aqua
      "#edead5", -- softness=medium background=light palette1=bg2
    },
  },

  disable_default_key_bindings = true,
  keys = {
    {mods="CTRL|SHIFT", key="F", action=wezterm.action{Search={CaseSensitiveString=""}}},
    {mods="CTRL|SHIFT", key="C", action=wezterm.action{CopyTo="Clipboard"}},
    {mods="CTRL|SHIFT", key="V", action=wezterm.action{PasteFrom="Clipboard"}},
    {mods="SHIFT", key="Insert", action=wezterm.action{PasteFrom="PrimarySelection"}},
    {mods="CTRL", key="-", action="DecreaseFontSize"},
    {mods="CTRL", key="=", action="IncreaseFontSize"},
    {mods="CTRL", key="0", action="ResetFontSize"},
    {key="F11", action="ToggleFullScreen"},
  },

}
