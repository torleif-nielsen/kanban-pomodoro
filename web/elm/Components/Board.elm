module Components.Board exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (href, class, style)
import Material
import Material.Button as Button
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Icon as Icon
import Material.Grid exposing (grid, cell, size, Device(..))
import Material.Layout as Layout
import Material.Options as Options exposing (..)
import Material.Scheme
import Components.Section as Section exposing (..)

-- MODEL
type alias Mdl =
  Material.Model

type alias TaskCard =
  { description : String
  , mdl         : Mdl
  }

type alias Section =
  { title     : String
  , taskCards : List TaskCard
  , mdl       : Mdl
  }

type alias Board =
  { title    : String
  , sections : List Section
  , mdl      : Mdl
  }

-- INIT
-- Initialize starting values
initMdl : Mdl
initMdl = Material.model

initTaskCard : TaskCard
initTaskCard =
  { description = "I'm a Task Card, edit me!"
  , mdl         = initMdl
  }

initSection : Section
initSection =
  { title     = "I'm a board section!"
  , taskCards =
      [ initTaskCard
      , initTaskCard
      , initTaskCard
      ]
  , mdl       = initMdl
  }

initBoard : Board
initBoard =
  { title    = "Grapefruit Board"
  , sections =
      [ initSection
      , initSection
      , initSection
      ]
  , mdl      = initMdl
  }

-- MESSAGE
type Msg
  = Mdl (Material.Msg Msg)
  | SectionMsg Section.Msg

-- UPDATE
update : Msg -> Board -> ( Board, Cmd Msg )
update msg board =
  case msg of
    Mdl msg' ->
      Material.update msg' board

-- VIEW
view : Board -> Html Msg
view board =
  Layout.render Mdl
    board.mdl
    [ Layout.fixedHeader
    ]
    { header = [ h1 [ style [ ( "padding", "0 2rem" ) ] ] [ text "Grapefruit" ] ]
    , drawer = []
    , tabs = ( [], [] )
    , main = []
    }

boardLayout : Board -> Html Msg
boardLayout board =
  Options.div
    []
    [ App.map SectionMsg (Section.view board.sections) |> grid []
    ]

-- -- This is referred to as the "model container"
-- type alias Model =
--   { count : Int
--   , boardList : BoardList
--   , mdl : Material.Model
--     -- Boilerplate: model store for any and all Mdl components you use.
--   }
--
--
-- -- `Material.model` provides the initial model
-- model : Model
-- model =
--   { count = 0
--   , boardList = boardList
--   , mdl =
--     Material.model
--     -- Boilerplate: Always use this initial Mdl model store.
--   }
--
--
--
-- -- ACTION, UPDATE
--
--
-- -- You need to tag `Msg` that are coming from `Mdl` so you can dispatch them
-- -- appropriately.
-- type Msg
--   = Mdl (Material.Msg Msg)
--
--
--
-- -- Boilerplate: Msg clause for internal Mdl messages.
--
--
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--   case msg of
--     -- When the `Mdl` messages come through, update appropriately.
--     Mdl msg' ->
--       Material.update msg' model
--
--
--
-- -- VIEW
--
--
-- type alias Mdl =
--   Material.Model
--
-- view : Model -> Html Msg
-- view model =
--   Layout.render Mdl
--     model.mdl
--     [ Layout.fixedHeader
--     ]
--     { header = [ h1 [ style [ ( "padding", "0 2rem" ) ] ] [ text "Grapefruit" ] ]
--     , drawer = []
--     , tabs = ( [], [] )
--     , main = [ viewBody model ]
--     }
--
-- cardItem card =
--   Card.view
--     [ Elevation.e2
--     , css "margin-bottom" "10px"
--     ]
--     [ Card.title
--       []
--       [ Card.head
--         []
--         [ text card.description ]
--       ]
--     , Card.text
--       []
--       [ text "Card description" ]
--     , Card.actions
--       [ Card.border ]
--       [ Button.render Mdl [1,0] model.mdl
--         [ Button.ripple, Button.colored ]
--         [ Icon.i "edit" ]
--       , Button.render Mdl [1,1] model.mdl
--         [ Button.ripple, Button.accent ]
--         [ Icon.i "delete" ]
--       ]
--     ]
--
-- board board =
--   cell
--     [ size Desktop 4, size Tablet 6, size Phone 12 ]
--     [
--       Card.view
--         [  Elevation.e2 ]
--         [ Card.title
--           []
--           [ Card.head
--             []
--             [ text board.title ]
--           ]
--         , Card.text []
--             [ Options.div [] (List.map cardItem board.cards) ]
--         , Card.actions
--             [ Card.border ]
--             [ Button.render Mdl [1,1] model.mdl
--               [ Button.ripple, Button.accent ]
--               [ Icon.i "delete" ]
--             ]
--         ]
--     ]
--
-- viewBody : Model -> Html Msg
-- viewBody model =
--   Options.div
--     []
--     [ (List.map board boardList) |> grid []
--     ]
--     -- |> Material.Scheme.top
--
-- -- Load Google Mdl CSS. You'll likely want to do that not in code as we
-- -- do here, but rather in your master .html file. See the documentation
-- -- for the `Material` module for details.
