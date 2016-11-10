module Components.TaskCard exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Html.Events exposing (onClick)
import Html.App as App
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Dialog as Dialog
import Material.Elevation as Elevation
import Material.Icon as Icon
import Material.Options as Options exposing (..)
import Material.Textfield as Textfield


type alias Model =
  { description : String
  ,         mdl : Material.Model
  }

model : Model
model =
  { description = "Click the pencil icon to edit me!"
  ,         mdl = Material.model
  }

type Msg = Mdl (Material.Msg Msg)
  | Edit String

-- VIEW

view : Model -> Html Msg
view model =
  Card.view
    [ Elevation.e2
    , css "margin-bottom" "10px"
    ]
    [ Card.title
      []
      [ Card.head
        []
        [ text "Task" ]
      ]
    , Card.text
      []
      [ text model.description
      , Dialog.view
        []
        [ Dialog.title [] [ text "Editing Card Description" ]
        , Dialog.content []
          [ Textfield.render Mdl [4] model.mdl
            [ Textfield.textarea
            , Textfield.rows 10
            , Textfield.value model.description
            , Textfield.onInput Edit
            ]
          ]
        , Dialog.actions []
          [ Button.render Mdl [3] model.mdl
            [ Button.primary
            , Button.raised
            , Dialog.closeOn "click"
            ]
            [ text "Save" ]
          ]
        ]
      ]
    , Card.actions
      [ Card.border ]
      [ Button.render Mdl [1,0] model.mdl
        [ Button.ripple
        , Button.colored
        , Dialog.openOn "click"
        ]
        [ Icon.i "edit" ]
      , Button.render Mdl [1,1] model.mdl
        [ Button.ripple, Button.accent ]
        [ Icon.i "delete" ]
      ]
    ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Mdl msg' ->
      Material.update msg' model

    Edit newDescription ->
      ({ model | description = newDescription }, Cmd.none)

main : Program Never
main =
  App.program
    { init = ( model, Cmd.none )
    , view = view
    , subscriptions = always Sub.none
    , update = update
    }
