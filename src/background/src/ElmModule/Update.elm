module ElmModule.Update exposing (update)

-- Elm -------------------------------------------------------------------------

-- Extension -------------------------------------------------------------------
import Action.Ports

import Struct.Event
import Struct.Model

import Update.HandleServerReply
import Update.RefreshBattles

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
update : (
      Struct.Event.Type ->
      Struct.Model.Type ->
      (Struct.Model.Type, (Cmd Struct.Event.Type))
   )
update event model =
   let
      new_model = (Struct.Model.clear_error model)
   in
      case event of
         Struct.Event.None -> (model, Cmd.none)

         (Struct.Event.ReadParams flags) ->
            (Update.RefreshBattles.apply_to
               (Struct.Model.set_flags flags model)
            )

         Struct.Event.ShouldRefresh -> (model, (Action.Ports.get_params ()))

         (Struct.Event.Failed err) ->
            ((Struct.Model.invalidate err new_model), Cmd.none)

         (Struct.Event.ServerReplied result) ->
            (Update.HandleServerReply.apply_to model result)
