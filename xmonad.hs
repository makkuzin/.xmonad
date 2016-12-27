import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run
import System.IO
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86

myTerminal = "urxvtc"
myBorderWidth = 2
myBorderColor = "#4d4d4d"
--myBorderColor = "#8f8f8f"
myActiveBorderColor = "#dfaf8f"
myWorkspaces = ["1:main","2:debug","3:browser","4:communication","5:calibre","6:extra"]
myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = spacing 4 $ Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 10/100
    noBordersLayout = smartBorders $ Full
myManageHook = composeAll
  [ className =? "Firefox" --> doShift "3:browser"
  , className =? "Thunderbird" --> doShift "4:communication"
  , className =? "calibre" --> doShift "5:calibre"
--, className =? "VirtualBox" --> doFloat
--, className =? "Skype" --> doFloat
--, className =? "Upwork" --> doFloat
  ]

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar /home/gentoo/.xmonad/xmobar.hs"
  xmonad $ def
    { layoutHook = avoidStruts $ myLayout
    , manageHook = manageDocks <+> myManageHook <+> manageHook def
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "#806dbd" "" . shorten 50
      , ppLayout = const ""
      }
    , workspaces = myWorkspaces
    , terminal = myTerminal
    , borderWidth = myBorderWidth
    , normalBorderColor = myBorderColor
    , focusedBorderColor = myActiveBorderColor
    } `additionalKeys`
    [ ((mod1Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "scrot -u")
    , ((0, xK_Print), spawn "scrot")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -10")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +10")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 10%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 10%+")
    , ((0, xF86XK_PowerOff), spawn "xscreensaver-command -lock && echo 'mem' > /sys/power/state")
    , ((mod1Mask .|. shiftMask, xK_q), return())
    , ((mod1Mask, xK_q), return())
    , ((mod1Mask, xK_F1), sendMessage ToggleStruts)
    , ((mod1Mask, xK_F2), spawn "dmenu_run")
    , ((mod1Mask, xK_F4), kill)
    ]
