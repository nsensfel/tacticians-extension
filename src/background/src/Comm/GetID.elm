module Comm.GetID exposing (try)

-- Elm -------------------------------------------------------------------------
import Json.Encode

-- Extension -------------------------------------------------------------------
import Comm.Send

import Constants.IO

import Struct.Event
import Struct.Model

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
try : Struct.Model.Type -> String -> (Maybe (Cmd Struct.Event.Type))
try model =
   (Comm.Send.try_sending
      model
      Constants.IO.get_battles_handler
      (try_encoding player_id)
   )
