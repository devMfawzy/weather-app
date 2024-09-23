//
//  SearchViewSpy.swift
//  WeatherTests
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

@testable import Weather

final class SearchViewSpy: SearchViewProtocol {
    private(set) var isWeatherDataHidded = true
    private(set) var isFailureMessageHidden = true
    private(set) var isLoadingData = false
    private(set) var weatherData: WeatherRepresentableData?
    
    func load(weatherData: WeatherRepresentableData) {
        self.weatherData = weatherData
    }
    
    func hideWeatherData() {
        isWeatherDataHidded = true
    }
    
    func showWeatherData() {
        isWeatherDataHidded = false
    }
    
    func startLoadig() {
        isLoadingData = true
    }
    
    func stopLoadig() {
        isLoadingData = false
    }
    
    func showFailureMessage(_ message: String) {
        isFailureMessageHidden = false
    }
    
    func hideFailureMessage() {
        isFailureMessageHidden = true
    }
}
