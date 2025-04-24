//
//  CountryService.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import Foundation

protocol CountryServiceProtocol {
    func fetchCountries() async throws -> [Country]
}

final class CountryService: CountryServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let countriesURL = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCountries() async throws -> [Country] {
        return try await networkService.fetchData(from: countriesURL)
    }
}
