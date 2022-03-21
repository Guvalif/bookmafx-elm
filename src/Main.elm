module Main exposing (main)

import Browser
import Html exposing (Html, text)


-- Model
-- ============================================================================

type alias Model = ()

init : () -> ( Model, Cmd Msg )
init _ =
  ( (), Cmd.none )


-- Update
-- ============================================================================

type alias Msg = Never

update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
  ( model, Cmd.none )


-- View
-- ============================================================================

view : Model -> Html Msg
view _ = text "Lorem ipsum ..."


-- Subscriptions
-- ============================================================================

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- Application Entry Point
-- ============================================================================

main : Program () Model Msg
main =
  Browser.element {
    init = init,
    update = update,
    view = view,
    subscriptions = subscriptions
  }
