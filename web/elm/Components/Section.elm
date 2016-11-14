module Components.Section exposing (..)

import Dict exposing (..)
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Components.Task as Task


-- MODEL
type alias Model =
  { title : String
  , tasks : List Task.Model
  }

-- INIT
init : Int -> Model
init taskId =
  { title = "Task List"
  , tasks =
      [ Task.init 0
      , Task.init 1
      , Task.init 2
      ]
  }

-- MSG
type Msg
  = NoOp

-- UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
      NoOp ->
        model

view : Model -> Html Msg
view model =
  div
    []
    [ p
        []
        [ text model.title ]

    ]
