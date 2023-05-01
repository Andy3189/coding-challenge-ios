//
//  CoinConversionRate.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation

struct CoinConversionRate: Identifiable, Codable {
    let id: Date
    let coinID: String
    let currency: String
    let rate: Double

    enum CodingKeys: CodingKey {
        case id
        case coinID
        case currency
        case rate
    }
    
    init(id: Date, coinID: String, currency: String, rate: Double) {
        self.id = id
        self.coinID = coinID
        self.currency = currency
        self.rate = rate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .id)
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded date doesnt match ISO8601"))
        }
        self.id = date
        self.coinID = try container.decode(String.self, forKey: .coinID)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.rate = try container.decode(Double.self, forKey: .rate)
    }


    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ISO8601DateFormatter().string(from: self.id), forKey: .id)
        try container.encode(self.coinID, forKey: .coinID)
        try container.encode(self.currency, forKey: .currency)
        try container.encode(self.rate, forKey: .rate)
    }
}
