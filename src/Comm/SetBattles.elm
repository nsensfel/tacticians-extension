module Comm.SetBattles exposing (decoder)

-- Elm -------------------------------------------------------------------------
import Json.Decode

-- Extension -------------------------------------------------------------------
import Struct.BattleSummary
import Struct.Player
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

to_server_reply : Battles -> Struct.ServerReply.Type
to_server_reply t =
   (Struct.ServerReply.SetBattles (t.campaigns, t.invasions, t.events))

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
decoder : (Json.Decode.Decoder Struct.ServerReply.Type)
decoder =
   (Json.Decode.map (to_server_reply) (internal_decoder))
