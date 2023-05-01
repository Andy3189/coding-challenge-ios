//
//  CoinConversionTableViewModel.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import SwiftUI
import Combine
class CoinConversionRateTableViewModel: ObservableObject {

    @Published var conversionRates: [CoinConversionRate] = []
    @Published var coins: [String] = []
    @Published var currencies: [String] = []
    @Published var isLoadingCurrencies = true
    @Published var isLoadingConversions = true
    @Published var lastSyncDate = String(format: Constants.SYNC_DATE_FORMAT, ISO8601DateFormatter().date(from: UserDefaults.standard.string(forKey: Constants.DEFAULTS_SYNC_DATE_KEY) ?? "")?.defaultFormat() ?? "Never")
    @Published var selectedCoin = UserDefaults.standard.string(forKey: Constants.DEFAULTS_COIN_KEY) ?? Constants.DEFAULT_SELECTED_COIN
    @Published var selectedCurrency = UserDefaults.standard.string(forKey: Constants.DEFAULTS_CURRENCY_KEY) ?? Constants.DEFAULT_SELECTED_CURRENCY

    private var getConversionRateUseCase: GetCoinConversionRate
    private var getConversionRateHistoryUseCase: GetCoinConversionRateHistory
    private var getCoinsUseCase: GetCoins
    private var getCurrenciesUseCase: GetCurrencies
    private var accessCoinCache: AccessCoinCache
    private var accessCurrencyCache: AccessCurrencyCache
    private var accessConversionRateCache: AccessConversionRateCache
    private var timer: Timer?
    private var activeConversionRateTask: Task<Any, Error>?

    init(getConversionRateUseCase: GetCoinConversionRate, getConversionRateHistoryUseCase: GetCoinConversionRateHistory, getCoinsUseCase: GetCoins, getCurrenciesUseCase: GetCurrencies, accessCoinCacheUseCase: AccessCoinCache, accessCurrencyUseCase: AccessCurrencyCache, accessConversionRateCacheUseCase: AccessConversionRateCache) {
        self.getConversionRateUseCase = getConversionRateUseCase
        self.getConversionRateHistoryUseCase = getConversionRateHistoryUseCase
        self.getCoinsUseCase = getCoinsUseCase
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.accessCoinCache = accessCoinCacheUseCase
        self.accessCurrencyCache = accessCurrencyUseCase
        self.accessConversionRateCache = accessConversionRateCacheUseCase
        self.coins = [selectedCoin]
        self.currencies = [selectedCurrency]
        DispatchQueue.main.async {
            Task(priority: .medium) {
                await self.loadInitialData()
            }
        }
    }

    func onAppear() {
        if conversionRates.isEmpty {
            Task(priority: .medium) {
                await self.retrieveConversionRateHistory()
            }
        } else {
            startTimer()
        }
    }

    func onDisappear() {
        stopTimer()
    }

    func loadInitialData() async {
        switch accessCoinCache.loadCache() {
        case .success(let coins):
            DispatchQueue.main.async { [weak self] in
                self?.coins = coins
            }
        case .failure(_):
            switch await getCoinsUseCase.execute() {
            case .success(let coins):
                DispatchQueue.main.async { [weak self] in
                    self?.coins = coins
                    _ = self?.accessCoinCache.storeCache(coins: coins) // Could handle cache error
                }
            case .failure(_):
                //Couldnt load cache nor download coin ids here
                return
            }
        }
        switch accessCurrencyCache.loadCache() {
        case .success(let currencies):
            DispatchQueue.main.async { [weak self] in
                self?.currencies = currencies
            }
        case .failure(_):
            switch await getCurrenciesUseCase.execute() {
            case .success(let currencies):
                DispatchQueue.main.async { [weak self] in
                    self?.coins = currencies
                    _ = self?.accessCurrencyCache.storeCache(currencies: currencies) // Could handle cache error
                }
            case .failure(_):
                //Couldnt load cache nor download currencies here
                return
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingCurrencies = false
        }
        switch accessConversionRateCache.loadCache() {
        case .success(let conversionRates):
            DispatchQueue.main.async { [weak self] in
                self?.conversionRates = conversionRates
                self?.isLoadingConversions = false
            }
        case .failure(_):
            //Couldnt load cache here
            break
        }

    }

    private func retrieveCurrentConversionRate() async {
        let result = await getConversionRateUseCase.execute(coinID: selectedCoin, currency: selectedCurrency)
        if Task.isCancelled {
            return
        }
        switch result {
        case .success(let conversionRate):
            let syncDate = Date()
            DispatchQueue.main.async { [weak self] in
                if self?.conversionRates.isEmpty == true {
                    self?.conversionRates.append(conversionRate)
                } else {
                    self?.conversionRates[0] = conversionRate
                }
                self?.lastSyncDate = String(format: Constants.SYNC_DATE_FORMAT, syncDate.defaultFormat())
                UserDefaults.standard.set(ISO8601DateFormatter().string(from: syncDate), forKey: Constants.DEFAULTS_SYNC_DATE_KEY)
                if let conversionRates = self?.conversionRates {
                    _ = self?.accessConversionRateCache.storeCache(conversionRates: conversionRates) // Could handle cache error
                }
            }
        case .failure(_):
            //Retrieving current conversion rate failed here
            break
        }
    }

    private func retrieveConversionRateHistory() async {
        switch await getConversionRateHistoryUseCase.execute(coinID: selectedCoin, currency: selectedCurrency) {
        case .success(let conversionRates):
            let syncDate = Date()
            DispatchQueue.main.async { [weak self] in
                self?.conversionRates = conversionRates.sorted(by: {$0.id > $1.id})
                self?.lastSyncDate = String(format: Constants.SYNC_DATE_FORMAT, syncDate.defaultFormat())
                UserDefaults.standard.set(ISO8601DateFormatter().string(from: syncDate), forKey: Constants.DEFAULTS_SYNC_DATE_KEY)
                self?.isLoadingConversions = false
                self?.startTimer()
            }
        case .failure(_):
            //Retrieving historical data failed here
            break
        }
    }

    func reloadData() {
        UserDefaults.standard.set(selectedCoin, forKey: Constants.DEFAULTS_COIN_KEY)
        UserDefaults.standard.set(selectedCurrency, forKey: Constants.DEFAULTS_CURRENCY_KEY)
        UserDefaults.standard.removeObject(forKey: Constants.DEFAULTS_SYNC_DATE_KEY)
        stopTimer()
        lastSyncDate = String(format: Constants.SYNC_DATE_FORMAT, "Never")
        conversionRates = []
        _ = try? accessConversionRateCache.clearCache() // Could handle errors deleting the cache
        isLoadingConversions = true
        Task(priority: .medium) {
            await self.retrieveConversionRateHistory()
        }
    }

    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: Constants.DATA_UPDATE_RATE_S, repeats: true) { _ in
            self.activeConversionRateTask = Task(priority: .medium) {
                await self.retrieveCurrentConversionRate()
            }
        }
        self.timer?.fire()
    }

    private func stopTimer() {
        activeConversionRateTask?.cancel()
        activeConversionRateTask = nil
        timer?.invalidate()
        timer = nil
    }
}
