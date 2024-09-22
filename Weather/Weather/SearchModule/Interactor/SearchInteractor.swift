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
    private var currentServiceTask: Task<(), Never>?
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        configureSearchTextHandling()
    }
    
    func fetchWeatherData(cityName: String) {
        searchTextPublisher.send(cityName)
    }
    
    private func handleSearchTextPublisher(text: String) {
        self.currentServiceTask?.cancel()
        self.currentServiceTask = Task {
            do {
                let respnse = try await self.weatherService.fetchWeatherData(cityName: text)
                self.output?.loadWeatherDataSuccess(respnse)
            } catch {
                self.output?.loadWeatherDataFailure(error: error)
            }
        }
    }
    
    private func configureSearchTextHandling() {
        searchTextPublisher
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] text in
                guard let self else { return }
                self.handleSearchTextPublisher(text: text)
            }
            .store(in: &cancellables)
    }
}
