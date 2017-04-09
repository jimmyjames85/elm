module Main exposing (..)

import Random exposing(..)
import Mouse exposing (..)
import Keyboard exposing (..)
import Html exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Html.Events exposing (onClick)
import Debug


-- type alias TodoItem =
--     { item : String
--     , due_date : String
--     , created_at : String
--     , priority : Int
--     }


type Msg
    = Increment
    | Decrement
    | NoOp
    | MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
    | RInt Int
    | FetchUrl String


type alias Model =
    Pix


type alias Pix =
    { count : Int
    , gifUrl : String
    }

-- int : Int -> Int -> Generator Int
-- Generate 32-bit integers in a given range.

-- int 0 10   -- an integer between zero and ten
-- int -5 5   -- an integer between -5 and 5

-- int minInt maxInt  -- an integer in the widest range feasible

-- This function can produce values outside of the range [minInt,
-- maxInt] but sufficient randomness is not guaranteed.

--            ( model, Random.generate➊ OnResult (Random.int 1 6) )





main : Program Never Model Msg
main =
    Html.program
        { init = init -- init : ( model, Platform.Cmd msg )
        , view = view -- view : model -> Html.Html msg
        , update = update -- update : msg -> model -> ( model, Platform.Cmd msg )
        , subscriptions = subscriptions -- subscriptions : model -> Sub msg
        }


-- update : msg -> model -> ( model, Platform.Cmd msg )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( Debug.log "increment" ({ model | count = model.count + 3 }), Cmd.none )

        Decrement ->
            ( Debug.log "increment" ({ model | count = model.count - 2 }), Cmd.none )

        NoOp ->
            ( model, Cmd.none )


-- //  | NewGif (Result Http.Error String)
        MouseMsg p ->
--            ( { model | gifUrl = "mouse: " ++ toString (p) },  Http.get urlCmd.none )
            ( { model | gifUrl = "mouse: " ++ toString (p) },  Cmd.none )

        KeyMsg k ->
            ( { model | gifUrl = "  key: " ++ toString (k) }, Random.generate RInt (Random.int 1 23))

        RInt i ->
            ( { model | count = i }, Cmd.none)

        FetchUrl url ->
            ( { model | gifUrl = url }, Cmd.none)

-- send : (Result Error a -> msg) -> Request a -> Cmd msg

init : ( Model, Cmd Msg )
init =
    ( Pix 232 "google.com", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]


view : Model -> Html.Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+" ]
        , br [] []
        , text (toString model)
        , br [] []
        , text (respond Yes)
        , br [] []
        , text (respond No)
        , br [] []
        , text (respond (Other "cuz I can't <br>"))
        , br [] []
        , text (readMessageStr (Message "codehere" "body here"))
        , br [] []
        , text (readMessageInt (Message "codehere" 234))
        , br [] []
        , button [ onClick Decrement ] [ text "-" ]
        ]





type Answer
    = Yes
    | No
    | Other String


respond : Answer -> String
respond answer =
    case answer of
        Yes ->
            ":-D Hooray!!!"

        No ->
            ":-( Why Not"

        Other msg ->
            msg


type alias Message a =
    { code : String, body : a }


readMessage : Message () -> String
readMessage msg =
    "code: " ++ msg.code


readMessageStr : Message String -> String
readMessageStr msg =
    "code: " ++ msg.code ++ " body: " ++ msg.body


readMessageInt : Message Int -> String
readMessageInt msg =
    "code: " ++ msg.code ++ " body: " ++ toString (msg.body)



-- getRandomGif : String -> String
-- getRandomGif topic =
--   let
--     url =
--       "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
--   in
--       case Http.get url decodeGifUrl of
--           Ok img ->
--               img
--           Err e ->
--               e
-- Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



-- https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=catz
