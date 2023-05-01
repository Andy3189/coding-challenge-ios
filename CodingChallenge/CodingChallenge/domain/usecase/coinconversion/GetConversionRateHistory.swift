//
//  GetConversionRateHistory.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation

protocol GetCoinConversionRateHistory {
    func execute(coinID: String, currency: String) async -> Result<[CoinConversionRate], UseCaseError>
}

struct GetCoinConversionRateHistoryUseCase: GetCoinConversionRateHistory {
    var repository: CoinConversionRateRepository

    func execute(coinID: String, currency: String) async -> Result<[CoinConversionRate], UseCaseError> {
        do {
            return .success(try await repository.getCoinConversionRateHistory(coinID: coinID, currency: currency))
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
