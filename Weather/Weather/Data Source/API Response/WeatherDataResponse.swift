//
//  WeatherDataResponse.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct WeatherDataResponse: Decodable {
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

extension WeatherDataResponse {
    var currentForecastItem: ForecastItem? {
        forecastItems.first
    }
}
