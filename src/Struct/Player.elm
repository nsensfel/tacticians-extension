module Struct.Player exposing
   (
      Type,
      get_id,
      set_id,
      get_query_url,
      set_query_url,
      get_username,
      set_username,
      get_campaigns,
      get_invasions,
      get_events,
      set_battles,
      has_active_battles,
      decoder,
      encode,
      default
   )

-- Elm -------------------------------------------------------------------------
import Json.Decode
import Json.Decode.Pipeline
import Json.Encode

-- Extension -------------------------------------------------------------------
import Struct.BattleSummary

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Type =
   {
      id : String,
      name : String,
      query_url : String,
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
get_id : Type -> String
get_id t = t.id

set_id : String -> Type -> Type
set_id str t = {t | id = str}

get_username : Type -> String
get_username t = t.name

set_username : String -> Type -> Type
set_username str t = {t | name = str}

get_query_url : Type -> String
get_query_url t = t.query_url

set_query_url : String -> Type -> Type
set_query_url str t = {t | query_url = str}

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

decoder : (Json.Decode.Decoder Type)
decoder =
   (Json.Decode.Pipeline.decode
      Type
      |> (Json.Decode.Pipeline.required "id" Json.Decode.string)
      |> (Json.Decode.Pipeline.required "name" Json.Decode.string)
      |> (Json.Decode.Pipeline.required "query_url" Json.Decode.string)
      |> (Json.Decode.Pipeline.hardcoded [])
      |> (Json.Decode.Pipeline.hardcoded [])
      |> (Json.Decode.Pipeline.hardcoded [])
   )

encode : Type -> Json.Encode.Value
encode t =
   (Json.Encode.object
      [
         ("id", (Json.Encode.string t.id)),
         ("name", (Json.Encode.string t.name)),
         ("query_url", (Json.Encode.string t.query_url))
      ]
   )

default : Type
default =
   {
      id = "0",
      name = "Username",
      query_url = "http://127.0.0.1/",
      campaigns = [],
      invasions = [],
      events = []
   }
