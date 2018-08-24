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
-- import System.Taffybar.WorkspaceHUD
import System.Taffybar.DiskIOMonitor
import System.Information.CPU2
import Data.IORef
import qualified Data.Text as T

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
    let z'  = z * 0.9
        z'' = z' `max` user
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
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      mem = pollingGraphNew memCfg 1 memCallback
      -- battery = textBatteryNew "$time$" 10
      --battery = commandRunnerNew 10.0 "acpi" [] "?" "#ffffff"
      battery = commandRunnerNew 10.0 "sh" ["-c", "acpi | sed -e 's/Battery 0: //' | tr -d '\n'"] "?" "#ffffff"

      tray = systrayNew

  cpu0 <- makeCpuBar "cpu0"
  cpu1 <- makeCpuBar "cpu1"
  cpu2 <- makeCpuBar "cpu2"
  cpu3 <- makeCpuBar "cpu3"
  -- defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
  defaultTaffybar defaultTaffybarConfig { startWidgets = [myweather]
                                        , endWidgets = reverse [ battery, tray, mem, cpu0, cpu1, cpu2, cpu3, clock ]
                                        , monitorNumber = 1
                                        }
