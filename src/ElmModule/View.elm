module ElmModule.View exposing (view)

-- Elm -------------------------------------------------------------------------
import Html
import Html.Attributes

-- Shared ----------------------------------------------------------------------
import Util.Html

-- Main Menu -------------------------------------------------------------------
import Struct.Error
import Struct.Event
import Struct.Model
import Struct.Player

import View.BattleListing
--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
view : Struct.Model.Type -> (Html.Html Struct.Event.Type)
view model =
   (Html.div
      [
         (Html.Attributes.class "fullscreen-module")
      ]
      [
         (Html.main_
            [
            ]
            [
               (View.BattleListing.get_html
                  "Campaigns"
                  "main-menu-campaigns"
                  (Struct.Player.get_campaigns model.player)
               ),
               (View.BattleListing.get_html
                  "Invasions"
                  "main-menu-invasions"
                  (Struct.Player.get_invasions model.player)
               ),
               (View.BattleListing.get_html
                  "Events"
                  "main-menu-events"
                  (Struct.Player.get_events model.player)
               )
            ]
         ),
         (
            case model.error of
               Nothing -> (Util.Html.nothing)
               (Just err) ->
                  (Html.div
                     []
                     [
                        (Html.text (Struct.Error.to_string err))
                     ]
                  )
         )
      ]
   )
