//
//  CoinConversionRateAPIEntity.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation


struct CoinConversionRateAPIEntity: Decodable {
    let id: Date
    let coinID: String
    let currency: String
    let rate: Double

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        if let coinID = container.allKeys.first,
           let rateContainer = try? container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: coinID),
           let currency = rateContainer.allKeys.first {
            self.id = Date()
            self.coinID = coinID.stringValue
            self.currency = currency.stringValue
            self.rate = try rateContainer.decode(Double.self, forKey: currency)
        } else {
            throw NSError(domain: "com.hausding.codingchallenge.api.entity", code: 42)
        }
    }
}
