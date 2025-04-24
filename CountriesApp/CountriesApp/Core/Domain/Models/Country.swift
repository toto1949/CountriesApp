//
//  Country.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let code: String
    let capital: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case region = "region"
        case code = "code"
        case capital = "capital"
    }
}

extension Country {
    var displayTitle: String {
        return "\(name), \(region)"
    }
    
    func matches(searchText: String) -> Bool {
        let lowercasedSearch = searchText.lowercased()
        return name.lowercased().contains(lowercasedSearch) ||
               capital.lowercased().contains(lowercasedSearch)
    }
}

