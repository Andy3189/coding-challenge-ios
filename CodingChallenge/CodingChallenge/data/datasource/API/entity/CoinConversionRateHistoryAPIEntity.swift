//
//  CoinConversionRateHistoryAPIEntity.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

struct CoinConversionRateHistoryAPIEntity: Codable {
    let prices: [Date: Double]

    enum CodingKeys: CodingKey {
        case prices
    }

    init(from decoder: Decoder) throws {
        var decodedPrices: [Date: Double] = [:]
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var conversionData = try container.nestedUnkeyedContainer(forKey: .prices)
        while !conversionData.isAtEnd {
            var conversionDataItem = try conversionData.nestedUnkeyedContainer()
            let timestamp = (try conversionDataItem.decode(TimeInterval.self)) / 1000
            let rate = try conversionDataItem.decode(Double.self)
            decodedPrices[Date(timeIntervalSince1970: timestamp)] = rate
        }
        self.prices = decodedPrices
    }
}
