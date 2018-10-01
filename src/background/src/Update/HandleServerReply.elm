module Update.HandleServerReply exposing (apply_to)

-- Elm -------------------------------------------------------------------------
import Array

import Json.Encode

import Http

import List

-- Extension -------------------------------------------------------------------
import Action.Ports

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
maybe_update_storage : (
      Struct.Model.Type ->
      (List (Cmd Struct.Event.Type)) ->
      (List (Cmd Struct.Event.Type))
   )
maybe_update_storage model cmds =
   if (model.remaining_updates > 0)
   then
      cmds
   else
      let
         players_list = (Array.toList model.players)
      in
         (
            (Action.Ports.set_results
               (Json.Encode.encode
                  0
                  (Json.Encode.list
                     (List.map (Struct.Player.encode) players_list)
                  )
               )
            )
            ::
            (
               (
                  if (List.any (Struct.Player.has_active_battles) players_list)
                  then (Action.Ports.activate_notification ())
                  else (Action.Ports.disable_notification ())
               )
               :: cmds
            )
         )

handle_set_battles : (
      (
         Int,
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
      (ix, campaigns, invasions, events) = battles
   in
      case (Array.get ix model.players) of
         Nothing ->
            let
               updated_model =
                  {model | remaining_updates = (model.remaining_updates - 1)}
            in
               (
                  updated_model,
                  (maybe_update_storage updated_model cmds)
               )

         (Just player) ->
            let
               updated_model =
                  {model |
                     remaining_updates = (model.remaining_updates - 1),
                     players =
                     (Array.set
                        ix
                        (Struct.Player.set_battles
                           campaigns
                           invasions
                           events
                           player
                        )
                        model.players
                     )
                  }
            in
               (
                  updated_model,
                  (maybe_update_storage updated_model cmds)
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
