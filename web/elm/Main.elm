module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (href, class, style)
import Board as Board exposing (..)


main : Program Never
main =
  App.program
    { init = ( Board.model, Cmd.none )
    , view = Board.view
    , subscriptions = always Sub.none
    , update = Board.update
    }
