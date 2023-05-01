//
//  JsonCacheImpl.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

struct JsonCacheImpl: JsonCache {
    var dataSource: JsonDataSource

    func storeCoinCache(coins: [String]) throws {
        try dataSource.storeCoinCache(coins: coins)
    }

    func loadCoinCache() throws -> [String] {
        return try dataSource.loadCoinCache()
    }

    func storeCurrencyCache(currencies: [String]) throws {
        try dataSource.storeCurrencyCache(currencies: currencies)
    }

    func loadCurrencyCache() throws -> [String] {
        return try dataSource.loadCurrencyCache()
    }

    func storeCoinConversionRateCache(conversionRates: [CoinConversionRate]) throws {
        try dataSource.storeCoinConversionRateCache(conversionRates: conversionRates)
    }

    func loadCoinConversionRateCache() throws -> [CoinConversionRate] {
        return try dataSource.loadCoinConversionRateCache()
    }

    func clearCoinConversionRateCache() throws {
        try dataSource.clearCoinConversionRateCache()
    }
    
}
