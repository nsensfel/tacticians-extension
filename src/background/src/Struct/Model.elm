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
      players: (Array.Array Struct.Player.Type),
      query_index: Int,
      notify: Bool
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
      players =
         (Array.push
            (Struct.Player.default)
            (Array.fromList (Struct.Flags.get_players flags))
         ),
      query_index = -1,
      notify = False
   }

reset : Type -> Type
reset model =
   {model |
      error = Nothing,
      notify = False,
      query_index = -1
   }

invalidate : Struct.Error.Type -> Type -> Type
invalidate err model =
   {model |
      error = (Just err)
   }

clear_error : Type -> Type
clear_error model = {model | error = Nothing}
