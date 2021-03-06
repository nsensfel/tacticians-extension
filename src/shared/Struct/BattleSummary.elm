module Struct.BattleSummary exposing
   (
      Type,
      get_id,
      get_name,
      get_last_edit,
      is_players_turn,
      decoder,
      encode,
      none
   )

-- Elm -------------------------------------------------------------------------
import Json.Decode
import Json.Decode.Pipeline

import Json.Encode

-- Extension -------------------------------------------------------------------

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      id : String,
      name : String,
      last_edit : String,
      is_players_turn : Bool
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
get_id : Type -> String
get_id t = t.id

get_name : Type -> String
get_name t = t.name

get_last_edit : Type -> String
get_last_edit t = t.last_edit

is_players_turn : Type -> Bool
is_players_turn t = t.is_players_turn

decoder : (Json.Decode.Decoder Type)
decoder =
   (Json.Decode.Pipeline.decode
      Type
      |> (Json.Decode.Pipeline.required "id" Json.Decode.string)
      |> (Json.Decode.Pipeline.required "nme" Json.Decode.string)
      |> (Json.Decode.Pipeline.required "ldt" Json.Decode.string)
      |> (Json.Decode.Pipeline.required "ipt" Json.Decode.bool)
   )

encode : Type -> Json.Encode.Value
encode t =
   (Json.Encode.object
      [
         ("id", (Json.Encode.string t.id)),
         ("nme", (Json.Encode.string t.name)),
         ("ldt", (Json.Encode.string t.last_edit)),
         ("ipt", (Json.Encode.bool t.is_players_turn))
      ]
   )

none : Type
none =
   {
      id = "",
      name = "Unknown",
      last_edit = "Never",
      is_players_turn = False
   }
