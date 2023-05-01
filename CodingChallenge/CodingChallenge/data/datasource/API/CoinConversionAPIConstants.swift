//
//  CoinConversionAPIConstants.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation

class CoinConversionAPIConstants {
    static let API_URL = "https://api.coingecko.com/api/v3"
    static let COINS_URL = "/coins/list"
    static let CURRENT_DATA_URL = "/simple/price"
    static let CURRENCIES_URL = "/simple/supported_vs_currencies"
    static let HISTORICAL_DATA_URL = "/coins/%@/market_chart"
    static let HISTORY_DAYS = "14"
    static let HISTORY_INTERVAL = "daily"
}
