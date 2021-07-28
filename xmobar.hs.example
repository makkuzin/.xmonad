Config
  { font = "xft:Liberation Mono:size=11:bold:antialias=true"
  , bgColor = "black"
  , fgColor = "#dcdcdc"
  , position = Static { xpos = 0, ypos = 0, width = 1920, height = 16 }
  , commands = [ Run Kbd [ ("us", "<fc=#ffffff>EN</fc>")
		         , ("ru", "<fc=#ffffff>RU</fc>")
			 ]
	       , Run Wireless "wlan0" [ "--template", "WiFi: <essid> <quality>%" ] 10
	       , Run DynNetwork [ "--template", "Net: <dev>" ] 10
	       , Run BatteryP ["BAT1"] [ "--template", "Batt: <left>%"
	                               , "--Low", "30"
				       , "--High", "50"
				       , "--low", "red"
				       , "--normal", "darkorange"
				       , "--high", "darkgreen"
				       ] 50
               , Run Date "<fc=#ee9a00>%H:%M %d/%m</fc>" "date" 10
	       , Run Volume "default" "Master" [ "--template", "Vol: <volumebar>" ] 10
	       , Run PipeReader "/tmp/.worktimer-pipe" "worktimer"
               , Run StdinReader
               ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = " %StdinReader%}{ WT: %worktimer% : %dynnetwork% : %wlan0wi% : %default:Master% : %battery% : %kbd% : %date% "
  }
