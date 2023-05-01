//
//  AccessCurrencyCache.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

protocol AccessCurrencyCache {
    func loadCache() -> Result<[String], Error>
    func storeCache(currencies: [String]) -> Result<Bool, Error>
}

struct AccessCurrencyCacheUsecase: AccessCurrencyCache {
    var cache: JsonCache
    func loadCache() -> Result<[String], Error> {
        do {
            return .success(try cache.loadCurrencyCache())
        } catch let error {
            return .failure(error)
        }
    }

    func storeCache(currencies: [String]) -> Result<Bool, Error> {
        do {
            try cache.storeCurrencyCache(currencies: currencies)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}
