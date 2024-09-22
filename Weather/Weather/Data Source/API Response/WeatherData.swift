//
//  WeatherData.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct WeatherData: Decodable {
    let forecastItems: [ForecastItem]
    let city: City
    
    init(forecastItems: [ForecastItem] = [], city: City = City()) {
        self.forecastItems = forecastItems
        self.city = city
    }
    
    enum CodingKeys: String, CodingKey {
        case forecastItems = "list"
        case city
    }
}

extension WeatherData {
    var currentForecastItem: ForecastItem? {
        forecastItems.first
    }
}

extension WeatherData {
    init(object: WeatherDataObject) {
        var forecastItems = [ForecastItem]()
        for forecastObject in object.forecastList {
            let item = ForecastItem(
                dateTimeStamp: forecastObject.dateTimeStamp,
                temperature: forecastObject.temperature,
                minTemperature: forecastObject.minTemperature,
                maxTemperature: forecastObject.maxTemperature,
                humidity: forecastObject.humidity,
                weather: Weather(description: forecastObject.weatherDescription,
                                 iconId: forecastObject.iconId),
                wind: Wind(speed: forecastObject.windSpeed))
            forecastItems.append(item)
        }
        self.forecastItems = forecastItems
        self.city = City(name: object.cityName)
    }
}

extension WeatherData {
    var storeObject: WeatherDataObject {
        let object = WeatherDataObject()
        object.cityName = city.name
        for item in forecastItems {
            let forecastObject = ForecastObject()
            forecastObject.dateTimeStamp = item.dateTimeStamp
            forecastObject.temperature = item.temperature
            forecastObject.minTemperature = item.minTemperature
            forecastObject.maxTemperature = item.maxTemperature
            forecastObject.humidity = item.humidity
            forecastObject.weatherDescription = item.weather?.description ?? ""
            forecastObject.iconId = item.weather?.iconId ?? ""
            forecastObject.windSpeed = item.wind.speed
            object.forecastList.append(forecastObject)
        }
        return object;
    }
}
