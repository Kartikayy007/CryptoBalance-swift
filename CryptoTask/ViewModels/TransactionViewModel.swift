//
//  TransactionViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    init() {
        loadTransactions()
    }
    
    private func loadTransactions() {
        transactions = [
            Transaction(icon: "bitcoinsign.circle.fill", iconColor: .orange, title: "Receive", date: "20 March", amount: "+0.002126", currency: "BTC"),
            Transaction(icon: "arrow.left.arrow.right", iconColor: .gray, title: "Send", date: "21 March", amount: "-0.001000", currency: "BTC"),
            Transaction(icon: "arrow.left.arrow.right", iconColor: .gray.opacity(0.5), title: "Exchange", date: "22 March", amount: "+0.002126", currency: "BTC"),
            Transaction(icon: "bitcoinsign.circle.fill", iconColor: .orange, title: "Receive", date: "23 March", amount: "+0.005000", currency: "BTC"),
            Transaction(icon: "arrow.left.arrow.right", iconColor: .gray, title: "Send", date: "24 March", amount: "-0.003000", currency: "BTC")
        ]
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.insert(transaction, at: 0)
    }
    
    func getRecentTransactions(limit: Int = 5) -> [Transaction] {
        return Array(transactions.prefix(limit))
    }
    
    func getTransactionCount() -> Int {
        return transactions.count
    }
    
    func getTransactionAmount(for transaction: Transaction) -> String {
        return transaction.amount
    }
    
    func getTransactionColor(for transaction: Transaction) -> Color {
        return transaction.amount.contains("-") ? .red : .green
    }
} 