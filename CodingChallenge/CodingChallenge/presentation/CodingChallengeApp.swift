//
//  CodingChallengeApp.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import SwiftUI

@main
struct CodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(
                    AppContainer(
                        coinRepository: CoinConversionRateRepositoryImpl(dataSource: CoinConversionRateAPIImpl()),
                        jsonCache: JsonCacheImpl(dataSource: CoinConversionCacheImpl())
                    ))
        }
    }
}
