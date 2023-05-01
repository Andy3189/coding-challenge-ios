//
//  CoinConversionRateAPIImpl.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation
import Combine

enum APIError: Error {
    case badUrl, requestError, decodingError, unexpectedStatus
}

struct CoinConversionRateAPIImpl: CoinConversionRateDataSource {

    func getCoinConversionRate(coinID: String, currency: String) async throws -> CoinConversionRate {
        guard let urlString = CoinGeckoUrlBuilder(url: CoinConversionAPIConstants.API_URL + CoinConversionAPIConstants.CURRENT_DATA_URL)
            .addParameter("ids", andValue: coinID)
            .addParameter("vs_currencies", andValue: currency)
            .build(),
              let url = URL(string: urlString) else {
            throw APIError.badUrl
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.unexpectedStatus
        }
        guard let result = try? JSONDecoder().decode(CoinConversionRateAPIEntity.self, from: data) else {
            throw APIError.decodingError
        }
        return CoinConversionRate(id: result.id, coinID: result.coinID, currency: result.currency, rate: result.rate)
    }

    func getCoinConversionRateHistory(coinID: String, currency: String) async throws -> [CoinConversionRate] {
        guard let urlString = CoinGeckoUrlBuilder(url: CoinConversionAPIConstants.API_URL + String(format: CoinConversionAPIConstants.HISTORICAL_DATA_URL, coinID))
            .addParameter("vs_currency", andValue: currency)
            .addParameter("days", andValue: CoinConversionAPIConstants.HISTORY_DAYS)
            .addParameter("interval", andValue: CoinConversionAPIConstants.HISTORY_INTERVAL)
            .build(),
              let url = URL(string: urlString) else {
            throw APIError.badUrl
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.unexpectedStatus
        }
        guard let result = try? JSONDecoder().decode(CoinConversionRateHistoryAPIEntity.self, from: data) else {
            throw APIError.decodingError
        }
        return result.prices.map({ item in
            CoinConversionRate(id: item.key, coinID: coinID, currency: currency, rate: item.value)
        })
    }

    func getCurrencies() async throws -> [String] {
        guard let urlString = CoinGeckoUrlBuilder(url: CoinConversionAPIConstants.API_URL + CoinConversionAPIConstants.CURRENCIES_URL).build(),
              let url = URL(string: urlString) else {
            throw APIError.badUrl
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.unexpectedStatus
        }
        guard let result = try? JSONDecoder().decode([String].self, from: data) else {
            throw APIError.decodingError
        }
        return result
    }

    func getCoins() async throws -> [String] {
        guard let urlString = CoinGeckoUrlBuilder(url: CoinConversionAPIConstants.API_URL + CoinConversionAPIConstants.COINS_URL).build(),
              let url = URL(string: urlString) else {
            throw APIError.badUrl
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.requestError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.unexpectedStatus
        }
        guard let result = try? JSONDecoder().decode([CoinAPIEntity].self, from: data) else {
            throw APIError.decodingError
        }
        return result.map({ $0.id })
    }
}
