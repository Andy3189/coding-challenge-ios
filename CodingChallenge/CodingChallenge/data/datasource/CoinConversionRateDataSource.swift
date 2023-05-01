//
//  CoinConversionRateDataSource.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation

protocol CoinConversionRateDataSource {
    func getCoinConversionRate(coinID: String, currency: String) async throws -> CoinConversionRate
    func getCoinConversionRateHistory(coinID: String, currency: String) async throws -> [CoinConversionRate]
    func getCurrencies() async throws -> [String]
    func getCoins() async throws -> [String]
}
