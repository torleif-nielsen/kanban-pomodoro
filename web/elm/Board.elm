module Board exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (href, class, style)
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Grid exposing (grid, cell, size, Device(..))
import Material.Layout as Layout
import Material.Options as Options exposing (..)
import Material.Scheme

-- MODEL

type alias Card =
  { description : String }

type alias CardList =
  List Card

type alias Board =
  List CardList

cardList =
  [ { description = "First Task"  }
  , { description = "Second Task" }
  , { description = "Third Task"  }
  ]

boardList =
  [ cardList
  , cardList
  , cardList
  ]

init =
  boardList

-- This is referred to as the "model container"
type alias Model =
  { count : Int
  , cardList : CardList
  , mdl : Material.Model
    -- Boilerplate: model store for any and all Mdl components you use.
  }


-- `Material.model` provides the initial model
model : Model
model =
  { count = 0
  , cardList = cardList
  , mdl =
    Material.model
    -- Boilerplate: Always use this initial Mdl model store.
  }



-- ACTION, UPDATE


-- You need to tag `Msg` that are coming from `Mdl` so you can dispatch them
-- appropriately.
type Msg
  = Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    -- When the `Mdl` messages come through, update appropriately.
    Mdl msg' ->
      Material.update msg' model



-- VIEW


type alias Mdl =
  Material.Model

view : Model -> Html Msg
view model =
  Layout.render Mdl
    model.mdl
    [ Layout.fixedHeader
    ]
    { header = [ h1 [ style [ ( "padding", "0 2rem" ) ] ] [ text "Grapefruit" ] ]
    , drawer = []
    , tabs = ( [], [] )
    , main = [ viewBody model ]
    }

cardItem card =
  li [ class "" ] [ text (toString card.description) ]

board board =
  cell
    [ size Desktop 4, size Tablet 6, size Phone 12]
    [
      Card.view
        [ Elevation.e2 ]
        [ Card.title
          []
          [ Card.head
            []
            [ text "Board" ]
          ]
        , Card.text []
            [ ul [ class "" ] (List.map cardItem board) ]
        , Card.actions
            [ Card.border ]
            [ Button.render Mdl [1,0] model.mdl
              [ Button.ripple, Button.colored ]
              [ text "Edit" ]
            , Button.render Mdl [1,1] model.mdl
              [ Button.ripple, Button.accent ]
              [ text "Delete" ]
            ]
        ]
    ]

viewBody : Model -> Html Msg
viewBody model =
  Options.div
    []
    [ (List.map board boardList) |> grid []  
    ]
    |> Material.Scheme.top

-- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- do here, but rather in your master .html file. See the documentation
-- for the `Material` module for details.

main : Program Never
main =
  App.program
    { init = ( model, Cmd.none )
    , view = view
    , subscriptions = always Sub.none
    , update = update
    }
