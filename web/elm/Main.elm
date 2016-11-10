module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (href, class, style)
import Components.Board as Board exposing (..)
-- import Components.Card as Card

main : Program Never
main =
  App.program
    { init = ( Board.board, Cmd.none )
    , view = Board.view
    , subscriptions = always Sub.none
    , update = Board.update
    }
