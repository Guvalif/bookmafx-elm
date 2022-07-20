module Main exposing (main)

import Browser
import Html exposing (Html, div, li, text)
import Html.Attributes exposing (class)
import BookmarkNode exposing (RootBookmarkNode, rootBookmarkNodeDecoder, into)
import Json.Decode exposing (Value, Error, decodeValue, errorToString)
import Html exposing (ul)


-- Model
-- ============================================================================

type alias Model = Result Error RootBookmarkNode

init : Value -> ( Model, Cmd Msg )
init json =
  ( decodeValue rootBookmarkNodeDecoder json, Cmd.none )


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
    Ok rootBookmarkNode -> 
      div [ class "container" ]
        [ div [ class "columns" ]
          [ div [ class "column col-6" ]
            [ ul [] (List.map (into >> .title >> \t -> li [] [ text t ]) (Maybe.withDefault [] (rootBookmarkNode |> .bar |> .children))) ]
          , div [ class "column col-6" ]
            [ ul [] (List.map (into >> .title >> \t -> li [] [ text t ]) (Maybe.withDefault [] (rootBookmarkNode |> .others |> .children))) ]
          ]
        ]
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
