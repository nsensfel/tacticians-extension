module ElmModule.Update exposing (update)

-- Elm -------------------------------------------------------------------------

-- Main Menu -------------------------------------------------------------------
import Struct.Event
import Struct.Model

import Update.HandleServerReply
import Update.StoreParams

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

      (Struct.Event.SetUsername str) -> (model, Cmd.none)
      (Struct.Event.SetID str) -> (model, Cmd.none)
      (Struct.Event.SetURLPrefix str) -> (model, Cmd.none)
      (Struct.Event.SetFrequency val) -> (Update.StoreParams.apply_to model)

      (Struct.Event.Failed err) ->
         (
            (Struct.Model.invalidate err new_model),
            Cmd.none
         )

      (Struct.Event.ServerReplied result) ->
         (Update.HandleServerReply.apply_to model result)
