{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Information.CPU
import System.Information.Memory
import System.Taffybar
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS
import System.Taffybar.SimpleClock
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Weather
import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Battery
import System.Taffybar.CommandRunner
import System.Taffybar.DiskIOMonitor
import System.Information.CPU2
import Data.IORef
import qualified Data.Text as T
import System.Taffybar.Pager

-- import System.Taffybar.WorkspaceSwitcher
import Workspaces

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

cpuBar cpuName ref = 
  let cfg = defaultBarConfig $ \d -> (0.7, 0.7, 0.7)
  in pollingBarNew cfg 0.5 $ do
    z <- readIORef ref
    [system, user] <- getCPULoad cpuName
    -- let z'  = z * 0.9
    --     z'' = z' `max` user
    let z'' = user + system
    writeIORef ref z''
    return z''

makeCpuBar cpuName = do
  ref <- newIORef 0
  return $ cpuBar cpuName ref


defaultFormatter :: Notification -> String
defaultFormatter note = msg
  where
    msg = case T.null (noteBody note) of
      True -> T.unpack $ noteSummary note
      False -> T.unpack $ mconcat [ noteSummary note, ": ", noteBody note ]

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(0.7, 0.7, 0.7, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (1, 1, 1, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
      ioCfg = defaultGraphConfig { graphDataColors = [ (1, 1, 1, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "io"
                                  }
      notifyCfg = NotificationConfig (30 * 60) 200 defaultFormatter

  let clock = textClockNew Nothing "<span fgcolor=\"#ffffff\">%A %Y-%m-%d %H:%M</span>" 1
      -- pager = taffyPagerHUDNew defaultPagerConfig defaultWorkspaceHUDConfig
      -- note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew (defaultWeatherConfig "KMSN") 10
      mpris = mprisNew defaultMPRISConfig
      myweather = commandRunnerNew 300.0 "openweather" [] "no weather Info" "#ffffff"
      utcTime = commandRunnerNew 60.0 "/bin/sh" ["-c","d=$(date --utc \"+%Y-%m-%d %H:%M:%S UTC\"); echo -n $d"] "no weather Info" "#ffffff"



      myip = commandRunnerNew 60.0 "/home/stefan/.bin/myip" [] "no ip info" "#ffffff"
      -- cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      mem = pollingGraphNew memCfg 1 memCallback
      -- battery = textBatteryNew "$time$" 10
      --battery = commandRunnerNew 10.0 "acpi" [] "?" "#ffffff"
      battery = commandRunnerNew 10.0 "sh" ["-c", "acpi | sed -e 's/Battery 0: //' | tr -d '\n'"] "?" "#ffffff"

      tray = systrayNew

  cpu0 <- makeCpuBar "cpu0"
  cpu1 <- makeCpuBar "cpu1"
  cpu2 <- makeCpuBar "cpu2"
  cpu3 <- makeCpuBar "cpu3"
  pager <- pagerNew defaultPagerConfig
  let newSwitcher =  wspaceSwitcherNew pager
  -- defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
  defaultTaffybar defaultTaffybarConfig { startWidgets = [newSwitcher, myweather, myip, utcTime]
                                        -- , endWidgets = reverse [ battery, tray, mem, cpu0, cpu1, cpu2, cpu3, clock ]
                                        , endWidgets = reverse [ battery, tray, mem, clock ]
                                        , monitorNumber = 1
                                        }

