//
//  SearchPresenterProtocol.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

class SearchPresenter {
    private weak var view: SearchViewProtocol?
    private var interactor: SearchInteractorInputProtocol?
    private var router: SearchRouterProtocol?
    
    init(router: SearchRouterProtocol, interactor: SearchInteractorInputProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad(view: any SearchViewProtocol) {
        self.view = view
    }
    
    func didChangeSearchText(_ text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.view?.hideFailureMessage()
            self.view?.hideWeatherData()
            self.view?.startLoadig()
        }
        interactor?.fetchWeatherData(cityName: text)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func didLoadCurrentForecastData(_ forecastItem: ForecastItem, city: City) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.stopLoadig()
        }
        let weatherRepresentableData = WeatherRepresentableData(
            forecastItem: forecastItem, city: city)
        DispatchQueue.main.async { [weak self] in
            self?.view?.load(weatherData: weatherRepresentableData)
            self?.view?.showWeatherData()
        }
    }
    
    func didGetFailure(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.view?.hideWeatherData()
            self.view?.stopLoadig()
            if let error = error as? URLError {
                self.view?.showFailureMessage(error.localizedDescription)
            }
        }
    }
}
