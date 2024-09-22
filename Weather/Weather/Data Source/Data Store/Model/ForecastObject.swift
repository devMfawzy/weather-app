//
//  ForecastObject.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import RealmSwift

final class ForecastObject: Object {
    @Persisted var dateTimeStamp = 0
    @Persisted var temperature = 0.0
    @Persisted var minTemperature = 0.0
    @Persisted var maxTemperature = 0.0
    @Persisted var humidity = 0
    @Persisted var weatherDescription = ""
    @Persisted var iconId = ""
    @Persisted var windSpeed = 0.0
}
