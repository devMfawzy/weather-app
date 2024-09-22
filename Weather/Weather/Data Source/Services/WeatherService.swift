//
//  WeatherDataSource.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    private let session = URLSession.shared
    
    func fetchWeatherData(cityName: String) async throws -> WeatherData {
        guard let urlRequest = fetchWeatherRequest(cityName: cityName) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await session.data(for: urlRequest)
        let decoder = JSONDecoder()
        if let response = response as? HTTPURLResponse, response.statusCode == 200  {
            do {
                return try decoder.decode(WeatherData.self, from: data)
            } catch {
                throw URLError(.cannotDecodeContentData)
            }
        } else {
            do {
                throw try decoder.decode(ErrorResponse.self, from: data)
            } catch {
                throw error
            }
        }
    }
}

extension WeatherService {
    func fetchWeatherRequest(cityName: String) -> URLRequest? {
        guard let cityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        var urlComponents = URLComponents(string: Constants.searchEndpointBaseURL)
        var queryItems = [URLQueryItem]()
        [URLQueryItem(name: "q", value: cityName),
         URLQueryItem(name: "units", value: "metric"),
         URLQueryItem(name: "appid", value: Constants.appID)]
            .forEach { queryItem in
                queryItems.append(queryItem)
            }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}
