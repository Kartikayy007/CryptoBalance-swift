//
//  WalletScreen.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI
import NavKit

struct WalletScreen: View {
    @StateObject private var viewModel = WalletViewModel()
    @State private var selectedSegment = 0
    
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
                        
                        Text("Wallet")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                viewModel.showAddWallet.toggle()
                            }
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 16) {
                            Text("Total Portfolio")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                            
                            Text(viewModel.getTotalValue())
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text(viewModel.getBTCValue())
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                            
                            HStack(spacing: 32) {
                                VStack(spacing: 4) {
                                    Text("24h Change")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.5))
                                    
                                    Text("+\(String(format: "%.1f", viewModel.get24hChange()))%")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(red: 0.3, green: 0.43, blue: 0.96))
                                }
                                
                                VStack(spacing: 4) {
                                    Text("Portfolio Growth")
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.5))
                                    
                                    Text("+\(String(format: "%.1f", viewModel.getPortfolioGrowth()))%")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(red: 0.21, green: 0.31, blue: 0.78))
                                }
                            }
                        }
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.3, green: 0.43, blue: 0.96),
                                    Color(red: 0.21, green: 0.31, blue: 0.78)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(24)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(WalletViewModel.TimeRange.allCases, id: \.self) { range in
                                    TimeRangeButton(
                                        range: range,
                                        isSelected: viewModel.selectedTimeRange == range
                                    ) {
                                        withAnimation {
                                            viewModel.selectTimeRange(range)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        if !viewModel.performanceData.isEmpty {
                            PerformanceChart(data: viewModel.performanceData)
                                .frame(height: 200)
                                .padding(.horizontal, 20)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("My Wallets")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("\(viewModel.wallets.count) wallets")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.wallets) { wallet in
                                        WalletCard(wallet: wallet) {
                                            withAnimation {
                                                viewModel.selectedWallet = wallet
                                                viewModel.showWalletDetails = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Assets")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    HStack(spacing: 4) {
                                        Text("Sort by")
                                        Image(systemName: "chevron.down")
                                    }
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                }
                            }
                            
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.assets) { asset in
                                    AssetRow(asset: asset)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 100)
                    }
                }
            }
            
            if viewModel.showAddWallet {
                AddWalletSheet(viewModel: viewModel)
            }
        }
    }
}

struct TimeRangeButton: View {
    let range: WalletViewModel.TimeRange
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(range.rawValue)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected ? Color.white : Color.white.opacity(0.1)
                )
                .cornerRadius(8)
        }
    }
}

struct PerformanceChart: View {
    let data: [WalletViewModel.PerformancePoint]
    @State private var selectedPoint: WalletViewModel.PerformancePoint?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let maxValue = data.map { $0.value }.max() ?? 0
                let minValue = data.map { $0.value }.min() ?? 0
                let range = maxValue - minValue
                
                Path { path in
                    for (index, point) in data.enumerated() {
                        let x = (geometry.size.width / CGFloat(data.count - 1)) * CGFloat(index)
                        let y = geometry.size.height - ((point.value - minValue) / range) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.3, green: 0.43, blue: 0.96), Color(red: 0.21, green: 0.31, blue: 0.78)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
                
                Path { path in
                    for (index, point) in data.enumerated() {
                        let x = (geometry.size.width / CGFloat(data.count - 1)) * CGFloat(index)
                        let y = geometry.size.height - ((point.value - minValue) / range) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.3, green: 0.43, blue: 0.96).opacity(0.3),
                            Color(red: 0.3, green: 0.43, blue: 0.96).opacity(0.1),
                            Color.clear
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}

struct WalletCard: View {
    let wallet: WalletViewModel.CryptoWallet
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: wallet.type.icon)
                        .font(.system(size: 20))
                        .foregroundColor(wallet.type.color)
                    
                    Spacer()
                    
                    if wallet.isActive {
                        Circle()
                            .fill(Color(red: 0.3, green: 0.43, blue: 0.96))
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(wallet.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text("₹\(Int(wallet.balance.inr))")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(String(format: "%.6f", wallet.balance.btc)) BTC")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.5))
                
                HStack {
                    Image(systemName: wallet.change24h > 0 ? "arrow.up.right" : "arrow.down.right")
                        .font(.system(size: 10))
                    
                    Text("\(String(format: "%.1f", abs(wallet.change24h)))%")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(wallet.change24h > 0 ? Color(red: 0.3, green: 0.43, blue: 0.96) : .red)
            }
            .padding(16)
            .frame(width: 180)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        wallet.type.color.opacity(0.3),
                        wallet.type.color.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(wallet.type.color.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

struct AssetRow: View {
    let asset: WalletViewModel.CryptoAsset
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(asset.color.opacity(0.2))
                    .frame(width: 44, height: 44)
                
                Image(systemName: asset.icon)
                    .font(.system(size: 20))
                    .foregroundColor(asset.color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(asset.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Text("\(String(format: "%.4f", asset.balance)) \(asset.symbol)")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.5))
                    
                    Text("•")
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("\(Int(asset.allocation))%")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("₹\(Int(asset.value))")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                HStack(spacing: 2) {
                    Image(systemName: asset.change24h > 0 ? "arrow.up.right" : "arrow.down.right")
                        .font(.system(size: 10))
                    
                    Text("\(String(format: "%.1f", abs(asset.change24h)))%")
                        .font(.system(size: 12))
                }
                .foregroundColor(asset.change24h > 0 ? Color(red: 0.3, green: 0.43, blue: 0.96) : .red)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.03))
        .cornerRadius(16)
    }
}

struct AddWalletSheet: View {
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        viewModel.showAddWallet = false
                    }
                }
            
            VStack(spacing: 20) {
                HStack {
                    Text("Add New Wallet")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.showAddWallet = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
                
                TextField("Wallet Name", text: $viewModel.newWalletName)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Wallet Type")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.7))
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(WalletViewModel.WalletType.allCases, id: \.self) { type in
                            WalletTypeButton(
                                type: type,
                                isSelected: viewModel.newWalletType == type
                            ) {
                                withAnimation {
                                    viewModel.newWalletType = type
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        viewModel.addNewWallet()
                    }
                }) {
                    Text("Create Wallet")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding(24)
            .frame(maxHeight: 400)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red: 0.1, green: 0.1, blue: 0.15))
            )
            .padding(.horizontal, 20)
        }
    }
}

struct WalletTypeButton: View {
    let type: WalletViewModel.WalletType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: type.icon)
                    .font(.system(size: 16))
                    .foregroundColor(type.color)
                
                Text(type.rawValue)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? type.color.opacity(0.2) : Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? type.color : Color.clear, lineWidth: 1)
                    )
            )
        }
    }
}

struct WalletScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalletScreen()
    }
}