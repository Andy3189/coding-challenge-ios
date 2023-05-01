//
//  CoinConversionCacheImpl.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

struct CoinConversionCacheImpl: JsonDataSource {
    func storeCoinCache(coins: [String]) throws {
        try JsonCacheHelper.storeJson(filename: JsonCacheConstants.COINS_JSON_FILE, data: coins)
    }

    func loadCoinCache() throws -> [String] {
        return try JsonCacheHelper.loadJson(filename: JsonCacheConstants.COINS_JSON_FILE)
    }

    func storeCurrencyCache(currencies: [String]) throws {
        try JsonCacheHelper.storeJson(filename: JsonCacheConstants.CURRENCIES_JSON_FILE, data: currencies)
    }

    func loadCurrencyCache() throws -> [String] {
        return try JsonCacheHelper.loadJson(filename: JsonCacheConstants.CURRENCIES_JSON_FILE)
    }

    func storeCoinConversionRateCache(conversionRates: [CoinConversionRate]) throws {
        try JsonCacheHelper.storeJson(filename: JsonCacheConstants.CONVERSION_RATE_JSON_FILE, data: conversionRates)
    }

    func loadCoinConversionRateCache() throws -> [CoinConversionRate] {
        return try JsonCacheHelper.loadJson(filename: JsonCacheConstants.CONVERSION_RATE_JSON_FILE)
    }
    
    func clearCoinConversionRateCache() throws {
        try JsonCacheHelper.deleteJson(filename: JsonCacheConstants.CONVERSION_RATE_JSON_FILE)
    }
}
