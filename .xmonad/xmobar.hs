----------------------------------------------
-- __   __                _                 --
-- \ \ / /               | |                --
--  \ V / _ __ ___   ___ | |__   __ _ _ __  --
--   > < | '_ ` _ \ / _ \| '_ \ / _` | '__| --
--  / . \| | | | | | (_) | |_) | (_| | |    --
-- /_/ \_\_| |_| |_|\___/|_.__/ \__,_|_|    --
----------------------------------------------

import Xmobar
import Text.Printf
import Colors
import Graphics.X11.Xrandr


--------------------------------------------------------------------------------
-- UTILS STUFF
--------------------------------------------------------------------------------
-- Wrap the given string with the given font number tag


withFont :: String -> Int -> String
withFont logo fontNum =
  "<fn=" ++ show fontNum ++ ">" ++ logo ++ "</fn>"

  -- Wrap with an action the given string
wrapWithAction :: String -> String -> String
wrapWithAction toWrap action = printf "<action=%s>%s</action>" action toWrap

arrowRight      = "\xe0b0" `withFont` 1
arrowLeft       = "\xE0B2" `withFont` 1
emptyArrowRight = "\xE0B1" `withFont` 1
emptyArrowLeft  = "\xE0B3" `withFont` 1

data ArrowType = LeftArrow
  | RightArrow
  | EmptyLeftArrow
  | EmptyRightArrow
  | NoArrow
  deriving Eq

-- Create the Circle based on passed stuff
doArrow :: ArrowType -> String -> String -> String -> String -> String
doArrow arrowType content bg fg afterColor =
  case arrowType of
    LeftArrow       -> arrowTemplate bg afterColor arrowLeft ++ template
    RightArrow      -> template ++ arrowTemplate bg afterColor arrowRight
    EmptyLeftArrow  -> arrowTemplate afterColor bg emptyArrowLeft ++ template
    EmptyRightArrow -> template ++ arrowTemplate afterColor bg emptyArrowRight
    NoArrow         -> template
  where
    template = printf "<fc=%s,%s:0>%s</fc>" fg bg content
    arrowTemplate = printf "<fc=%s,%s>%s</fc>"

-- circleRight     = "\xe0b4" `withFont` 2
-- circleLeft      = "\xe0b6" `withFont` 2
--
-- -- Create the circle based on passed stuff
-- doCircle ::  String -> String -> String -> String
-- doCircle content bg fg =
--   circleTemplate bg circleLeft ++ template ++ circleTemplate bg circleRight
--   where
--     template = printf "<fc=%s,%s:6>%s</fc>" fg bg content -- <fc=%s,%s:6>%s</fc>
--     circleTemplate = printf "<fc=%s>%s</fc>"

--------------------------------------------------------------------------------
-- CONFIGURATION STUFF
--------------------------------------------------------------------------------
myScreenWidth     = 2560

myBarHeight       = 30
myFontHeight      = div myBarHeight 3
myIconsHeight     = div (myFontHeight*3) 2 -- equals * 1.5

myFont            = "xft:JetBrains Mono:size="++show(myFontHeight)++":antialias=true:style=Bold"
myAdditionalFonts = ["xft:mononoki Nerd Font:pixelsize="++show(myBarHeight)++":antialias=true:hinting=true" -- just Arrow
                    ,"xft:mononoki Nerd Font:pixelsize="++show((div myBarHeight 2) )++":antialias=true:hinting=true" -- just Circle
                    -- , "xft:JetBrains Mono:pixelsize="++show(myIconsHeight)++":antialias=true:style=Bold" -- Icons and xmonad pipe stuff
                    , "xft:mononoki Nerd Font:size="++show(myIconsHeight)++":antialias=true:style=Regular"
                    ]
                    -- 1/6 - 1/48 = 6
xftAlign          = [myBarHeight - (div myBarHeight 6),-1, -1]    -- some xft fonts are not correctly aligned
textAlign         = -1  -- 3 = size of font *2 to get centered at top + middle pos

myBgColor         = background   -- background color
myFgColor         = foreground   -- text color
myPosition        = Static { xpos = 12, ypos = div myBarHeight 3, width = myScreenWidth - 24, height = myBarHeight }         -- where the bar should be at
myBorder          = NoBorder    -- define where the border should be at (if any)
myBorderColor     = "#646464"   -- color of the border (ignored if myBorder is "NoBorder")

mySepChar         =  "%"        -- delineator between plugin names and straight text\
myAlignSep        = "}{"        -- separator between left-right alignment

configDir         = "~/.xmonad/"  -- where this file and xmonad.hs are
-- scriptsDir        = configDir ++ "scripts/" -- where my xmobar scripts are in

--------------------------------------------------------------------------------
-- SYMBOLS-LOGOS
--------------------------------------------------------------------------------

-- Font 1
archLogo        = "\xF303 " `withFont` 3
intellijLogo        = "\xe7b5 " `withFont` 3
cpuLogo         = "\xF85A " `withFont` 3
ramLogo         = "\xE266 " `withFont` 3
networkUpLogo   = "\xf01b " `withFont` 3
networkDownLogo = "\xf01a " `withFont` 3
calendarLogo    = "\xF133 " `withFont` 3

--------------------------------------------------------------------------------
-- POWERLINE-LIKE TEMPLATE
--------------------------------------------------------------------------------


-- Powerline-like Template
powerlineTemplate :: String
powerlineTemplate =
  doArrow RightArrow ("   " ++ archLogo ++ "  ") color1 foreground color2 `wrapWithAction` "alacritty"
  ++ doArrow RightArrow ("   " ++ intellijLogo ++ "  ") color2 foreground myBgColor `wrapWithAction` "./dev/jetbrains-toolbox/jetbrains-toolbox"
  ++ "    %UnsafeStdinReader%"
  ++ "}"
  ++ "%date%" `wrapWithAction` "morgen"
  ++"{"
  -- ++ "%mymic%"
  -- ++ doArrow NoArrow
  --       " %myvpn%"
  --       "#a0a0a0" "#222222" ""
  -- ++ doArrow EmptyLeftArrow
  --       "%mynet%%mybt% "
  --       "#a0a0a0" "#222222" "#777777"
  -- ++ doArrow LeftArrow
  --       "  %cpu%  "
  --       color3 foreground myBgColor `wrapWithAction` "alacritty -e htop"

  ++ doArrow LeftArrow "  %cpu%  " color3 foreground background `wrapWithAction` "alacritty -e htop"

  ++ doArrow LeftArrow
        "  %memory%  "
        color2 foreground color3 `wrapWithAction` "alacritty -e htop"
  ++ doArrow LeftArrow
        "  %enp1s0%  "
        color1 foreground color2 `wrapWithAction` "alacritty -e sudo iftop"

--------------------------------------------------------------------------------
-- CONFIGS
--------------------------------------------------------------------------------

config :: Config
config = defaultConfig {

   -- Appearance
     font             = myFont
   , additionalFonts  = myAdditionalFonts
   , textOffsets      = xftAlign -- align xft fonts correctly
   , textOffset      = textAlign -- align fonts correctly
   , bgColor          = myBgColor
   , fgColor          = myFgColor
   , position         = myPosition
   , border           = myBorder
   , borderColor      = myBorderColor

   -- Layout
   , sepChar          = mySepChar
   , alignSep         = myAlignSep
   , template         = powerlineTemplate

   -- General behavior
   , lowerOnStart     = False   -- do NOT send to bottom of window stack on start
   , hideOnStart      = False   -- do NOT start with window unmapped (hidden)
   , allDesktops      = True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest     = False   -- choose widest display (multi-monitor)
   , persistent       = True    -- enable/disable hiding (True = disabled)

   -- Plugins
   , commands =
        [
        -- This line tells xmobar to read input from stdin. That's how we
        -- get the information that xmonad is sending it for display.

        Run UnsafeStdinReader

        -- Cpu monitor
        , Run $ Cpu          [ "--template" , cpuLogo ++ "CPU: <total>%"] 20

        -- Memory usage monitor
        , Run $ Memory       [ "--template" , ramLogo ++ "RAM: <usedratio>%" ] 30

        -- Network Usage monitor
        , Run $ Network "enp1s0"  ["--template" , networkUpLogo ++ "UP: <tx> kb/s  " ++ networkDownLogo ++ "DOWN: <rx> kb/s" ] 20

        -- Run my scripts
        -- , Run $ MyMicrophone myBgColor 10
        -- , Run $ MyBluetooth 50
        -- , Run $ MyBattery 30
        -- , Run $ MyNetwork 30
        -- , Run $ VPN ["HomeVPN"] 100

        -- Time and date indicator
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run $ Date           "<fc=#dddddd>%F (%a) <fc=#ee9a00>%H:%M</fc></fc>" "date" 50
        ]
   }

--------------------------------------------------------------------------------
-- MAIN
--------------------------------------------------------------------------------

main :: IO ()
main = xmobar config
