module Comm.SetBattles exposing (decoder)

-- Elm -------------------------------------------------------------------------
import Json.Decode

-- Extension -------------------------------------------------------------------
import Struct.BattleSummary
import Struct.ServerReply

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type alias Battles =
   {
      campaigns : (List Struct.BattleSummary.Type),
      invasions : (List Struct.BattleSummary.Type),
      events : (List Struct.BattleSummary.Type)
   }

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------
internal_decoder : (Json.Decode.Decoder Battles)
internal_decoder =
   (Json.Decode.map3
      Battles
      (Json.Decode.field
         "cmps"
         (Json.Decode.list (Struct.BattleSummary.decoder))
      )
      (Json.Decode.field
         "invs"
         (Json.Decode.list (Struct.BattleSummary.decoder))
      )
      (Json.Decode.field
         "evts"
         (Json.Decode.list (Struct.BattleSummary.decoder))
      )
   )

to_server_reply : Int -> Battles -> Struct.ServerReply.Type
to_server_reply ix t =
   (Struct.ServerReply.SetBattles (ix, t.campaigns, t.invasions, t.events))

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
decoder : Int -> (Json.Decode.Decoder Struct.ServerReply.Type)
decoder ix =
   (Json.Decode.map (to_server_reply ix) (internal_decoder))
