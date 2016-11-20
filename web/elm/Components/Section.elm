module Components.Section exposing (..)

import Components.Task as Task
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (ariaHidden)
import Html.Events exposing (..)


-- MODEL
type alias ID = Int

type alias Model =
  { tasks : List ( ID, Task.Model )
  , title : String
  , nextID : ID
  }




init : Model
init =
  { tasks = []
  , title = "Section"
  , nextID = 0
  }


-- UPDATE

type Dispatch
  = Remove

type Msg
  = Insert
  | TaskMsg ID Task.Msg
  | RemoveSelf


update : Msg -> Model -> (Model, Maybe Dispatch)
update msg model =
  case msg of
    Insert ->
      ( { model
        | tasks  = ( model.nextID, Task.init ) :: model.tasks
        , nextID = model.nextID + 1
        }
      , Nothing
      )

    TaskMsg id taskMsg ->
      let
        updateTask (taskID, taskModel) =
          case (taskID == id, Task.update taskMsg taskModel) of
            (False, _) ->
              Just (taskID, taskModel) -- not the current task
            (True, (newTaskModel, Just Task.Remove)) ->
              Nothing -- current task +  Remove; should no longer be in the list
            (True, (newTaskModel, _)) ->
              Just (taskID, newTaskModel) -- current task; other actions
      in
        ( { model | tasks = List.filterMap updateTask model.tasks }
        , Nothing
        )

    RemoveSelf ->
      ( model, Just Remove )


-- VIEW

view : Model -> Html Msg
view model =
  let
    insert =
      a
        [ class "card-header-icon"
        , onClick Insert
        ]
        [ i
            [ class "material-icons"
            , ariaHidden True
            ]
            [ text "add" ]
        ]
    remove =
      a
        [ class "card-footer-item"
        , onClick RemoveSelf
        ]
        [ text "Delete Section" ]
  in
    div
      [ class "column is-one-third" ]
      [ div
          [ class "card is-fullwidth" ]
          [ header
              [ class "card-header" ]
              [ p
                  [ class "card-header-title" ]
                  [ text (model.title) ]
              , insert
              ]
          , div
              [ class "card-content" ]
              [ div
                  [ class "content" ]
                  (List.map viewTask model.tasks)
              ]
          , footer
              [ class "card-footer" ]
              [ remove ]
          ]
      ]


viewTask : (ID, Task.Model) -> Html Msg
viewTask (id, model) =
  Html.map (TaskMsg id) (Task.view model)
