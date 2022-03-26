module BookmarkNode exposing (BookmarkNode, bookmarkNodeDecoder)

import Json.Decode as D


type alias BookmarkNode =
  { id: String
  , parentId: Maybe String
  , title : String
  , children : Maybe (List Node)
  }

type Node = Node BookmarkNode

bookmarkNodeDecoder : D.Decoder BookmarkNode
bookmarkNodeDecoder =
  D.map4 BookmarkNode
    (D.field "id" D.string)
    (D.field "parentId" (D.nullable D.string))
    (D.field "title" D.string)
    (D.maybe (D.field "children" (D.list childrenDecoder)))

childrenDecoder : D.Decoder Node
childrenDecoder =
  D.map Node (D.lazy (\_ -> bookmarkNodeDecoder))
