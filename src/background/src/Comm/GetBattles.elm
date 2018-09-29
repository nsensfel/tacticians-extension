module Comm.GetBattles exposing (request)

-- Elm -------------------------------------------------------------------------

-- Extension -------------------------------------------------------------------
import Comm.Send

import Struct.Event
import Struct.Player

--------------------------------------------------------------------------------
-- TYPES -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
request : Int -> Struct.Player.Type -> (Cmd Struct.Event.Type)
request ix player =
   (Comm.Send.commit
      ix
      (
         (Struct.Player.get_query_url player)
         ++ "/handler/player/plr_get_battles?pid="
         ++ (Struct.Player.get_id player)
      )
   )
