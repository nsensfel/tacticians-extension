module Struct.Flags exposing
   (
      Type,
      get_frequency,
      get_players,
      decoder,
      encode
   )

-- Elm -------------------------------------------------------------------------
import Json.Decode
import Json.Encode

-- Extension -------------------------------------------------------------------
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      frequency : Int,
      players : (List Struct.Player.Type)
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
get_frequency : Type -> Int
get_frequency flags = flags.frequency

get_players : Type -> (List Struct.Player.Type)
get_players flags = flags.players

decoder : (Json.Decode.Decoder Type)
decoder =
   (Json.Decode.map2
      Type
      (Json.Decode.field "frequency" (Json.Decode.int))
      (Json.Decode.field "players" (Json.Decode.list (Struct.Player.decoder)))
   )

encode : Type -> Json.Encode.Value
encode flags =
   (Json.Encode.object
      [
         ("frequency", (Json.Encode.int flags.frequency)),
         (
            "players",
            (Json.Encode.list (List.map (Struct.Player.encode) flags.players))
         )
      ]
   )
