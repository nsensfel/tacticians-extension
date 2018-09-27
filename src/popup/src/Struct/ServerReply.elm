module Struct.ServerReply exposing (Type(..))

-- Elm -------------------------------------------------------------------------

-- -------------------------------------------------------------------
import Struct.BattleSummary

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------

type Type =
   Okay
   | SetID String
   | SetUsername String
   | SetBattles
      (
         (List Struct.BattleSummary.Type),
         (List Struct.BattleSummary.Type),
         (List Struct.BattleSummary.Type)
      )

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
