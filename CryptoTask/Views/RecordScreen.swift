//
//  RecordScreen.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI
import NavKit

struct RecordScreen: View {
    @StateObject private var viewModel = RecordViewModel()
    @State private var selectedTab = 0
    
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
                        
                        Text("Record")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "chart.pie")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 16) {
                            Text("Quick Record")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(RecordViewModel.TransactionCategory.allCases, id: \.self) { category in
                                        CategoryButton(
                                            category: category,
                                            isSelected: viewModel.selectedCategory == category
                                        ) {
                                            withAnimation(.spring()) {
                                                viewModel.selectedCategory = category
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Text(viewModel.getCurrencySymbol())
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(viewModel.selectedCategory.color)
                                    
                                    TextField("0.00", text: $viewModel.amount)
                                        .font(.system(size: 36, weight: .bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                }
                                .padding()
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(16)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(viewModel.getQuickAmounts(), id: \.self) { amount in
                                            QuickAmountButton(amount: amount) {
                                                withAnimation {
                                                    viewModel.amount = amount
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 4)
                                }
                                
                                HStack(spacing: 12) {
                                    ForEach(["BTC", "INR"], id: \.self) { currency in
                                        CurrencyToggle(
                                            currency: currency,
                                            isSelected: viewModel.selectedCurrency == currency
                                        ) {
                                            withAnimation {
                                                viewModel.selectedCurrency = currency
                                            }
                                        }
                                    }
                                }
                            }
                            
                            TextField("Add description (optional)", text: $viewModel.description)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(12)
                            
                            HStack(spacing: 12) {
                                ForEach(RecordViewModel.PaymentMethod.allCases, id: \.self) { method in
                                    PaymentMethodButton(
                                        method: method,
                                        isSelected: viewModel.selectedPaymentMethod == method
                                    ) {
                                        withAnimation {
                                            viewModel.selectedPaymentMethod = method
                                        }
                                    }
                                }
                            }
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    viewModel.saveRecord()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Save Record")
                                        .fontWeight(.semibold)
                                }
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.3, green: 0.43, blue: 0.96),
                                            Color(red: 0.21, green: 0.31, blue: 0.78)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(16)
                            }
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.white.opacity(0.03))
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.white.opacity(0.2),
                                                    Color.white.opacity(0.05)
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 1
                                        )
                                )
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Category Statistics")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("This Month")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.categoryStats) { stat in
                                        CategoryStatCard(stat: stat)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Recent Records")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Text("See All")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 0.3, green: 0.43, blue: 0.96))
                                }
                            }
                            
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.recentRecords) { record in
                                    RecordRow(record: record)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 100)
                    }
                }
            }
            
            if viewModel.showSuccessAnimation {
                VStack {
                    Spacer()
                    
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(red: 0.3, green: 0.43, blue: 0.96))
                        
                        Text("Record Saved Successfully")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(red: 0.3, green: 0.43, blue: 0.96).opacity(0.2))
                    .cornerRadius(12)
                    .padding(.bottom, 100)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

struct CategoryButton: View {
    let category: RecordViewModel.TransactionCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .black : category.color)
                
                Text(category.rawValue)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .black : .white)
            }
            .frame(width: 80, height: 80)
            .background(
                isSelected ? category.color : Color.white.opacity(0.1)
            )
            .cornerRadius(16)
        }
    }
}

struct QuickAmountButton: View {
    let amount: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(amount)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.1))
                .cornerRadius(8)
        }
    }
}

struct CurrencyToggle: View {
    let currency: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(currency)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isSelected ? .black : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    isSelected ? Color.white : Color.white.opacity(0.1)
                )
                .cornerRadius(12)
        }
    }
}

struct PaymentMethodButton: View {
    let method: RecordViewModel.PaymentMethod
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: method.icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .black : .white)
                
                Text(method.rawValue)
                    .font(.system(size: 10))
                    .foregroundColor(isSelected ? .black : .white.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                isSelected ? Color.white : Color.white.opacity(0.05)
            )
            .cornerRadius(12)
        }
    }
}

struct CategoryStatCard: View {
    let stat: RecordViewModel.CategoryStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: stat.category.icon)
                    .font(.system(size: 20))
                    .foregroundColor(stat.category.color)
                
                Spacer()
                
                Text("\(Int(stat.percentage))%")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Text(stat.category.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
            
            Text("₹\(Int(stat.total))")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            
            Text("\(stat.count) transactions")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(16)
        .frame(width: 150)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    stat.category.color.opacity(0.3),
                    stat.category.color.opacity(0.1)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
    }
}

struct RecordRow: View {
    let record: RecordViewModel.RecordEntry
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: record.category.icon)
                .font(.system(size: 20))
                .foregroundColor(record.category.color)
                .frame(width: 40, height: 40)
                .background(record.category.color.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.description)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    Text(formatDate(record.date))
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text("•")
                        .foregroundColor(.white.opacity(0.3))
                    
                    Image(systemName: record.paymentMethod.icon)
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text(record.paymentMethod.rawValue)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(record.category == .expense ? "-" : "+")\(record.amount)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(record.category == .expense ? .red : Color(red: 0.3, green: 0.43, blue: 0.96))
                
                Text(record.currency)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.5))
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.03))
        .cornerRadius(16)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }
}

extension RecordViewModel {
    func getCurrencySymbol() -> String {
        return selectedCurrency == "BTC" ? "₿" : "₹"
    }
}

struct RecordScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecordScreen()
    }
}