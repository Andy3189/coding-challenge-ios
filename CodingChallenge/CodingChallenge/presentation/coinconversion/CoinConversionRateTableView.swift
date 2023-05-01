//
//  CoinConversionTable.swift
//  CodingChallenge
//
//  Created by Anders Hausding on 30.04.23.
//

import Foundation
import SwiftUI

struct CoinConversionRateTableView: View {
    @StateObject var viewModel: CoinConversionRateTableViewModel
    private let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        Form {
            Section(header: Text("Selected Conversion Rate")) {
                HStack {
                    Picker("Coin", selection: $viewModel.selectedCoin) {
                        ForEach(viewModel.coins, id: \.self) { coin in
                            Text(coin).tag(coin)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Picker("Currency", selection: $viewModel.selectedCurrency) {
                        ForEach(viewModel.currencies, id:\.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .redacted(reason: viewModel.isLoadingCurrencies ? .placeholder : [])
            }
            Section(header: Text(viewModel.lastSyncDate)) {
                LazyVGrid(columns: gridLayout) {
                    Text("Date")
                    .foregroundColor(.accentColor)
                    .unredacted()
                    Text("Rate")
                    .foregroundColor(.accentColor)
                    .unredacted()
                    Divider()
                    Divider()
                    if viewModel.isLoadingConversions {
                        ForEach((1...14), id: \.self) { rate in
                            CoinConversionRateTableRow(
                                date: "01.01.1970 00:00:00",
                                rate: "42,000.00"
                            )
                        }
                        .redacted(reason: .placeholder)
                    } else {
                        ForEach(viewModel.conversionRates) { rate in
                            CoinConversionRateTableRow(
                                date: rate.id.defaultFormat(),
                                rate: String(format: "%.2f", rate.rate)
                            )
                        }
                    }

                }
                .redacted(reason: viewModel.isLoadingConversions ? .placeholder : [])
            }
        }
        .onChange(of: viewModel.selectedCoin) { _ in
            viewModel.reloadData()
        }
        .onChange(of: viewModel.selectedCurrency) { _ in
            viewModel.reloadData()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}


struct CoinConversionRateTableRow: View {
    var date: String
    var rate: String
    var body: some View {
        Text(date)
        Text(rate)
        Divider()
        Divider()
    }
}
