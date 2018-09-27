module Comm.GetBattles exposing (try)

-- Elm -------------------------------------------------------------------------
import Json.Encode

-- Extension -------------------------------------------------------------------
import Comm.Send

import Struct.Event
import Struct.Model
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES ------------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------
try_encoding : String -> Struct.Model.Type -> (Maybe Json.Encode.Value)
try_encoding player_id model =
   let
      encoded_player_id = (Json.Encode.string player_id)
   in
      (Just
         (Json.Encode.object
            [
               ("id", encoded_player_id)
            ]
         )
      )

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
try : Struct.Model.Type -> Struct.Player.Type -> (Maybe (Cmd Struct.Event.Type))
try model player =
   (Comm.Send.try_sending
      model
      (
         (Struct.Player.get_query_url player)
         ++ "/handler/player/plr_get_battles"
      )
      (try_encoding (Struct.Player.get_id player))
   )
