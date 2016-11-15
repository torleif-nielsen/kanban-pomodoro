module Components.Task exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
  { description : String
  , editing     : Bool
  }

init : Model
init =
  { description = "I'm an editable task"
  , editing     = False
  }

-- UPDATE

type Dispatch
  = Remove

type Msg
  = StartEditing
  | Edit String
  | RemoveSelf

update : Msg -> Model -> ( Model, Maybe Dispatch )
update msg model =
  case msg of
    StartEditing ->
      ( { model | editing = not model.editing }, Nothing )

    Edit newDescription ->
      ( { model | description = newDescription }, Nothing )

    RemoveSelf ->
      ( model, Just Remove ) -- inform the parent that it should remove the counter

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div
        []
        [ textarea
            [ rows 4
            , onInput Edit
            , readonly (not model.editing)
            ]
            [ text model.description ]
        , span [] [ text model.description ]
      ]
    , br [][]
    , button
        [ onClick StartEditing ]
        ( if model.editing  == True then
            [ text "Stop Editing"  ]
          else
            [ text "Start Editing" ]
        )
    , button [ onClick RemoveSelf ] [ text "Delete Task" ]
    ]
