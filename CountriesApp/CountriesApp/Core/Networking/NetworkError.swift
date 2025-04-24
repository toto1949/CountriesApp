//
//  NetworkError.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case noData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        }
    }
}
