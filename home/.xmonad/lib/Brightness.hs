module Brightness(adjustBrightness, Direction(..)) where

import System.Process
import Control.Monad
import Control.Monad.IO.Class
import XMonad.Util.Run
import Control.Arrow

data Function = Function {
    f :: Double -> Double,
    inv :: Double -> Double
}

compose :: Function -> Function -> Function
compose g1 g2 = Function {
    f = f g2 . f g1,
    inv = inv g1 . inv g2
}

expDecay a = Function {
    f = \x -> exp ( - a * x ),
    inv = \y -> 1.0 / (- a) * log y
}

linear c0 c1 = Function {
    f = \x -> c0 + c1 * x,
    inv = \y -> (- c0) / c1 + 1.0 / c1 * y
}

power a = Function {
    f = \x -> exp (a * log x),
    inv = \y -> exp ( 1.0 / a * log y ) 
}

normTrafo :: (Double -> Double) -> Function
normTrafo g = linear c0 c1
    where c1 = 1.0 / (g 1  - g 0 )
          c0 = 1.0 - g 1 / (g 1  - g 0)

normalize :: Function -> Function
normalize g = g `compose` normTrafo (f g)

data Direction = Up | Down

clamp x = min (max 0 x) 1

getBrightness :: IO Double
getBrightness = do
  result <- runProcessWithInput "light" ["-G"] ""
  return $ read result / 100.0

setBrightness :: Double -> IO ()
setBrightness b = do
  runProcessWithInput "light" ["-S", show (b * 100.0)] ""
  return ()

addDirection :: Direction -> Double -> Double
addDirection Up x = x + 0.1
addDirection Down x = x - 0.1

adjustBrightnessWith :: Function -> Direction -> IO ()
adjustBrightnessWith fun dir =
  getBrightness >>= (
        inv fun
    >>> addDirection dir
    >>> f fun
    >>> clamp
    >>> setBrightness
  )

adjustBrightness :: Direction -> IO ()
adjustBrightness = adjustBrightnessWith (normalize (power 3))
