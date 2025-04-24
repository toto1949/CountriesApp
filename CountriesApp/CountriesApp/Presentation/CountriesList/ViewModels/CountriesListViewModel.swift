//
//  CountriesListViewModel.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import Foundation
import Combine

protocol CountriesListViewModelProtocol: AnyObject {
    var countries: [Country] { get }
    var filteredCountries: [Country] { get }
    var searchText: String { get set }
    var statePublisher: AnyPublisher<ViewState, Never> { get }
    
    func fetchCountries()
}

enum ViewState: Equatable {
    case idle
    case loading
    case loaded
    case error(String)
}

final class CountriesListViewModel: CountriesListViewModelProtocol {
    
    private let countryService: CountryServiceProtocol
    private var stateSubject = CurrentValueSubject<ViewState, Never>(.idle)
    
    private(set) var countries: [Country] = []
    private(set) var filteredCountries: [Country] = []
    
    var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    
    var statePublisher: AnyPublisher<ViewState, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    
    init(countryService: CountryServiceProtocol) {
        self.countryService = countryService
    }
    
    
    func fetchCountries() {
        stateSubject.send(.loading)
        
        Task {
            do {
                let fetchedCountries = try await countryService.fetchCountries()
                
                await MainActor.run {
                    self.countries = fetchedCountries
                    self.filterCountries()
                    self.stateSubject.send(.loaded)
                }
            } catch {
                await MainActor.run {
                    self.stateSubject.send(.error(error.localizedDescription))
                }
            }
        }
    }
    
    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.matches(searchText: searchText) }
        }
    }
}
