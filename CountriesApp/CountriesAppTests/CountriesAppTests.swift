//
//  CountriesAppTests.swift
//  CountriesAppTests
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//


import XCTest
@testable import CountriesApp

final class NetworkServiceTests: XCTestCase {
    func testFetchDataSuccess() async {
        let jsonData = """
        [
            {
                "name": "France",
                "region": "Europe",
                "code": "FR",
                "capital": "Paris"
            },
            {
                "name": "Japan",
                "region": "Asia",
                "code": "JP",
                "capital": "Tokyo"
            }
        ]
        """.data(using: .utf8)!
        
        let mockService = MockNetworkService(mockedData: jsonData)

        do {
            let countries: [Country] = try await mockService.fetchData(from: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")
            
            XCTAssertEqual(countries.count, 2)
            XCTAssertEqual(countries[0].name, "France")
            XCTAssertEqual(countries[0].region, "Europe")
            XCTAssertEqual(countries[0].code, "FR")
            XCTAssertEqual(countries[0].capital, "Paris")

            XCTAssertEqual(countries[1].name, "Japan")
            XCTAssertEqual(countries[1].region, "Asia")
            XCTAssertEqual(countries[1].code, "JP")
            XCTAssertEqual(countries[1].capital, "Tokyo")
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
    
    func testFetchDataDecodingError() async {
        let invalidJsonData = "Invalid JSON".data(using: .utf8)!
        let mockService = MockNetworkService(mockedData: invalidJsonData)
        
        do {
            let _: [Country] = try await mockService.fetchData(from: "https://example.com")
            XCTFail("Should throw an error")
        } catch let error as NetworkError {
            if case .decodingFailed = error {
            } else {
                XCTFail("Wrong error type: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

import XCTest
import Combine
@testable import CountriesApp

final class CountriesListViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testFetchCountriesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch countries success")
        let mockCountries = [
            Country(name: "France", region: "Europe", code: "FR", capital: "Paris"),
            Country(name: "Japan", region: "Asia", code: "JP", capital: "Tokyo")
        ]
        
        let mockService = MockCountryService(countries: mockCountries)
        let viewModel = CountriesListViewModel(countryService: mockService)
        
        var states: [ViewState] = []
        
        viewModel.statePublisher
            .sink { state in
                states.append(state)
                if state == .loaded {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchCountries()
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(states, [.idle, .loading, .loaded])
        XCTAssertEqual(viewModel.countries.count, 2)
        XCTAssertEqual(viewModel.filteredCountries.count, 2)
        XCTAssertEqual(viewModel.countries[0].name, "France")
        XCTAssertEqual(viewModel.countries[1].name, "Japan")
    }
    
    func testFilterCountries() {
        let mockCountries = [
            Country(name: "United States", region: "NA", code: "US", capital: "Washington"),
            Country(name: "Canada", region: "NA", code: "CA", capital: "Ottawa"),
            Country(name: "Brazil", region: "SA", code: "BR", capital: "Brasília")
        ]
        
        let mockService = MockCountryService(countries: mockCountries)
        let viewModel = CountriesListViewModel(countryService: mockService)
        
        let expectation = XCTestExpectation(description: "Fetch countries")
        viewModel.statePublisher
            .sink { state in
                if state == .loaded {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchCountries()
        wait(for: [expectation], timeout: 1.0)
        
        viewModel.searchText = "united"
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries[0].name, "United States")
        
        viewModel.searchText = "ottawa"
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries[0].capital, "Ottawa")
        
        viewModel.searchText = "xyz"
        XCTAssertEqual(viewModel.filteredCountries.count, 0)
        
        viewModel.searchText = ""
        XCTAssertEqual(viewModel.filteredCountries.count, 3)
    }
}

class MockCountryService: CountryServiceProtocol {
    private let countries: [Country]
    private let error: Error?
    
    init(countries: [Country], error: Error? = nil) {
        self.countries = countries
        self.error = error
    }
    
    func fetchCountries() async throws -> [Country] {
        if let error = error {
            throw error
        }
        return countries
    }
}
