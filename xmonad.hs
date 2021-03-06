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
--myActiveBorderColor = "#806dbd"
myActiveBorderColor = "orange"
myWorkspaces = [ "1:code"
               , "2:service"
               , "3:ssh"
               , "4:browser"
               , "5:chat"
               , "6:email"
               , "7:read"
               , "8", "9", "0"]
myLayout = tiled ||| Mirror tiled ||| Full
  where
    tiled = spacing 2 $ Tall nmaster delta ratio
    nmaster = 1
    ratio = 1/2
    delta = 5/100
    noBordersLayout = smartBorders $ Full
myManageHook = composeAll
-- xprop to determine the app's name
  [ className =? "Firefox" --> doShift "4:browser"
  , className =? "Google-chrome" --> doShift "4:browser"
  , className =? "Midori" --> doShift "4:browser"
  , className =? "Opera" --> doShift "4:browser"
  , className =? "QupZilla" --> doShift "4:browser"
  , className =? "Vivaldi-stable" --> doShift "4:browser"
  , className =? "Skype" --> doShift "5:chat"
  , className =? "Upwork" --> doShift "5:chat"
  , className =? "Thunderbird" --> doShift "6:email"
  , className =? "calibre" --> doShift "7:read"
  , className =? "VirtualBox" --> doShift "8"
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
    -- mod1Mask - altKey, mod4Mask - winKey
    -- http://hackage.haskell.org/package/X11-1.8/docs/Graphics-X11-Types.html
    [ ((mod1Mask .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
    , ((controlMask, xK_Print), spawn "scrot -u")
    , ((0, xK_Print), spawn "scrot")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -10")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +10")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 10%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 10%+")
    , ((0, xF86XK_PowerOff), spawn "xscreensaver-command -lock && acpitool -s")
    , ((mod1Mask .|. shiftMask, xK_q), return())
    , ((mod1Mask, xK_q), return())
    , ((mod1Mask, xK_F1), sendMessage ToggleStruts)
    , ((mod1Mask, xK_F2), spawn "dmenu_run")
    , ((mod1Mask, xK_F4), kill)
    -- mouse
    -- quick
    , ((mod4Mask, xK_j), spawn "xdotool mousemove_relative 0 40") -- down
    , ((mod4Mask, xK_k), spawn "xdotool mousemove_relative 0 -40") -- up
    , ((mod4Mask, xK_h), spawn "xdotool mousemove_relative -- -40 0") -- left
    , ((mod4Mask, xK_l), spawn "xdotool mousemove_relative 40 0") -- right
    -- slow
    , ((mod4Mask .|. shiftMask, xK_j), spawn "xdotool mousemove_relative 0 10") -- down
    , ((mod4Mask .|. shiftMask, xK_k), spawn "xdotool mousemove_relative 0 -10") -- up
    , ((mod4Mask .|. shiftMask, xK_h), spawn "xdotool mousemove_relative -- -10 0") -- left
    , ((mod4Mask .|. shiftMask, xK_l), spawn "xdotool mousemove_relative 10 0") -- right
    -- clicks
    , ((mod4Mask, xK_Return), spawn "xdotool click 1") -- left click
    , ((mod4Mask, xK_backslash), spawn "xdotool click 3") -- right click
    -- scroll
    , ((mod4Mask, xK_bracketleft), spawn "xdotool click 5") -- down
    , ((mod4Mask, xK_bracketright), spawn "xdotool click 4") -- up
    ]
