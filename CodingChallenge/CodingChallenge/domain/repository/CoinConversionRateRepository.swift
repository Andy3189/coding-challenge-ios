//
//  CoinConversionRateRepository.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation
import Combine

protocol CoinConversionRateRepository {
    func getCoinConversionRate(coinID: String, currency: String) async throws -> CoinConversionRate
    func getCoinConversionRateHistory(coinID: String, currency: String) async throws -> [CoinConversionRate]
    func getCoins() async throws -> [String]
    func getCurrencies() async throws -> [String]
}
