module Update.HandleServerReply exposing (apply_to)

-- Elm -------------------------------------------------------------------------
import Array

import Http

-- Extension -------------------------------------------------------------------
import Comm.GetBattles

import Struct.BattleSummary
import Struct.Error
import Struct.Event
import Struct.Model
import Struct.Player
import Struct.ServerReply

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------
handle_set_battles : (
      (
         (List Struct.BattleSummary.Type),
         (List Struct.BattleSummary.Type),
         (List Struct.BattleSummary.Type)
      ) ->
      (Struct.Model.Type, (List (Cmd Struct.Event.Type))) ->
      (Struct.Model.Type, (List (Cmd Struct.Event.Type)))
   )
handle_set_battles battles current_state =
   let
      (model, cmds) = current_state
      (campaigns, invasions, events) = battles
   in
      case (Array.get model.query_index model.players) of
         Nothing -> current_state -- TODO: error
         (Just player) ->
            let
               updated_player =
                  (Struct.Player.set_battles
                     campaigns
                     invasions
                     events
                     player
                  )
               updated_model =
                  {model |
                     players =
                        (Array.set
                           model.query_index
                           updated_player
                           model.players
                        ),
                     query_index = (model.query_index + 1),
                     notify =
                        (
                           model.notify
                           || (Struct.Player.has_active_battles updated_player)
                        )
                  }
            in
               case (Array.get updated_model.query_index model.players) of
                  Nothing -> ({updated_model| query_index = -1}, cmds)

                  (Just next_player) ->
                     (
                        updated_model,
                        (
                           (Comm.GetBattles.request next_player)
                           :: cmds
                        )
                     )

apply_command : (
      Struct.ServerReply.Type ->
      (Struct.Model.Type, (List (Cmd Struct.Event.Type))) ->
      (Struct.Model.Type, (List (Cmd Struct.Event.Type)))
   )
apply_command command current_state =
   case command of
      Struct.ServerReply.Okay -> current_state
      (Struct.ServerReply.SetBattles battles) ->
         (handle_set_battles battles current_state)

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
apply_to : (
      Struct.Model.Type ->
      (Result Http.Error (List Struct.ServerReply.Type)) ->
      (Struct.Model.Type, (Cmd Struct.Event.Type))
   )
apply_to model query_result =
   case query_result of
      (Result.Err error) ->
         (
            (Struct.Model.invalidate
               (Struct.Error.new Struct.Error.Networking (toString error))
               model
            ),
            Cmd.none
         )

      (Result.Ok commands) ->
         let
            (new_model, elm_commands) =
               (List.foldl (apply_command) (model, [Cmd.none]) commands)
         in
            (
               new_model,
               (
                  case elm_commands of
                     [] -> Cmd.none
                     [cmd] -> cmd
                     _ -> (Cmd.batch elm_commands)
               )
            )
