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
-- import System.Taffybar.WorkspaceHUD
import System.Taffybar.DiskIOMonitor

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]


main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 1, 1, 1)]
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
  let clock = textClockNew Nothing "<span fgcolor=\"#c43ff0\">%Y-%m-%d %H:%M</span>" 1
      -- pager = taffyPagerHUDNew defaultPagerConfig defaultWorkspaceHUDConfig
      note = notifyAreaNew defaultNotificationConfig
      wea = weatherNew (defaultWeatherConfig "KMSN") 10
      mpris = mprisNew defaultMPRISConfig
      cpu = pollingGraphNew cpuCfg 0.5 cpuCallback
      mem = pollingGraphNew memCfg 1 memCallback
      battery = textBatteryNew "$time$" 10
      tray = systrayNew
  -- defaultTaffybar defaultTaffybarConfig { startWidgets = [ pager, note ]
  defaultTaffybar defaultTaffybarConfig { startWidgets = [ note ]
                                        , endWidgets = [ clock, tray, mem, cpu, battery, mpris ]
                                        }

