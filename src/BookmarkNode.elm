module BookmarkNode exposing (RootBookmarkNode, rootBookmarkNodeDecoder, into)

import Json.Decode as D


type alias BookmarkNode =
  { id: String
  , parentId: Maybe String
  , title : String
  , children : Maybe (List Node)
  }

type Node = Node BookmarkNode

into : Node -> BookmarkNode
into node = case node of Node x -> x

type alias RootBookmarkNode =
  { bar: BookmarkNode
  , others: BookmarkNode
  }

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

rootBookmarkNodeDecoder : D.Decoder RootBookmarkNode
rootBookmarkNodeDecoder =
  D.map2 RootBookmarkNode
    (D.field "bar" bookmarkNodeDecoder)
    (D.field "others" bookmarkNodeDecoder)
