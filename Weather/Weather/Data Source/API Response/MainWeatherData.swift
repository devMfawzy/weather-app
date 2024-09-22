//
//  MainWeatherData.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct MainWeatherData: Decodable {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}
