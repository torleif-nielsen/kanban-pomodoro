module Components.Section exposing (..)

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

-- INIT
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

-- MESSAGE
type Msg
  = Mdl (Material.Msg Msg)

-- UPDATE
update : Msg -> Section -> ( Section, Cmd Msg )
update msg section =
  case msg of
    Mdl msg' ->
      Material.update msg' section

-- VIEW
view : Section -> Html Msg
view section =
  Options.div
  []
  [ text "Hello" ]
  --  cell
  --   [ size Desktop 4, size Tablet 6, size Phone 12 ]
  --   [
  --     Card.view
  --       [  Elevation.e2 ]
  --       [ Card.title
  --         []
  --         [ Card.head
  --           []
  --           [ text section.title ]
  --         ]
  --       , Card.text []
  --           [ Options.div [] [] ]
  --       , Card.actions
  --           [ Card.border ]
  --           [ Button.render Mdl [1,1] section.mdl
  --             [ Button.ripple, Button.accent ]
  --             [ Icon.i "delete" ]
  --           ]
  --       ]
  --   ]
