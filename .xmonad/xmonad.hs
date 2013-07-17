import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Graphics.X11.ExtraTypes.XF86

noTileHook = composeAll
    [ className =? "Empathy" --> doFloat
    ]

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/mthelander/.xmobarrc"
  xmonad $ defaultConfig
      { modMask = mod4Mask -- Use Super instead of Alt
      , terminal = "terminator"
      , manageHook = manageDocks <+> noTileHook <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      } `additionalKeys`
      [ ((0,        xF86XK_AudioLowerVolume), spawn "amixer set Master 2-")
      , ((0,        xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")
      , ((mod4Mask, xK_p                   ), spawn "$HOME/.scripts/dmenu-solarized")
      ]
