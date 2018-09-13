module View.Player exposing (get_html)

-- Elm -------------------------------------------------------------------------
import Html
import Html.Attributes
-- import Html.Events

-- Extension -------------------------------------------------------------------
import Struct.BattleSummary
import Struct.Event
import Struct.Player

--------------------------------------------------------------------------------
-- LOCAL -----------------------------------------------------------------------
--------------------------------------------------------------------------------
get_item_html : (
      String ->
      String ->
      Struct.BattleSummary.Type ->
      (Html.Html Struct.Event.Type)
   )
get_item_html url_prefix additional_class item =
   (Html.a
      [
         (Html.Attributes.class additional_class),
         (Html.Attributes.href
            (
               url_prefix
               ++ (Struct.BattleSummary.get_id item)
            )
         )
      ]
      [
         (Html.div
            [
               (Html.Attributes.class "battle-summary-name")
            ]
            [
               (Html.text (Struct.BattleSummary.get_name item))
            ]
         ),
         (Html.div
            [
               (Html.Attributes.class "battle-summary-date")
            ]
            [
               (Html.text (Struct.BattleSummary.get_last_edit item))
            ]
         )
      ]
   )

--------------------------------------------------------------------------------
-- EXPORTED --------------------------------------------------------------------
--------------------------------------------------------------------------------
get_html : Struct.Player.Type -> (Html.Html Struct.Event.Type)
get_html player =
   let
      url_prefix = (Struct.Player.get_url_prefix player)
   in
      (Html.div
         [
            (Html.Attributes.class "player-summary")
         ]
         [
            (Html.div
               [
                  (Html.Attributes.class "player-summary-listing-header")
               ]
               [
                  (Html.text (Struct.Player.get_username player))
               ]
            ),
            (Html.div
               [
                  (Html.Attributes.class "player-summary-listing-body")
               ]
               (
                  (List.map
                     (get_item_html url_prefix "campaign-link")
                     (Struct.Player.get_campaigns player)
                  )
                  ++
                  (List.map
                     (get_item_html url_prefix "invasion-link")
                     (Struct.Player.get_invasions player)
                  )
                  ++
                  (List.map
                     (get_item_html url_prefix "event-link")
                     (Struct.Player.get_events player)
                  )
               )
            )
         ]
      )
