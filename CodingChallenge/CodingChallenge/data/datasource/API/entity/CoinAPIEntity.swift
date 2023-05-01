//
//  CoinAPIEntity.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

struct CoinAPIEntity: Decodable {
    let id: String
    let symbol: String
    let name: String
}
