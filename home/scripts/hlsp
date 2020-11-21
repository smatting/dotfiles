#! /usr/bin/env nix-shell
#! nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [process directory])" -i runhaskell

import System.Directory (doesPathExist, makeAbsolute)
import System.Process (callProcess, callCommand)
import System.Environment (getArgs)

main = do
  let filename = ".hlsp"
  path <- makeAbsolute filename
  exists <- doesPathExist path
  let wrapper = if exists then path else  "/home/stefan/.bin/haskell-language-server-wrapper"
  args <- getArgs
  callProcess wrapper args
