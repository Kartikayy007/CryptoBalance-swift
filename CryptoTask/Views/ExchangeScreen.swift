//
//  ExchangeScreen.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI



import NavKit

struct ExchangeScreen: View {
    @StateObject private var viewModel = ExchangeViewModel()
    
    var body: some View {
        
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        
                        VStack(spacing: 12) {
                            Text("INR")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                            
                            Text(viewModel.getFormattedBalance())
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 12) {
                                Text("₹\(viewModel.getFormattedChangeAmount())")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.system(size: 16))
                                
                                Text(viewModel.getFormattedChangePercentage())
                                    .foregroundColor(.green)
                                    .font(.system(size: 16, weight: .medium))
                            }
                        }
                        .padding(.vertical, 32)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.4, green: 0.3, blue: 0.8),
                                    Color(red: 0.2, green: 0.4, blue: 0.9)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(24)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack(spacing: 20) {
                            ActionButton(icon: "arrow.up", action: {})
                            
                            Button(action: {
                                NavigationService.shared.push(
                                    ExchangeSheetView { newExchangeTransaction in
                                        viewModel.addTransaction(newExchangeTransaction)
                                    }
                                )
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .frame(width: 50, height: 50)
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(Circle())
                            }


                            ActionButton(icon: "arrow.down", action: {})
                        }
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("ExchangeTransactions")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("Last 4 days")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 32)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.transactions) { transaction in
                                    ExchangeTransactionRow(
                                        type: transaction.type,
                                        title: transaction.title,
                                        date: transaction.date,
                                        currency: transaction.currency,
                                        amount: transaction.amount
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 32)
                        }
                    }
                }
            }
        
    }
}


struct ExchangeScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeScreen()
    }
}
