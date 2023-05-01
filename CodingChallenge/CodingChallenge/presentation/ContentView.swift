//
//  ContentView.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appContainer: AppContainer
    
    var body: some View {
        CoinConversionRateTableView(
            viewModel: CoinConversionRateTableViewModel(
                getConversionRateUseCase: appContainer.getConversionRateUseCase,
                getConversionRateHistoryUseCase: appContainer.getConversionRateHistoryUseCase,
                getCoinsUseCase: appContainer.getCoinsUseCase,
                getCurrenciesUseCase: appContainer.getCurrenciesUseCase,
                accessCoinCacheUseCase: appContainer.accessCoinCache,
                accessCurrencyUseCase: appContainer.accessCurrencyCache,
                accessConversionRateCacheUseCase: appContainer.accessConversionRateCache
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
