module Components.Board exposing (..)

import Dict exposing (Dict)
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Components.Section as Section
import Components.Task as Task

-- MODEL
type alias Model =
  { title    : String
  , sections : List Section.Model
  }

-- INIT

init : Model
init =
  { title = "Grapefruit Board"
  , sections =
      [ Section.init 0
      , Section.init 3
      , Section.init 6
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
      -- StartEditing taskId ->
      --   let
      --     startEditing taskFromModel =
      --       if taskFromModel.id == taskId then
      --         { taskFromModel | editing = not taskFromModel.editing }
      --       else
      --         taskFromModel
      --   in
      --     (List.map (\a -> List.map startEditing a) model.sections)

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1
        []
        [ text model.title ]
    , div []
        (List.map viewSection model.sections)
    ]

viewSection : Section.Model -> Html Msg
viewSection section =
  div
    []
    [ p
        []
        [ text section.title ]
    , div
        []
        []
        List.map viewTask section.tasks)
    ]

viewTask : Task.Model -> Html Msg
viewTask task =
  div
    []
    [ p
        []
        [ input
            [ type' "text"
            , readonly (not task.editing)
            , value task.description
            ]
            []
        ]
    , button
        []
        [ text "Edit" ]
    ]
