module Main exposing (..)

import Components.Board as Board
import Html exposing (program)


main : Program Never Board.Model Board.Msg
main =
  Html.program
    { init = (Board.init, Cmd.none)
    , view = Board.view
    , subscriptions = always Sub.none
    , update = Board.update
    }
