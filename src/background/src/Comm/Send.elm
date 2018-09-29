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
internal_decoder : (
      Int ->
      String ->
      (Json.Decode.Decoder Struct.ServerReply.Type)
   )
internal_decoder ix reply_type =
   case reply_type of
      "okay" -> (Comm.Okay.decoder)
      "set_battles" -> (Comm.SetBattles.decoder ix)
      other ->
         (Json.Decode.fail
            (
               "Unknown server command \""
               ++ other
               ++ "\""
            )
         )

decoder : Int -> (Json.Decode.Decoder Struct.ServerReply.Type)
decoder ix =
   (Json.Decode.field "msg" Json.Decode.string)
   |> (Json.Decode.andThen (internal_decoder ix))

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
commit : Int -> String -> (Cmd Struct.Event.Type)
commit ix query =
   (Http.send
      Struct.Event.ServerReplied
      (Http.get query (Json.Decode.list (decoder ix)))
   )
