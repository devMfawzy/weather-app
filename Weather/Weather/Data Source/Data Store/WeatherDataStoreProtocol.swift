//
//  WeatherDataStoreProtocol.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import Foundation

protocol WeatherDataStoreProtocol {
    func addWeather(object: WeatherDataObject)
    func getWeatherObject(cityName: String, completion: @escaping (Result<WeatherDataObject, Error>) -> Void)
}
