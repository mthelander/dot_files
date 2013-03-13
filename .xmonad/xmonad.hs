import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
xmproc <- spawnPipe "/usr/bin/xmobar /home/mjthelander/.xmobarrc"
xmonad $ defaultConfig
    { modMask = mod4Mask -- Use Super instead of Alt
    , terminal = "terminator"
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    } `additionalKeys`
    [ 
    ]
