//
//  JsonCacheImpl.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 01.05.23.
//

import Foundation

class JsonCacheHelper {
    static let STORAGE_PATH = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    static func storeJson<T: Encodable>(filename: String, data: [T]) throws {
        let fileManager = FileManager.default
        let jsonFilepath = STORAGE_PATH.appendingPathComponent(filename)
        let jsonObject = try JSONEncoder().encode(data)
        if fileManager.fileExists(atPath: jsonFilepath.path) {
            fileManager.createFile(atPath: jsonFilepath.path, contents: jsonObject)
        } else {
            let jsonString = NSString(data: jsonObject, encoding: String.Encoding.utf8.rawValue)! as String
            try jsonString.write(to: jsonFilepath, atomically: true, encoding: .utf8)
        }
    }

    static func loadJson<T: Decodable>(filename: String) throws -> [T] {
        let fileManager = FileManager.default
        let jsonFilepath = STORAGE_PATH.appendingPathComponent(filename)
        return try JSONDecoder().decode([T].self, from: Data(contentsOf: jsonFilepath, options: []))
    }

    static func deleteJson(filename: String) throws {
        let fileManager = FileManager.default
        let jsonFilepath = STORAGE_PATH.appendingPathComponent(filename)
        try fileManager.removeItem(at: jsonFilepath)
    }
}
