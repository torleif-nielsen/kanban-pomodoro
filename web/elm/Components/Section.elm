module Components.Section exposing (..)

import Components.Task as Task
import Dict exposing (..)
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL
type alias ID = Int

type alias Model =
  { tasks : List ( ID, Task.Model )
  , nextID : ID
  }



init : Model
init =
  { tasks = []
  , nextID = 0
  }


-- UPDATE

type Msg
  = Insert
  | TaskMsg ID Task.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Insert ->
      ( { model |
          tasks = ( model.nextID, Task.init ) :: model.tasks,
          nextID = model.nextID + 1
        }
      , Cmd.none
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
        , Cmd.none
        )


-- VIEW

view : Model -> Html Msg
view model =
  let insert = button [ onClick Insert ] [ text "Add Task" ]
  in
    div [] (insert :: List.map viewTask model.tasks)


viewTask : (ID, Task.Model) -> Html Msg
viewTask (id, model) =
  App.map (TaskMsg id) (Task.view model)
