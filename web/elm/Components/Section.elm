module Components.Section exposing (..)

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
import Material.Grid exposing (grid, cell, size, Device(..))
import Material.Options as Options exposing (..)
import Material.Textfield as Textfield

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
  , mdl       : Material.Model
  }

-- INIT
init : Section
init =
  { title     = "Task List"
  , taskCards =
      [ taskCard
      , taskCard
      , taskCard
      ]
  , mdl       = Material.model
  }

taskCard : TaskCard
taskCard =
  { title       = "Task"
  , description = "A card for a task"
  }

section : Section
section =
  init

-- MSG
type Msg
  = Mdl (Material.Msg Msg)

-- ACTION, UPDATE

update : Msg -> Section -> ( Section, Cmd Msg )
update msg section =
  case msg of
    -- When the `Mdl` messages come through, update appropriately.
    Mdl msg' ->
      Material.update msg' section

-- VIEW
view : Section -> Material.Grid.Cell Msg
view section =
  cell
    [ size Desktop 4, size Tablet 6, size Phone 12 ]
    [
      Card.view
        [ Elevation.e2 ]
        [ Card.title
          []
          [ Card.head
            []
            [ text "Title" ]
          ]
        , Card.text []
            []
        , Card.actions
            [ Card.border ]
            [ Button.render Mdl [1,1] section.mdl
              [ Button.ripple, Button.accent ]
              [ Icon.i "delete" ]
            ]
        ]
    ]
