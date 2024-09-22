//
//  ErrorResponse.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import Foundation

struct ErrorResponse: Error , Decodable {
    let message: String
    
    var localizedDescription: String {
        message
    }
}
