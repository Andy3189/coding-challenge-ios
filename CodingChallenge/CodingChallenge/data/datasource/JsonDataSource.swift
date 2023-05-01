//
//  JsonDataSource.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

protocol JsonDataSource {
    func storeCoinCache(coins: [String]) throws
    func loadCoinCache() throws -> [String]
    func storeCurrencyCache(currencies: [String]) throws
    func loadCurrencyCache() throws -> [String]
    func storeCoinConversionRateCache(conversionRates: [CoinConversionRate]) throws
    func loadCoinConversionRateCache() throws -> [CoinConversionRate]
    func clearCoinConversionRateCache() throws
}
