module Update.StoreParams exposing (apply_to)

-- Elm -------------------------------------------------------------------------
import Array

import Json.Encode

-- Extension -------------------------------------------------------------------
import Action.Ports

import Struct.Event
import Struct.Flags
import Struct.Model
import Struct.Player

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
      (Action.Ports.store_params
         (
            (Struct.Flags.get_frequency model.flags),
            (Json.Encode.encode
               0
               (Json.Encode.list
                  (List.map (Struct.Player.encode) (Array.toList model.players))
               )
            )
         )
      )
   )
