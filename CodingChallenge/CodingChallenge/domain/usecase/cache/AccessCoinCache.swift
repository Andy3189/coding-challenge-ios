//
//  AccessCoinCache.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

protocol AccessCoinCache {
    func loadCache() -> Result<[String], Error>
    func storeCache(coins: [String]) -> Result<Bool, Error>
}

struct AccessCoinCacheUsecase: AccessCoinCache {
    var cache: JsonCache
    func loadCache() -> Result<[String], Error> {
        do {
            return .success(try cache.loadCoinCache())
        } catch let error {
            return .failure(error)
        }
    }

    func storeCache(coins: [String]) -> Result<Bool, Error> {
        do {
            try cache.storeCoinCache(coins: coins)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}
