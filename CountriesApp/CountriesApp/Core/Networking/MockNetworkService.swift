//
//  MockNetworkService.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import Foundation

final class MockNetworkService: NetworkServiceProtocol {
    let mockedData: Data
    
    init(mockedData: Data) {
        self.mockedData = mockedData
    }
    
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: mockedData)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
