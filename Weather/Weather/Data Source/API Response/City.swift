//
//  City.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct City: Decodable {
    let name: String
    let countryCode: String?
    
    init(name: String = "", countryCode: String? = nil) {
        self.name = name
        self.countryCode = countryCode
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case countryCode = "country"
    }
}
