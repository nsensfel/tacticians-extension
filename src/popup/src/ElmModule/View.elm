module ElmModule.View exposing (view)

-- Elm -------------------------------------------------------------------------
import Array

import Html
import Html.Events
import Html.Attributes

-- Extension -------------------------------------------------------------------
import Util.Html

import Struct.Error
import Struct.Event
import Struct.Model

import View.Player
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
         ),
         (Html.div
            [
            ]
            (List.map (View.Player.get_html) (Array.toList model.players))
         ),
         (Html.div
            [
            ]
            [
               (Html.button
                  [
                     (Html.Events.onClick Struct.Event.AddPlayer)
                  ]
                  [
                     (Html.text "Add Player")
                  ]
               ),
               (Html.button
                  [
                     (Html.Events.onClick Struct.Event.StoreParams)
                  ]
                  [
                     (Html.text "Save Params")
                  ]
               )
            ]
         )
      ]
   )
