//
//  PublisherExtensions.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import Combine

extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(
            receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    result(.failure(error))
                }
            },
            receiveValue: { value in
                result(.success(value))
            }
        )
    }
}
