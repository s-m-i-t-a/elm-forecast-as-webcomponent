module Components.CardForecast exposing (currentDayForecast, dropZero, mapColorIcon, mapWeatherIcon, weeklyForecast)

import Model exposing (..)
import String
    exposing
        ( dropLeft
        , dropRight
        , left
        , toInt
        , toLower
        )


mapWeatherIcon : String -> String
mapWeatherIcon str =
    "wi wi-yahoo-" ++ str


mapColorIcon : String -> String
mapColorIcon str =
    let
        sun =
            [ "32", "34" ]

        rain =
            [ "5", "6", "7", "12", "18", "35" ]

        storm =
            [ "1", "3", "4", "37", "38", "39", "45", "47" ]
    in
    if List.member str sun then
        "item-icon--sun"

    else if List.member str rain then
        "item-icon--rain"

    else if List.member str storm then
        "item-icon--storm"

    else
        "item-icon--cloud"


dropZero : String -> String
dropZero str =
    let
        firstDigit =
            left 1 str
    in
    if firstDigit == "0" then
        dropLeft 1 str

    else
        str


currentDayForecast : Model -> String -> String
currentDayForecast model str =
    let
        day =
            List.head model.forecast
    in
    case str of
        "code" ->
            case day of
                Just day ->
                    day.code

                Nothing ->
                    "Unknown"

        "date" ->
            case day of
                Just day ->
                    dropZero <| day.date

                Nothing ->
                    "Unknown"

        "day" ->
            case day of
                Just day ->
                    day.day

                Nothing ->
                    "Unknown"

        "high" ->
            case day of
                Just day ->
                    day.high ++ "°"

                Nothing ->
                    "--"

        "low" ->
            case day of
                Just day ->
                    day.low ++ "°"

                Nothing ->
                    "--"

        "text" ->
            case day of
                Just day ->
                    toLower <| day.text

                Nothing ->
                    "Unknown"

        _ ->
            ""


weeklyForecast : Model -> List ( Int, String, String, String, String, Float, Float )
weeklyForecast model =
    let
        weekly =
            List.tail model.forecast

        listWeeklyForecast =
            case weekly of
                Just weekly ->
                    weekly

                Nothing ->
                    []

        getDailyData =
            \dayId x ->
                ( dayId + 1
                , x.day
                , x.date
                , mapWeatherIcon x.code
                , mapColorIcon x.code
                , Result.withDefault 1000 (String.toFloat x.high)
                , Result.withDefault -1000 (String.toFloat x.low)
                )
    in
    List.indexedMap getDailyData listWeeklyForecast
