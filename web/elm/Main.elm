module Main exposing (..)

import Html.App as App
import Components.Section as Section


main : Program Never
main =
  App.program
    { init = (Section.init, Cmd.none)
    , view = Section.view
    , subscriptions = always Sub.none
    , update = Section.update
    }
