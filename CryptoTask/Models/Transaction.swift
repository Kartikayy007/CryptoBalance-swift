//
//  Transaction.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//


import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let icon: String 
    let iconColor: Color
    let title: String
    let date: String
    let amount: String
    let currency: String
}

struct RecentTransactionsView: View {
    @StateObject private var viewModel = TransactionViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Recent Transactions")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.getRecentTransactions()) { transaction in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(transaction.iconColor)
                                    .frame(width: 40, height: 40)
                                Image(systemName: transaction.icon)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(transaction.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                Text(transaction.date)
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(transaction.currency)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                Text(viewModel.getTransactionAmount(for: transaction))
                                    .foregroundColor(viewModel.getTransactionColor(for: transaction))
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                    }
                }
            }
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
