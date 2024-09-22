//
//  WeatherDataStore.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import RealmSwift

final class WeatherDataStore: WeatherDataStoreProtocol {
    func addWeather(object: WeatherDataObject) {
        guard let realm = try? Realm() else { return }
        try? realm.write { realm.add(object) }
    }
    
    func getWeatherObject(cityName: String, completion: @escaping (Result<WeatherDataObject, any Error>) -> Void) {
        guard let realm = try? Realm() else {
            completion(.failure(WeatherDataError.noWeatherData))
            return
        }
        guard let object = realm.object(ofType: WeatherDataObject.self, forPrimaryKey: cityName) else {
            completion(.failure(WeatherDataError.noWeatherData))
            return
        }
        completion(.success(object))
    }
}
