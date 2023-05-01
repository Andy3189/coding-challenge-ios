//
//  CoinConversionRateHistoryRepository.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation

struct CoinConversionRateRepositoryImpl: CoinConversionRateRepository {
    var dataSource: CoinConversionRateDataSource

    func getCoinConversionRate(coinID: String, currency: String) async throws -> CoinConversionRate {
        return try await dataSource.getCoinConversionRate(coinID: coinID, currency: currency)
    }

    func getCoinConversionRateHistory(coinID: String, currency: String) async throws -> [CoinConversionRate] {
        return try await dataSource.getCoinConversionRateHistory(coinID: coinID, currency: currency)
    }

    func getCoins() async throws -> [String] {
        return try await dataSource.getCoins()
    }

    func getCurrencies() async throws -> [String] {
        return try await dataSource.getCurrencies()
    }

}
