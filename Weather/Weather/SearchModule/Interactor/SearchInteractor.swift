//
//  SearchInteractor.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation
import Combine

class SearchInteractor: SearchInteractorInputProtocol {
    weak var output: SearchInteractorOutputProtocol?
    private var weatherService: WeatherServiceProtocol
    private var weatherDataStore: WeatherDataStoreProtocol
    private var currentServiceTask: Task<(), Never>?
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    init(weatherService: WeatherServiceProtocol, weatherDataStore: WeatherDataStoreProtocol) {
        self.weatherService = weatherService
        self.weatherDataStore = weatherDataStore
        configureSearchTextHandling()
    }
    
    func fetchWeatherData(cityName: String) {
        weatherDataStore.getWeatherObject(cityName: cityName) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let object):
                let weatherData = WeatherData(object: object)
                self.handleWeatherData(weatherData)
            case .failure:
                self.searchTextPublisher.send(cityName)
            }
        }
    }
    
    private func handleSearchTextPublisher(text: String) {
        self.currentServiceTask?.cancel()
        self.currentServiceTask = Task {
            do {
                let weatherData = try await self.weatherService.fetchWeatherData(cityName: text)
                self.handleWeatherData(weatherData)
                weatherDataStore.addWeather(object: weatherData.storeObject)
            } catch {
                self.output?.didGetFailure(error: error)
            }
        }
    }
    
    private func handleWeatherData(_ data: WeatherData) {
        if let currentForecastItem = data.currentForecastItem {
            self.output?.didLoadCurrentForecastData(currentForecastItem, city: data.city)
        } else {
            self.output?.didGetFailure(error: ErrorResponse(message: "No forecast data."))
        }
    }
    
    private func configureSearchTextHandling() {
        searchTextPublisher
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self else { return }
                self.handleSearchTextPublisher(text: text)
            }
            .store(in: &cancellables)
    }
}
