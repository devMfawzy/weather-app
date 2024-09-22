//
//  WeatherRepresentableData.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct WeatherRepresentableData {
    private(set) var temperature: String?
    private(set) var minTemperature: String?
    private(set) var maxTemperature: String?
    private(set) var cityName: String?
    private(set) var humidity: String?
    private(set) var windSpeed: String?
    private(set) var weatherDescription: String?
    private(set) var weatherIcon: URL?
    
    private let numberFormatter = NumberFormatter()

    init(forecastItem: ForecastItem, city: City) {
        temperature = "\(Int(forecastItem.temperature))°"
        minTemperature = "L:\(Int(forecastItem.minTemperature))°"
        maxTemperature = "H:\(Int(forecastItem.maxTemperature))°"
        cityName = city.name
        numberFormatter.numberStyle = .percent
        humidity = numberFormatter.string(for: Double(forecastItem.humidity) / 100 )
        let windSpeedStr = Int(forecastItem.wind.speed * 3.6)
        windSpeed = "\(windSpeedStr) km/h"
        weatherDescription = forecastItem.weather?.description
        weatherIcon = forecastItem.weather?.iconURL
    }
}
