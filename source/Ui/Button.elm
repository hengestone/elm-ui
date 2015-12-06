module Ui.Button where

{-| Basic button component with disabled state and different types.

# Model
@docs Model, init

# View
@docs view

# Functions
@docs attributes
-}
import Html.Extra exposing (onTouch, onEnter)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)
import Html exposing (node, text)

import Ui

{-| Representation of a button. -}
type alias Model =
  { disabled: Bool
  , text: String
  , kind: String
  }

{-| Initializes a button. -}
init : Model
init =
  { disabled = False
  , text = ""
  , kind = "primary"
  }

{-| Renders a button.

    view address { disabled = False
                 , text = "Button"
                 , kind = "Primary"
                 }
-}
view : Signal.Address a -> a -> Model -> Html.Html
view address action model =
  node "ui-button"
    (attributes address model action)
    [node "span" [] [text model.text]]

{-| Creates the attributes for a button. -}
attributes : Signal.Address a
           -> { b | disabled : Bool, kind : String }
           -> a
           -> List Html.Attribute
attributes address model action =
  [ classList
    [ ("disabled", model.disabled)
    , ("ui-button-" ++ model.kind, True)
    ]
    , onClick address action
    , onEnter False address action
  ] ++ Ui.tabIndex model