module Main exposing (main)

import Browser
import Html exposing (Html, text)


-- Model
-- ============================================================================

type alias Model = ()

init : Model
init = ()


-- Update
-- ============================================================================

type alias Msg = Never

update : Msg -> Model -> Model
update _ model = model


-- View
-- ============================================================================

view : Model -> Html Msg
view _ = text "Lorem ipsum ..."


-- Application Entry Point
-- ============================================================================

main : Program () Model Msg
main =
  Browser.sandbox {
    init = init,
    update = update,
    view = view
  }
