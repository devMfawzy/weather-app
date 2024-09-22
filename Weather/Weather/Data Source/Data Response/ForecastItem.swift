//
//  ForecastItem.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct ForecastItem: Decodable {
    let dateTimeStamp: Int
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    var weather: Weather?
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case dateTimeStamp = "dt"
        case main
        case weather
        case wind
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<ForecastItem.CodingKeys> = try decoder.container(keyedBy: ForecastItem.CodingKeys.self)
        self.dateTimeStamp = try container.decode(Int.self, forKey: ForecastItem.CodingKeys.dateTimeStamp)
        let main = try container.decode(MainWeatherData.self, forKey: ForecastItem.CodingKeys.main)
        temperature = main.temperature
        minTemperature = main.minTemperature
        maxTemperature = main.maxTemperature
        humidity = main.humidity
        let weatherList = try container.decodeIfPresent([Weather].self, forKey: ForecastItem.CodingKeys.weather)
        self.weather = weatherList?.first
        self.wind = try container.decode(Wind.self, forKey: ForecastItem.CodingKeys.wind)
    }
}
