//
//  AppContainer.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

class AppContainer: ObservableObject {
    var getConversionRateUseCase: GetCoinConversionRateUseCase
    var getConversionRateHistoryUseCase: GetCoinConversionRateHistory
    var getCoinsUseCase: GetCoins
    var getCurrenciesUseCase: GetCurrencies
    var accessCoinCache: AccessCoinCache
    var accessCurrencyCache: AccessCurrencyCache
    var accessConversionRateCache: AccessConversionRateCache

    init(coinRepository: CoinConversionRateRepository, jsonCache: JsonCache) {
        getConversionRateUseCase = GetCoinConversionRateUseCase(repository: coinRepository)
        getConversionRateHistoryUseCase = GetCoinConversionRateHistoryUseCase(repository: coinRepository)
        getCoinsUseCase = GetCoinsRateUseCase(repository: coinRepository)
        getCurrenciesUseCase = GetCurrenciesUseCase(repository: coinRepository)
        accessCoinCache = AccessCoinCacheUsecase(cache: jsonCache)
        accessCurrencyCache = AccessCurrencyCacheUsecase(cache: jsonCache)
        accessConversionRateCache = AccessConversionRateCacheUsecase(cache: jsonCache)
    }
}
