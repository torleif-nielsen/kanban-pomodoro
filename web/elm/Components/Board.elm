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
import Material.Textfield as Textfield
import Material.Dialog as Dialog

-- MODEL
type alias Mdl =
  Material.Model

type alias TaskCard =
  { title       : String
  , description : String
  }

type alias Section =
  { title     : String
  , taskCards : List TaskCard
  }

type alias Board =
  { title    : String
  , sections : List Section
  , mdl      : Material.Model
  }

-- INIT

taskCard : TaskCard
taskCard =
  { title       = "Task"
  , description = "A card for a task"
  }

section : Section
section =
  { title   = "Task List"
  , taskCards =
      [ taskCard
      , taskCard
      , taskCard
      ]
  }


board : Board
board =
  { title    = "Grapefruit Board"
  , sections =
      [ section
      , section
      , section
      ]
  , mdl = Material.model
  }

-- MSG

type Msg
  = Mdl (Material.Msg Msg)

-- ACTION, UPDATE

update : Msg -> Board -> ( Board, Cmd Msg )
update msg board =
  case msg of
    -- When the `Mdl` messages come through, update appropriately.
    Mdl msg' ->
      Material.update msg' board

-- VIEW
view : Board -> Html Msg
view board =
  Layout.render Mdl
    board.mdl
    [ Layout.fixedHeader
    ]
    { header =
        [ h1
          [ style [ ( "padding", "0 2rem" ) ] ]
          [ text "Grapefruit" ]
        ]
    , drawer = []
    , tabs = ( [], [] )
    , main = []
    }
--
--
-- type alias Mdl =
--   Material.Model
--
-- view : Model -> Html Msg
-- view board =
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
--         [ text "Task" ]
--       ]
--     , Card.text
--       []
--       [ text card.description
--       , Dialog.view
--         []
--         [ Dialog.title [] [ text "Editing Card Description" ]
--         , Dialog.content []
--           [ Textfield.render Mdl [4] model.mdl
--             [ Textfield.textarea
--             , Textfield.rows 10
--             , Textfield.value card.description
--             -- , Textfield.onInput Edit
--             ]
--           ]
--         , Dialog.actions []
--           [ Button.render Mdl [3] model.mdl
--             [ Button.primary
--             , Button.raised
--             , Dialog.closeOn "click"
--             ]
--             [ text "Save" ]
--           ]
--         ]
--       ]
--     , Card.actions
--       [ Card.border ]
--       [ Button.render Mdl [1,0] model.mdl
--         [ Button.ripple
--         , Button.colored
--         , Dialog.openOn "click"
--         ]
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
