//
//  ExchangeSheetView.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI
import NavKit

struct ExchangeSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ExchangeSheetViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var onExchangeTransactionComplete: (ExchangeTransaction) -> Void
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        HStack {
                            Button("Cancel") {
                                NavigationService.shared.pop()
                                dismiss()
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("Exchange")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button("Reset") {
                                viewModel.resetForm()
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        VStack(spacing: 16) {
                            CurrencyInputView(
                                currency: $viewModel.fromCurrency,
                                amount: $viewModel.fromAmount,
                                title: "From",
                                isFocused: $isTextFieldFocused
                            )
                            
                            Button(action: viewModel.swapCurrencies) {
                                Image(systemName: "arrow.up.arrow.down")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .medium))
                                    .frame(width: 44, height: 44)
                                    .background(
                                        Circle()
                                            .fill(Color.white.opacity(0.15))
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                            )
                                    )
                            }
                            
                            CurrencyInputView(
                                currency: $viewModel.toCurrency,
                                amount: $viewModel.toAmount,
                                title: "To",
                                editable: false
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            Text("Exchange Summary")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 16)
                            
                            VStack(spacing: 12) {
                                SummaryRow(
                                    title: "Rate",
                                    value: viewModel.getRateText()
                                )
                                
                                SummaryRow(
                                    title: viewModel.getSpreadText(),
                                    value: viewModel.getSpreadValue()
                                )
                                
                                SummaryRow(
                                    title: "Network Fee",
                                    value: viewModel.getNetworkFeeText()
                                )
                                
                                Divider()
                                    .background(Color.white.opacity(0.2))
                                    .padding(.vertical, 8)
                                
                                SummaryRow(
                                    title: "You'll Receive",
                                    value: "₹\(viewModel.toAmount)",
                                    bold: true,
                                    valueColor: .green
                                )
                            }
                            .padding(20)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(16)
                            .padding(.horizontal, 20)
                        }
                        
                        Button(action: {
                            viewModel.onExchangeTransactionComplete = onExchangeTransactionComplete
                            viewModel.performExchange()
                        }) {
                            HStack {
                                Text(viewModel.getExchangeButtonText())
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.4, green: 0.3, blue: 0.8),
                                        Color(red: 0.2, green: 0.4, blue: 0.9)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .disabled(viewModel.isExchangeButtonDisabled())
                            .opacity(viewModel.getExchangeButtonOpacity())
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)

        .onChange(of: viewModel.fromAmount) { _ in
            viewModel.calculateConversion()
        }
        .onTapGesture {
            viewModel.isTextFieldFocused = false
        }
    }
    

}
