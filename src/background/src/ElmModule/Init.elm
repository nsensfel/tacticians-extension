module ElmModule.Init exposing (init)

-- Elm -------------------------------------------------------------------------
import Delay

import Time

-- Extension -------------------------------------------------------------------
import Struct.Event
import Struct.Flags
import Struct.Model

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
init : Struct.Flags.Type -> (Struct.Model.Type, (Cmd Struct.Event.Type))
init flags =
   (
      (Struct.Model.new flags),
      (Delay.after
         (toFloat (Struct.Flags.get_frequency flags))
         (Time.minute)
         Struct.Event.ShouldRefresh
      )
   )
