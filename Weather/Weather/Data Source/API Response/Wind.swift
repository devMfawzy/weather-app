//
//  Wind.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct Wind: Decodable {
    let speed: Double
    
    init(speed: Double = 0) {
        self.speed = speed
    }
}
