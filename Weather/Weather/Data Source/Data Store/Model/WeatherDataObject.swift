//
//  WeatherDataObject.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import RealmSwift

final class WeatherDataObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var cityName = ""
    @Persisted var forecastList = List<ForecastObject>()
}

extension WeatherDataObject {
    static func weatherDataObject(data: WeatherData) -> WeatherDataObject {
        let object = WeatherDataObject()
        object.cityName = data.city.name
        for forecast in data.forecastItems {
            let forecastObject = ForecastObject()
            forecastObject.dateTimeStamp = forecast.dateTimeStamp
            forecastObject.temperature = forecast.temperature
            forecastObject.minTemperature = forecast.minTemperature
            forecastObject.maxTemperature = forecast.maxTemperature
            forecastObject.humidity = forecast.humidity
            forecastObject.weatherDescription = forecast.weather?.description ?? ""
            forecastObject.iconId = forecast.weather?.iconId ?? ""
            forecastObject.windSpeed = forecast.wind.speed
            object.forecastList.append(forecastObject)
        }
        return object;
    }
}
