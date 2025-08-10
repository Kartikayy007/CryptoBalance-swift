//
//  PortfolioViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class PortfolioViewModel: ObservableObject {
    @Published var selectedCurrency: String = "cash"
    @Published var portfolioValue: Double = 157342.05
    
    let availableCurrencies = ["cash", "bitcoin"]
    
    func selectCurrency(_ currency: String) {
        selectedCurrency = currency
        updatePortfolioValue()
    }
    
    private func updatePortfolioValue() {
        if selectedCurrency == "cash" {
            portfolioValue = 157342.05
        } else {
            portfolioValue = 0.002126 
        }
    }
    
    func getFormattedPortfolioValue() -> String {
        if selectedCurrency == "cash" {
            return String(format: "%.2f", portfolioValue)
        } else {
            return String(format: "%.6f", portfolioValue)
        }
    }
    
    func getCurrencySymbol() -> String {
        return selectedCurrency == "cash" ? "₹" : "₿"
    }
    
    func getPortfolioTitle() -> String {
        return selectedCurrency == "cash" ? "Portfolio Value" : "Bitcoin Balance"
    }
} 
