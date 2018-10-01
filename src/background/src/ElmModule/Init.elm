module ElmModule.Init exposing (init)

-- Elm -------------------------------------------------------------------------
import Json.Decode

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
init : String -> (Struct.Model.Type, (Cmd Struct.Event.Type))
init encoded_flags =
   (
      (Struct.Model.new
         (
            case
               (Json.Decode.decodeString (Struct.Flags.decoder) encoded_flags)
            of
               (Err _) -> (Struct.Flags.default)
               (Ok flags) -> flags
         )
      ),
      Cmd.none
   )
