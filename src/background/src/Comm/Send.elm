module Comm.Send exposing (commit)

-- Elm -------------------------------------------------------------------------
import Http

import Json.Decode

-- Extension -------------------------------------------------------------------
import Comm.Okay
import Comm.SetBattles

import Struct.Event
import Struct.ServerReply

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------
internal_decoder : String -> (Json.Decode.Decoder Struct.ServerReply.Type)
internal_decoder reply_type =
   case reply_type of
      "okay" -> (Comm.Okay.decoder)
      "set_battles" -> (Comm.SetBattles.decoder)
      other ->
         (Json.Decode.fail
            (
               "Unknown server command \""
               ++ other
               ++ "\""
            )
         )

decoder : (Json.Decode.Decoder Struct.ServerReply.Type)
decoder =
   (Json.Decode.field "msg" Json.Decode.string)
   |> (Json.Decode.andThen (internal_decoder))

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
commit : String -> (Cmd Struct.Event.Type)
commit query =
   (Http.send
      Struct.Event.ServerReplied
      (Http.get query (Json.Decode.list (decoder)))
   )
