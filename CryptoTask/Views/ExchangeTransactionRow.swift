//
//  ExchangeTransactionRow.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI

struct ExchangeTransactionRow: View {
    let type: ExchangeTransaction.ExchangeTransactionType
    let title: String
    let date: String
    let currency: String
    let amount: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: type == .receive ? "arrow.down" : "arrow.up")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 40, height: 40)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Text(date)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(currency)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                Text(amount)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}
