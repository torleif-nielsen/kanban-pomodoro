module Components.Task exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)

-- MODEL
type alias Model =
  { id          : Int
  , description : String
  , editing    : Bool
  }

-- INIT
init : Int -> Model
init taskId =
  { id          = taskId
  , description = "I'm an editable task!"
  , editing    = False
  }
