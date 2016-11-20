module Components.Task exposing (..)

import Html exposing (..)
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
  let
    edit =
      div
        [ class "level-item"
        , onClick StartEditing
        ]
        [ button
            [ class "button is-outlined is-success" ]
            [ i
                [ class "material-icons"]
                [ text "create" ]
            ]
        ]

    delete =
      div
        [ class "level-item"
        , onClick RemoveSelf
        ]
        [ button
            [ class "button is-outlined is-danger" ]
            [ i
                [ class "material-icons"]
                [ text "delete" ]
            ]
        ]

    editDescription =
      textarea
        [ class "textarea"
        , onInput Edit
        ]
        [ text model.description ]

    seeDescription =
      div
        [ class "box task-description" ]
        [ text model.description ]
  in
    article
      [ class "media" ]
      [ div
          [ class "media-content" ]
          [ div
              [ class "content" ]
              [ if model.editing == True then
                  editDescription
                else
                  seeDescription
              ]
          , nav
              [ class "level" ]
              [ div
                  [ class "level-left" ]
                  [ edit ]
              , div
                  [ class "level-right" ]
                  [ delete]
              ]
          ]
      ]
