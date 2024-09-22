//
//  Untitled.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import UIKit

//MARK: - Contract agreement between module layers
protocol SearchViewProtocol: AnyObject {
    func load(weatherData: WeatherRepresentableData)
    func hideWeatherData()
    func showWeatherData()
    func startLoadig()
    func stopLoadig()
    func showFailureMessage(_ message: String)
    func hideFailureMessage()
}

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad(view: SearchViewProtocol)
    func didChangeSearchText(_ text: String) 
}

protocol SearchInteractorInputProtocol: AnyObject {
    func fetchWeatherData(cityName: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func loadWeatherDataSuccess(_ response: WeatherDataResponse)
    func loadWeatherDataFailure(error: Error)
}

protocol SearchRouterProtocol: AnyObject {
    func pushDetailsView()
}
