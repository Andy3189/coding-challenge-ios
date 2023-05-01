//
//  AccessConversionRateCache.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

protocol AccessConversionRateCache {
    func loadCache() -> Result<[CoinConversionRate], Error>
    func storeCache(conversionRates: [CoinConversionRate]) -> Result<Bool, Error>
    func clearCache() throws -> Result<Bool, Error>
}

struct AccessConversionRateCacheUsecase: AccessConversionRateCache {
    var cache: JsonCache
    func loadCache() -> Result<[CoinConversionRate], Error> {
        do {
            return .success(try cache.loadCoinConversionRateCache())
        } catch let error {
            return .failure(error)
        }
    }

    func storeCache(conversionRates: [CoinConversionRate]) -> Result<Bool, Error> {
        do {
            try cache.storeCoinConversionRateCache(conversionRates: conversionRates)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }

    func clearCache() throws -> Result<Bool, Error>{
        do {
            try cache.clearCoinConversionRateCache()
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}
