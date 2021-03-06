import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W
import XMonad.Actions.PhysicalScreens
import XMonad.Layout.ResizeScreen

noTileHook = composeAll
    [ className =? "Xfce4-notifyd" --> doIgnore
    ]

main = do
  xmonad $ xfceConfig
      { modMask         = mod4Mask -- Use Super instead of Alt
      , terminal        = "terminator"
      , manageHook      = manageDocks <+> noTileHook <+> manageHook xfceConfig
      , logHook         = ewmhDesktopsLogHook
      , handleEventHook = ewmhDesktopsEventHook
      , startupHook     = ewmhDesktopsStartup
      , focusedBorderColor = "#268bd2"
      , layoutHook      = avoidStruts $ layoutHook xfceConfig
      } `additionalKeys`
      [ ((0,        xF86XK_AudioLowerVolume), spawn "amixer set Master 2-")
      , ((0,        xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")
      , ((mod4Mask, xK_m                   ), spawn "dmenu_run -b -nb 'black' -nf '#17c200' -sb '#079dad'")
      , ((mod4Mask .|. shiftMask, xK_q     ), spawn "xfce4-session-logout")
      , ((mod4Mask, xK_o                   ), spawn "google-chrome")
      -- Don't need this hack anymore; instead, just add XKBOPTIONS="ctrl:nocaps" to /etc/default/keyboard!
      --, ((mod4Mask, xK_u                   ), spawn "setxkbmap -option ctrl:nocaps")
      , ((mod4Mask, xK_w), onPrevNeighbour W.view)
      , ((mod4Mask, xK_e), onNextNeighbour W.view)
      , ((mod4Mask .|. shiftMask, xK_w), onPrevNeighbour W.shift)
      , ((mod4Mask .|. shiftMask, xK_e), onNextNeighbour W.shift)
      ]
