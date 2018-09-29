module ElmModule.Subscriptions exposing (..)

-- Elm -------------------------------------------------------------------------
import Time

import Json.Decode

-- Extension -------------------------------------------------------------------
import Action.Ports

import Struct.Model
import Struct.Event
import Struct.Flags

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
subscriptions : Struct.Model.Type -> (Sub Struct.Event.Type)
subscriptions model =
   (Sub.batch
      [
         (Action.Ports.params_in
            (\s ->
               case (Json.Decode.decodeString (Struct.Flags.decoder) s) of
                  (Err _) -> (Struct.Event.ReadParams (Struct.Flags.default))
                  (Ok flags) -> (Struct.Event.ReadParams flags)
            )
         ),
         (Time.every
            ((toFloat (Struct.Flags.get_frequency model.flags)) * Time.minute)
            (\e -> (Struct.Event.ShouldRefresh))
         )
      ]
   )
