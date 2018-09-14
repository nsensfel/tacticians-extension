module Struct.Event exposing (Type(..), attempted)

-- Elm -------------------------------------------------------------------------
import Http

-- Main Menu -------------------------------------------------------------------
import Struct.Error
import Struct.ServerReply

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------
type Type =
   None
   | Failed Struct.Error.Type
   | AddPlayer
   | ShouldRefresh
   | SetUsername String
   | SetID String
   | SetURLPrefix String
   | SetFrequency Int
   | StoreParams
   | ServerReplied (Result Http.Error (List Struct.ServerReply.Type))

attempted : (Result.Result err val) -> Type
attempted act =
   case act of
      (Result.Ok _) -> None
      (Result.Err msg) ->
         (Failed (Struct.Error.new Struct.Error.Failure (toString msg)))
