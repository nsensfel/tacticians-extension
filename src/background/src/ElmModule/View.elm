module ElmModule.View exposing (view)

-- Elm -------------------------------------------------------------------------

-- Extension -------------------------------------------------------------------
import Util.Html

import Struct.Event
import Struct.Model

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
view : Struct.Model.Type -> (Html.Html Struct.Event.Type)
view model = (Util.Html.nothing)
