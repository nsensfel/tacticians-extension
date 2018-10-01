module Struct.Model exposing
   (
      Type,
      new,
      invalidate,
      reset,
      clear_error,
      set_flags
   )

-- Elm -------------------------------------------------------------------------
import Array

-- Extension -------------------------------------------------------------------
import Struct.Error
import Struct.Flags
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      flags: Struct.Flags.Type,
      players: (Array.Array Struct.Player.Type),
      remaining_updates: Int,
      error: (Maybe Struct.Error.Type)
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
set_flags : Struct.Flags.Type -> Type -> Type
set_flags flags t =
   let
      players_array = (Array.fromList (Struct.Flags.get_players flags))
   in
      {t |
         flags = flags,
         players = players_array,
         remaining_updates = (Array.length players_array)
      }

new : Struct.Flags.Type -> Type
new flags =
   {
      flags = flags,
      players = (Array.fromList (Struct.Flags.get_players flags)),
      remaining_updates = (List.length (Struct.Flags.get_players flags)),
      error = Nothing
   }

reset : Type -> Type
reset model = {model | error = Nothing}

invalidate : Struct.Error.Type -> Type -> Type
invalidate err model = {model | error = (Just err)}

clear_error : Type -> Type
clear_error model = {model | error = Nothing}
