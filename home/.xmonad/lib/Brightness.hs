module Brightness(adjustBrightness, Direction(..)) where

import System.Process
import Control.Monad
-- import System.Console.Haskeline
import Control.Monad.IO.Class
import XMonad.Util.Run


getBrightness :: IO Double
getBrightness = do
    result <- runProcessWithInput "light" ["-G"] ""
    return $ (read result) / 100.0

setBrightness :: Double -> IO ()
setBrightness b = do
    runProcessWithInput "light" ["-S", show (b * 100.0)] ""
    return ()

data Function = Function {
    f :: Double -> Double,
    inv :: Double -> Double
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
    where c1 = 1.0 / (g(1) - g(0))
          c0 = 1.0 - g(1) / (g(1) - g(0))

compose :: Function -> Function -> Function
compose g1 g2 = Function {
    f = (f g2) . (f g1),
    inv = (inv g1) . (inv g2)
}

normalize :: Function -> Function
normalize g = g `compose` n
    where n = normTrafo (f g)

data Direction = Up | Down

dirFn dir =
    case dir of
        Up -> (+)
        Down -> (-)

clamp x = min (max 0 x) 1

discrete a x = (fromIntegral n) * a
    where n = round $ x / a

adjustBrightness :: Direction -> IO ()
adjustBrightness dir = do
        -- putStrLn "huhu"
        bAbs <- getBrightness
        let b  = discrete 0.1 $ (inv smooth) bAbs
            b' = clamp $ (dirFn dir) b 0.1
            bAbs' = clamp (f smooth b')
        -- print b'
        -- print bAbs'
        setBrightness bAbs'
    where
        smooth = normalize (power 2.0)

-- loop :: InputT IO ()
-- loop = do
--     minput <- getInputChar "% "
--     case minput of
--         Nothing -> return ()
--         Just 'q' -> return ()
--         Just 'o' -> do
--              liftIO $ adjustBrightness Down
--              loop
--         Just 'p' -> do
--              liftIO $ adjustBrightness Up
--              loop
--         _ -> loop

-- main = runInputT defaultSettings loop