#! /usr/bin/env nix-shell
#! nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [relude time process optparse-applicative])" -i runhaskell

-- Note: to develop just replace "runhaskell" with "ghci"
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE NoImplicitPrelude #-}

import Control.Concurrent (threadDelay)
import Data.Time.Clock
import Data.Time.Format
import Data.Time.Format.ISO8601
import Data.Time.LocalTime
import Options.Applicative
import Relude
import System.Directory (doesPathExist, makeAbsolute)
import System.Environment (getArgs)
import System.Process (system)
import Text.Printf

main = do
  description :: Text <- execParser (info (strArgument (metavar "DESCRIPTION")) mempty)
  putTextLn "Happy pomodoro!"

  let secondsPomodoro = 25 * 60
  tStart <- getCurrentTime
  tStartLocal <- zonedTimeToLocalTime <$> getZonedTime

  let go = do
        now <- getCurrentTime
        let secondsElapsed = nominalDiffTimeToSeconds $ now `diffUTCTime` tStart
            secondsRemaining = secondsPomodoro - secondsElapsed
        unless (secondsRemaining <= 0) $ do
          let minutesRemaining = ceiling (secondsRemaining / 60.0) :: Int
          putTextLn $ (show minutesRemaining) <> "m"
          threadDelay $ (5 * 1000000 :: Int)
          go
  go
  let s = toText (formatTime defaultTimeLocale "%Y-%m-%d %H:%M" tStartLocal) <> " " <> description <> "\n"
  appendFileText "/home/stefan/pomodoro.txt" s
  system "notify-desktop -u normal \"RRRING! Pomodoro complete\""
  system "paplay ~/.bin/pomodoro-finished.ogg > /dev/null 2>&1"
