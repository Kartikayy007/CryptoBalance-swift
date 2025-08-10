//
//  ExchangeViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class ExchangeViewModel: ObservableObject {
    @Published var transactions: [ExchangeTransaction] = []
    @Published var balance: Double = 157342.05
    @Published var changeAmount: Double = 1342.0
    @Published var changePercentage: Double = 4.6
    
    init() {
        loadInitialTransactions()
    }
    
    private func loadInitialTransactions() {
        transactions = [
            ExchangeTransaction(
                type: .receive,
                title: "Receive",
                date: "20 March",
                currency: "BTC",
                amount: "+0.002126"
            ),
            ExchangeTransaction(
                type: .send,
                title: "Sent",
                date: "19 March",
                currency: "ETH",
                amount: "-0.003126"
            ),
            ExchangeTransaction(
                type: .send,
                title: "Send",
                date: "18 March",
                currency: "LTC",
                amount: "-0.02126"
            )
        ]
    }
    
    func addTransaction(_ transaction: ExchangeTransaction) {
        transactions.insert(transaction, at: 0)
        updateBalance(for: transaction)
    }
    
    private func updateBalance(for transaction: ExchangeTransaction) {
        if transaction.type == .receive {
            balance += 1000 // Simulate receiving money
            changeAmount += 50
        } else {
            balance -= 500 // Simulate sending money
            changeAmount -= 25
        }
        
        // Update percentage
        changePercentage = (changeAmount / (balance - changeAmount)) * 100
    }
    
    func getFormattedBalance() -> String {
        return String(format: "%.2f", balance)
    }
    
    func getFormattedChangeAmount() -> String {
        return String(format: "%.0f", changeAmount)
    }
    
    func getFormattedChangePercentage() -> String {
        return String(format: "+%.1f%%", changePercentage)
    }
} 
