module Main exposing (main)

import Browser
import Html exposing (Html, text)
import BookmarkNode exposing (BookmarkNode, bookmarkNodeDecoder)
import Json.Decode exposing (Value, Error, decodeValue, errorToString)


-- Model
-- ============================================================================

type alias Model = Result Error BookmarkNode

init : Value -> ( Model, Cmd Msg )
init json =
  ( decodeValue bookmarkNodeDecoder json, Cmd.none )


-- Update
-- ============================================================================

type alias Msg = Never

update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
  ( model, Cmd.none )


-- View
-- ============================================================================

view : Model -> Html Msg
view model =
  case model of
    Ok bookmarkNode -> text (.title bookmarkNode)
    Err error -> text (errorToString error)


-- Subscriptions
-- ============================================================================

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- Application Entry Point
-- ============================================================================

main : Program Value Model Msg
main =
  Browser.element {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
