import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.EwmhDesktops

noTileHook = composeAll
    [ className =? "Empathy" --> doFloat
    ]

main = do
  xmonad $ defaultConfig
      { modMask         = mod4Mask -- Use Super instead of Alt
      , terminal        = "terminator"
      , manageHook      = manageDocks <+> noTileHook <+> manageHook defaultConfig
      , logHook         = ewmhDesktopsLogHook
      , handleEventHook = ewmhDesktopsEventHook
      , startupHook     = ewmhDesktopsStartup
      , layoutHook      = avoidStruts $ layoutHook defaultConfig
      } `additionalKeys`
      [ ((0,        xF86XK_AudioLowerVolume), spawn "amixer set Master 2-")
      , ((0,        xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")
      , ((mod4Mask, xK_p                   ), spawn "$HOME/.scripts/dmenu-solarized")
      , ((mod4Mask .|. shiftMask, xK_q     ), spawn "xfce4-session-logout")
      ]
