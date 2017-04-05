import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = 0, view = view, update = update }

-- MODEL
type alias Model = Int
-- type alias TodoItem =
--     { item : String
--     , duedate : String
--     , createdat : String
--     , priority : number
--     }

model : Model
model = 0

type Msg = Increment | Decrement



update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
        model + 3

    Decrement ->
      model - 1

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , text "hello world"
    , listTable model
    ]

listTable : Model -> Html Msg
listTable model =
    let
        items = [ { item="item #0", dueDate="today000", createdAt="000", priority=0 }
                , { item="item #1", dueDate="today111", createdAt="111", priority=1 }
                , { item="item #2", dueDate="today222", createdAt="222", priority=2 }
                , { item="item #3", dueDate="today333", createdAt="333", priority=3 }
                , { item="item #4", dueDate="today444", createdAt="444", priority=4 }
                ]

        itemToRow = \ itm ->
                  tr [] 
                      [ td [] [text itm.item]
                      , td [] [text itm.dueDate]
                      , td [] [text itm.createdAt]
                      , td [] [text (toString itm.priority) ]
                      ]
    in
        
    div []
        [ table [] (List.map itemToRow items) ]
