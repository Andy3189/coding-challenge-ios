//
//  GetCurrencies.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

protocol GetCurrencies {
    func execute() async -> Result<[String], UseCaseError>
}

struct GetCurrenciesUseCase: GetCurrencies {
    var repository: CoinConversionRateRepository

    func execute() async -> Result<[String], UseCaseError> {
        do {
            return .success(try await repository.getCurrencies())
        } catch let error {
            switch error {
            case APIError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
