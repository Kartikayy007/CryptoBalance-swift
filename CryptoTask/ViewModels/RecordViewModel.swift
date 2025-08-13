//
//  RecordViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class RecordViewModel: ObservableObject {
    @Published var selectedCategory: TransactionCategory = .income
    @Published var amount: String = ""
    @Published var description: String = ""
    @Published var selectedDate: Date = Date()
    @Published var selectedCurrency: String = "BTC"
    @Published var selectedPaymentMethod: PaymentMethod = .crypto
    @Published var showDatePicker: Bool = false
    @Published var showSuccessAnimation: Bool = false
    @Published var recentRecords: [RecordEntry] = []
    @Published var categoryStats: [CategoryStat] = []
    
    enum TransactionCategory: String, CaseIterable {
        case income = "Income"
        case expense = "Expense"
        case transfer = "Transfer"
        case exchange = "Exchange"
        case mining = "Mining"
        case staking = "Staking"
        
        var icon: String {
            switch self {
            case .income: return "arrow.down.circle.fill"
            case .expense: return "arrow.up.circle.fill"
            case .transfer: return "arrow.left.arrow.right.circle.fill"
            case .exchange: return "arrow.triangle.2.circlepath.circle.fill"
            case .mining: return "hammer.circle.fill"
            case .staking: return "chart.line.uptrend.xyaxis.circle.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .income: return Color(red: 0.3, green: 0.43, blue: 0.96)
            case .expense: return .red
            case .transfer: return Color(red: 0.21, green: 0.31, blue: 0.78)
            case .exchange: return .purple
            case .mining: return .orange
            case .staking: return Color(red: 0.4, green: 0.5, blue: 0.9)
            }
        }
    }
    
    enum PaymentMethod: String, CaseIterable {
        case crypto = "Crypto"
        case bank = "Bank"
        case card = "Card"
        case cash = "Cash"
        
        var icon: String {
            switch self {
            case .crypto: return "bitcoinsign.circle"
            case .bank: return "building.columns"
            case .card: return "creditcard"
            case .cash: return "indianrupeesign.circle"
            }
        }
    }
    
    struct RecordEntry: Identifiable {
        let id = UUID()
        let category: TransactionCategory
        let amount: String
        let currency: String
        let description: String
        let date: Date
        let paymentMethod: PaymentMethod
    }
    
    struct CategoryStat: Identifiable {
        let id = UUID()
        let category: TransactionCategory
        let total: Double
        let count: Int
        let percentage: Double
    }
    
    init() {
        loadRecentRecords()
        calculateCategoryStats()
    }
    
    private func loadRecentRecords() {
        recentRecords = [
            RecordEntry(category: .income, amount: "0.0050", currency: "BTC", description: "Client Payment", date: Date().addingTimeInterval(-86400), paymentMethod: .crypto),
            RecordEntry(category: .expense, amount: "15000", currency: "INR", description: "Trading Fee", date: Date().addingTimeInterval(-172800), paymentMethod: .bank),
            RecordEntry(category: .mining, amount: "0.0002", currency: "BTC", description: "Mining Rewards", date: Date().addingTimeInterval(-259200), paymentMethod: .crypto),
            RecordEntry(category: .exchange, amount: "0.0100", currency: "BTC", description: "BTC to ETH", date: Date().addingTimeInterval(-345600), paymentMethod: .crypto),
            RecordEntry(category: .staking, amount: "0.0003", currency: "BTC", description: "Staking Rewards", date: Date().addingTimeInterval(-432000), paymentMethod: .crypto)
        ]
    }
    
    private func calculateCategoryStats() {
        let totalTransactions = Double(recentRecords.count)
        var categoryGroups: [TransactionCategory: (count: Int, total: Double)] = [:]
        
        for record in recentRecords {
            let amount = Double(record.amount) ?? 0
            if let existing = categoryGroups[record.category] {
                categoryGroups[record.category] = (existing.count + 1, existing.total + amount)
            } else {
                categoryGroups[record.category] = (1, amount)
            }
        }
        
        categoryStats = categoryGroups.map { category, data in
            CategoryStat(
                category: category,
                total: data.total,
                count: data.count,
                percentage: (Double(data.count) / totalTransactions) * 100
            )
        }.sorted { $0.total > $1.total }
    }
    
    func saveRecord() {
        guard !amount.isEmpty else { return }
        
        let newRecord = RecordEntry(
            category: selectedCategory,
            amount: amount,
            currency: selectedCurrency,
            description: description.isEmpty ? selectedCategory.rawValue : description,
            date: selectedDate,
            paymentMethod: selectedPaymentMethod
        )
        
        recentRecords.insert(newRecord, at: 0)
        calculateCategoryStats()
        
        showSuccessAnimation = true
        resetForm()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showSuccessAnimation = false
        }
    }
    
    func resetForm() {
        amount = ""
        description = ""
        selectedDate = Date()
        selectedCategory = .income
        selectedPaymentMethod = .crypto
    }
    
    func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func getQuickAmounts() -> [String] {
        if selectedCurrency == "BTC" {
            return ["0.001", "0.005", "0.01", "0.05", "0.1"]
        } else {
            return ["1000", "5000", "10000", "50000", "100000"]
        }
    }
    
    func getTotalBalance() -> (btc: Double, inr: Double) {
        var btcTotal: Double = 0
        var inrTotal: Double = 0
        
        for record in recentRecords {
            let amount = Double(record.amount) ?? 0
            if record.currency == "BTC" {
                btcTotal += record.category == .expense ? -amount : amount
            } else {
                inrTotal += record.category == .expense ? -amount : amount
            }
        }
        
        return (btcTotal, inrTotal)
    }
}