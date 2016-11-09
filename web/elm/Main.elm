module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (href, class, style)
import Board as Board exposing (..)
import Components.Card as Card

main : Program Never
main =
  App.program
    { init = ( Card.model, Cmd.none )
    , view = Card.view
    , subscriptions = always Sub.none
    , update = Card.update
    }
