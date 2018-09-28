module ElmModule.Subscriptions exposing (..)

-- Elm -------------------------------------------------------------------------
import Time

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
         (Action.Ports.params_in (\s -> (Struct.Event.ReadParams s))),
         (Time.every
            ((toFloat (Struct.Flags.get_frequency model.flags)) * Time.minute)
            (\e -> (Struct.Event.ShouldRefresh))
         )
      ]
   )
