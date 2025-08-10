//
//  CurrencyInputView.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI


struct CurrencyInputView: View {
    @Binding var currency: String
    @Binding var amount: String
    var title: String
    var editable: Bool = true
    var isFocused: FocusState<Bool>.Binding?
    
    private let currencies = ["ETH", "BTC", "INR", "USD", "LTC"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            
            HStack(spacing: 16) {
                // Amount Input
                VStack(alignment: .leading, spacing: 4) {
                    TextField("0.00", text: $amount)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .keyboardType(.decimalPad)
                        .disabled(!editable)
                        .focused(isFocused ?? FocusState<Bool>().projectedValue)
                    
                    if !editable {
                        Text("≈ $\(String(format: "%.2f", (Double(amount) ?? 0) * 0.62))")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Currency Selector
                Menu {
                    ForEach(currencies, id: \.self) { curr in
                        Button(curr) {
                            currency = curr
                        }
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(currency)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .medium))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                }
            }
        }
        .padding(20)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}
