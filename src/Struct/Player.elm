module Struct.Player exposing
   (
      Type,
      get_ix,
      get_id,
      get_username,
      get_campaigns,
      get_invasions,
      get_events,
      set_battles,
      has_active_battles
   )

-- Elm -------------------------------------------------------------------------
import Json.Decode
import Json.Decode.Pipeline

-- Extension -------------------------------------------------------------------
import Struct.BattleSummary

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      ix : Int,
      id : String,
      name : String,
      campaigns : (List Struct.BattleSummary.Type),
      invasions : (List Struct.BattleSummary.Type),
      events : (List Struct.BattleSummary.Type)
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
get_ix : Type -> Int
get_ix t = t.ix

get_id : Type -> String
get_id t = t.id

get_username : Type -> String
get_username t = t.name

get_campaigns : Type -> (List Struct.BattleSummary.Type)
get_campaigns t = t.campaigns

get_invasions : Type -> (List Struct.BattleSummary.Type)
get_invasions t = t.invasions

get_events : Type -> (List Struct.BattleSummary.Type)
get_events t = t.events

set_battles : (
      (List Struct.BattleSummary.Type) ->
      (List Struct.BattleSummary.Type) ->
      (List Struct.BattleSummary.Type) ->
      Type ->
      Type
   )
set_battles campaigns invasions events t =
   {t |
      campaigns =
         (List.filter (Struct.BattleSummary.is_players_turn) campaigns),
      invasions =
         (List.filter (Struct.BattleSummary.is_players_turn) invasions),
      events = (List.filter (Struct.BattleSummary.is_players_turn) events)
   }

has_active_battles : Type -> Bool
has_active_battles t =
   (
      (
         (List.length t.campaigns)
         + (List.length t.invasions)
         + (List.length t.events)
      )
      > 0
   )
