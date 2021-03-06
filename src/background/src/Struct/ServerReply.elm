module Struct.ServerReply exposing (Type(..))

-- Elm -------------------------------------------------------------------------

-- -------------------------------------------------------------------
import Struct.BattleSummary

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------

type Type =
   Okay
   | SetBattles
      (
         Int,
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
