module Ui.Styles exposing (..)

{-| This module contains the styles for all components.

@docs embed, embedSome, embedDefault, embedAuto, styles
-}

import Css.Properties exposing (..)
import Css exposing (..)

import Html

import Ui.Styles.Theme exposing (Theme, default)

import Ui.Styles.ButtonGroup as ButtonGroup
import Ui.Styles.Container as Container
import Ui.Styles.Calendar as Calendar
import Ui.Styles.Checkbox as Checkbox
import Ui.Styles.Textarea as Textarea
import Ui.Styles.Button as Button
import Ui.Styles.Input as Input

import Native.Uid

{-|-}
styles : Theme -> List (String, Node)
styles theme =
  [ ("ui-button-group", ButtonGroup.style theme )
  , ("ui-calendar", Calendar.style theme )
  , ("ui-button", Button.style theme )
  , ("ui-container", Container.style )
  ]

{-| Renders the styles for the given components into a HTML tag.
-}
embedSome : List Node -> Html.Html msg
embedSome nodes =
  Css.embed nodes


{-| Renders the stylesheet with the default theme into an HTML tag.
-}
embedDefault : Html.Html msg
embedDefault =
  embed default


{-|-}
embedAuto : Html.Html msg -> Html.Html msg
embedAuto input =
  let
    tags =
      Native.Uid.getTags input

    filteredStyles =
      List.filterMap
        (\(tag, style) ->
          if List.member tag tags then
            Just style
          else
            Nothing
        )
        (styles default)
  in
    embedSome filteredStyles


{-| Renders the stylesheet with the given theme into an HTML tag.
-}
embed : Theme -> Html.Html msg
embed theme =
  Css.embed
    [ ButtonGroup.style theme
    , Calendar.style theme
    , Textarea.style theme
    , Checkbox.style theme
    , Button.style theme
    , Input.style theme
    , Container.style
    ]
