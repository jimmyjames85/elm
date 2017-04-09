import Html exposing (..)
import Http
import Json.Decode as Decode

main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

-- MODEL
type alias Model = List TodoItem

type Msg = FetchedTodos ( Result Http.Error (List TodoItem))

type alias TodoItem =
    { item : String
    , due_date : String
    , created_at : String
    , priority : Int
    }

init : (Model, Cmd Msg)
init = ([], fetchTodos)

fetchTodos : Cmd Msg
fetchTodos = 
    let
        url =
            "http://localhost:1234/getall"
    in
        Http.send FetchedTodos (Http.get url todoListDecoder)

todoListDecoder : Decode.Decoder (List TodoItem)
todoListDecoder = Decode.at [""] (Decode.list todoItemDecoder)

-- todoItemDecoder : Decode.Decoder TodoItem
todoItemDecoder = Decode.decodeString object
-- map4 TodoItem
--                   (item "item" String)
--                   (priority "priority" Int)
--                   (createat "created_at" Int)
--                   (duedate "due_date" Int)

-- Decode.string Decode.string Decode.string Decode.string --



------------------------------

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchedTodos (Ok lst) ->
            let _ = Debug.log "OK: results: " lst 
            in
                (model, Cmd.none)
            
        FetchedTodos (Err e) ->
            let _ = Debug.log "ERR: results: " e
            in
                (model, Cmd.none)


view : Model -> Html Msg
view model =
  div []
    [ listTable model
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
