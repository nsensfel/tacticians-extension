module Comm.Send exposing (try_sending)

-- Elm -------------------------------------------------------------------------
import Http

import Json.Decode
import Json.Encode

-- Extension -------------------------------------------------------------------
import Comm.Okay

import Struct.Event
import Struct.ServerReply
import Struct.Model

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
try_sending : (
      Struct.Model.Type ->
      String ->
      (Struct.Model.Type -> (Maybe Json.Encode.Value)) ->
      (Maybe (Cmd Struct.Event.Type))
   )
try_sending model recipient try_encoding_fun =
   case (try_encoding_fun model) of
      (Just serial) ->
         (Just
            (Http.send
               Struct.Event.ServerReplied
               (Http.post
                  recipient
                  (Http.jsonBody serial)
                  (Json.Decode.list (decoder))
               )
            )
         )

      Nothing -> Nothing
