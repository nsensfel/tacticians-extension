module Update.RefreshBattles exposing (apply_to)

-- Elm -------------------------------------------------------------------------
import Array

-- Extension -------------------------------------------------------------------
import Comm.GetBattles

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
   case (Array.get 0 model.players) of
      Nothing -> (model, Cmd.none)
      (Just player) ->
         case (Comm.GetBattles.try model player) of
            -- TODO: Invalidate only this player, refresh the others.
            Nothing -> (model, Cmd.none)
            (Just cmd) -> ({model | query_index = 0}, cmd)
