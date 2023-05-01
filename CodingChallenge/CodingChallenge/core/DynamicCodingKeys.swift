//
//  DynamicCodingKeys.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation
struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}
