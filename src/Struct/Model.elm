module Struct.Model exposing
   (
      Type,
      new,
      invalidate,
      reset,
      clear_error
   )

-- Elm -------------------------------------------------------------------------
import Array

-- Extension -------------------------------------------------------------------
import Struct.Flags
import Struct.Error
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      flags: Struct.Flags.Type,
      error: (Maybe Struct.Error.Type),
      players: (Array.Array Struct.Player.Type)
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
new : Struct.Flags.Type -> Type
new flags =
   {
      flags = flags,
      error = Nothing,
      players = (Array.empty)
   }

reset : Type -> Type
reset model =
   {model |
      error = Nothing
   }

invalidate : Struct.Error.Type -> Type -> Type
invalidate err model =
   {model |
      error = (Just err)
   }

clear_error : Type -> Type
clear_error model = {model | error = Nothing}
