module View.DialogQuantity exposing (..)

import Material.Color as Color
import Material.Button as Button
import Material.Dialog as Dialog
import Material.Options as Options exposing (cs, css)

import Html exposing (..)

import Model exposing (..)
import Constants.Colors exposing (..)
import Constants.DefaultSettings exposing (..)
import View.ButtonQuantity exposing (viewCounter)



viewDialogQuantity : Model -> Html Msg
viewDialogQuantity model =
    Options.div []
        [ dialog model
        , Button.render Mdl [5] model.mdl
            [ defaultBtnElevation
            , Dialog.openOn "click"
            ]
            [ text "Dialog" ]
        ]


dialog : Model -> Html Msg
dialog model =
    Dialog.view
        [ cs "dialog-quantity__view" ]
        [ Dialog.title [ cs "dialog-quantity__title"]
            [ text "Select Quantity" ]
        , Dialog.content [ cs "dialog-quantity__content" ]
            [ viewCounter model ]
        , Dialog.actions [ cs "dialog-quantity__actions" ]
            [ Button.render Mdl [0] model.mdl
                [ defaultBtnElevation
                , Color.background defaultBtnBgColor
                , Color.text defaultBtnTextColor
                , Dialog.closeOn "click" ]
                [ text "Done" ]
            ]
        ]
