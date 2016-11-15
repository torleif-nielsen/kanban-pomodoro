module Main exposing (..)

import Html.App as App
import Components.Board as Board


main : Program Never
main =
  App.program
    { init = (Board.init, Cmd.none)
    , view = Board.view
    , subscriptions = always Sub.none
    , update = Board.update
    }
