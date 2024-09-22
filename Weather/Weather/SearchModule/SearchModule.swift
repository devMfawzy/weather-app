//
//  SearchModule.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import SwiftUI

public enum SearchModule {
    public static func createModule() -> UIViewController {
        let router = SearchRouter()
        let service = WeatherService()
        let interactor = SearchInteractor(weatherService: service)
        let presenter = SearchPresenter(router: router, interactor: interactor)
        let view = SearchView(presenter: presenter)
        router.view = view
        interactor.output = presenter
        return view
    }
}
