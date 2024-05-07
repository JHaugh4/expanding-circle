module Main where

import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Interact

data Model = Model 
    { pos :: (Float, Float)
    , rad :: Float
    , name :: String
    }

initialModel :: Model
initialModel = Model (0, 0) 10 ""

drawModel :: Model -> Picture
drawModel model = 
    let (x, y) = pos model
    in translate x y (circle (rad model))

evolveModel :: Model -> Model
evolveModel model = model { rad = (rad model) + 1 }

handleEvent :: Event -> Model -> Model
handleEvent (EventKey (MouseButton LeftButton) ks mods position) model =
    model { pos = position, rad = rad initialModel }
handleEvent event model = model

step fn model = evolveModel model

main = do
    let window = InWindow "Playground" 
                 (600, 600) (0, 0) 
    let bgcolor = white
    let fps = 10
    play window bgcolor fps initialModel drawModel handleEvent step
