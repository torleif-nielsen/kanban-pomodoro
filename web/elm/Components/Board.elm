module Components.Board exposing (..)

import Components.Section as Section
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias ID = Int

type alias Model =
  { title    : String
  , sections : List ( ID, Section.Model )
  , nextID   : ID
  }

-- INIT

init : Model
init =
  { title    = "Grapefruit Board"
  , sections = []
  , nextID   = 0
  }

-- MSG
type Msg
  = Insert
  | SectionMsg ID Section.Msg


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
      Insert ->
        ( { model
          | sections = ( model.nextID, Section.init ) :: model.sections
          , nextID = model.nextID + 1
          }
        , Cmd.none
        )
      SectionMsg id sectionMsg ->
        let
          updateSection (sectionID, sectionModel) =
            case (sectionID == id, Section.update sectionMsg sectionModel) of
              (False, _) ->
                Just (sectionID, sectionModel) -- not the current section
              (True, (newSectionModel, Just Section.Remove)) ->
                Nothing -- current section + Remove;
              (True, (newSectionModel, _)) ->
                Just (sectionID, newSectionModel) -- current section
        in
          ( { model | sections = List.filterMap updateSection model.sections }
          , Cmd.none
          )
-- VIEW
view : Model -> Html Msg
view model =
  let insert = button [ onClick Insert ] [ text "Add Section" ]
  in
    div []
      [ h1
          []
          [ text model.title ]
      , div []
          (insert :: List.map viewSection model.sections)
      ]

viewSection : (ID, Section.Model) -> Html Msg
viewSection (id, model) =
  Html.map (SectionMsg id) (Section.view model)
