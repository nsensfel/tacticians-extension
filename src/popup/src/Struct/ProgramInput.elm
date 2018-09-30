module Struct.ProgramInput exposing
   (
      Type,
      get_flags,
      get_players
   )

-- Elm -------------------------------------------------------------------------
import Json.Decode

-- Extension -------------------------------------------------------------------
import Struct.Flags
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      params: String,
      players: String
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
get_players : Type -> (List Struct.Player.Type)
get_players inputs =
   case
      (Json.Decode.decodeString
         (Json.Decode.list (Struct.Player.decoder))
         inputs.players
      )
   of
      (Ok players) -> players
      (Err _) -> []

get_flags : Type -> Struct.Flags.Type
get_flags inputs =
   case (Json.Decode.decodeString (Struct.Flags.decoder) inputs.params) of
      (Ok flags) -> flags
      (Err _) -> (Struct.Flags.default)
