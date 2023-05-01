//
//  Constants.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

class Constants {
    static let DEFAULTS_COIN_KEY = "com.hausding.coinID"
    static let DEFAULTS_CURRENCY_KEY = "com.hausding.currency"
    static let DEFAULTS_SYNC_DATE_KEY = "com.hausding.sync"

    static let DEFAULT_SELECTED_COIN = "bitcoin"
    static let DEFAULT_SELECTED_CURRENCY = "eur"
    static let DATA_UPDATE_RATE_S: TimeInterval = 10
    static let SYNC_DATE_FORMAT = "Syncdate: %@"
}
