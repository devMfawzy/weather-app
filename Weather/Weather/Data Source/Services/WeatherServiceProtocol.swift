//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData(cityName: String) async throws -> WeatherDataResponse
}
