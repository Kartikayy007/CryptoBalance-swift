//
//  ContentView.swift
//  CryptoTask
//
//  Created by Kartikay singh on 05/08/25.
//
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @Namespace private var animation

    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                if viewModel.selectedTab == "Analytics" {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 20) {
                            PortfolioHeaderCard()
                            TimeRangeSelector(selectedRange: $viewModel.selectedRange)
                            ChartView(selectedRange: $viewModel.selectedRange)
                            CryptoCardRow()
                            RecentTransactionsView()
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 120)
                    }
                }
                else if viewModel.selectedTab == "Exchange" {
                        ExchangeScreen()
                            .padding(.bottom, 120)
                    
                    
                }
                else if viewModel.selectedTab == "Record" {
                    Text("Record Screen")
                        .foregroundColor(.white)
                }
                else if viewModel.selectedTab == "Wallet" {
                    Text("Wallet Screen")
                        .foregroundColor(.white)
                }

                Spacer(minLength: 0)
            }
            
            VStack {
                Spacer()
                BottomNavBar(selectedTab: $viewModel.selectedTab, animation: animation)
            }
        }
    }
}


#Preview {
    MainView()
}

