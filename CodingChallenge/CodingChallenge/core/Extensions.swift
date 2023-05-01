//
//  Extensions.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

extension Date {

    func defaultFormat() -> String {
        return self.formatted(date: .numeric, time: .standard)
    }
}

extension UserDefaults {

    func containsKey(key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
