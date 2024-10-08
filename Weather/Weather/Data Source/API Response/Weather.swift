//
//  Weather.swift
//  Weather
//
//  Created by Mohamed Fawzy on 21/09/2024.
//

import Foundation

struct Weather: Decodable {
    let description: String
    let iconId: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconId = "icon"
    }
    
    init(description: String, iconId: String) {
        self.description = description
        self.iconId = iconId
    }
}

extension Weather {
    var iconURL: URL? {
        let urlString = "\(Constants.iconBaseURL)\(iconId).png"
        return URL(string: urlString)
    }
}
