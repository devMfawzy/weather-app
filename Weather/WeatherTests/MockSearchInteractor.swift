//
//  MockSearchInteractor.swift
//  WeatherTests
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

@testable import Weather
import Foundation

final class MockSearchInteractor: SearchInteractorInputProtocol {
    weak var output: SearchInteractorOutputProtocol?
    private var result = Result.data
    private let error = ErrorResponse(message: "error", representable: true)
    
    func getWeatherData(cityName: String) {
        switch result {
        case .error:
            output?.didGetFailure(error: error)
        case .data:
            output?.didLoadCurrentForecastData(ForecastItem(), city: City())
        case .loading:
            break
        }
    }
    
    func expect(_ result: Result) {
        self.result = result
    }
    
    enum Result {
        case error
        case data
        case loading
    }
}
