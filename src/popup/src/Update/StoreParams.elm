module Update.StoreParams exposing (apply_to)

-- Elm -------------------------------------------------------------------------
import Array

import Json.Encode

-- Extension -------------------------------------------------------------------
import Action.Ports

import Struct.Event
import Struct.Flags
import Struct.Model

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
apply_to : Struct.Model.Type -> (Struct.Model.Type, (Cmd Struct.Event.Type))
apply_to model =
   (
      model,
      (Action.Ports.set_params
         (Json.Encode.encode
            0
            (Struct.Flags.encode
               (Struct.Flags.set_players
                  (Array.toList model.players)
                  model.flags
               )
            )
         )
      )
   )
