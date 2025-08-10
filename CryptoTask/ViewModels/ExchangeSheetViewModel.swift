//
//  ExchangeSheetViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI
import NavKit

class ExchangeSheetViewModel: ObservableObject {
    @Published var fromCurrency: String = "ETH"
    @Published var toCurrency: String = "INR"
    @Published var fromAmount: String = ""
    @Published var toAmount: String = "0.00"
    @Published var isTextFieldFocused: Bool = false
    
    private let conversionRate: Double = 157342.05
    private let spread: Double = 0.002
    private let gasFee: Double = 120.0
    
    var onExchangeTransactionComplete: ((ExchangeTransaction) -> Void)?
    
    func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
        calculateConversion()
    }
    
    func calculateConversion() {
        if let amount = Double(fromAmount), amount > 0 {
            let converted = amount * conversionRate * (1 - spread) - gasFee
            toAmount = String(format: "%.2f", max(0, converted))
        } else {
            toAmount = "0.00"
        }
    }
    
    func resetForm() {
        fromAmount = ""
        toAmount = "0.00"
    }
    
    func performExchange() {
        guard let amount = Double(fromAmount), amount > 0 else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let currentDate = formatter.string(from: Date())
        
        let transactionType: ExchangeTransaction.ExchangeTransactionType = toCurrency == "INR" ? .send : .receive
        let transactionTitle = toCurrency == "INR" ? "Sold" : "Bought"
        let transactionAmount = transactionType == .receive ? "+\(fromAmount)" : "-\(fromAmount)"
        
        let newExchangeTransaction = ExchangeTransaction(
            type: transactionType,
            title: transactionTitle,
            date: currentDate,
            currency: fromCurrency,
            amount: transactionAmount
        )
        
        onExchangeTransactionComplete?(newExchangeTransaction)
        
        print("Exchange executed: \(fromAmount) \(fromCurrency) to \(toAmount) \(toCurrency)")
        DispatchQueue.main.async {
            NavigationService.shared.pop()
        }
        
    }
    
    func getRateText() -> String {
        return "1 \(fromCurrency) = ₹\(String(format: "%.2f", conversionRate))"
    }
    
    func getSpreadText() -> String {
        return "Spread (\(String(format: "%.1f", spread * 100))%)"
    }
    
    func getSpreadValue() -> String {
        let amount = Double(fromAmount) ?? 0
        return "₹\(String(format: "%.2f", amount * conversionRate * spread))"
    }
    
    func getNetworkFeeText() -> String {
        return "₹\(String(format: "%.0f", gasFee))"
    }
    
    func getExchangeButtonText() -> String {
        return "Exchange \(fromAmount.isEmpty ? "0" : fromAmount) \(fromCurrency)"
    }
    
    func isExchangeButtonDisabled() -> Bool {
        return fromAmount.isEmpty || Double(fromAmount) == 0
    }
    
    func getExchangeButtonOpacity() -> Double {
        return isExchangeButtonDisabled() ? 0.5 : 1.0
    }
} 
