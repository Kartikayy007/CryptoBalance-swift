//
//  WalletViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class WalletViewModel: ObservableObject {
    @Published var wallets: [CryptoWallet] = []
    @Published var selectedWallet: CryptoWallet?
    @Published var totalBalance: Balance = Balance(btc: 0.002126, inr: 157342.05)
    @Published var showAddWallet: Bool = false
    @Published var showWalletDetails: Bool = false
    @Published var selectedTimeRange: TimeRange = .day
    @Published var performanceData: [PerformancePoint] = []
    @Published var assets: [CryptoAsset] = []
    @Published var showQRCode: Bool = false
    @Published var walletAddress: String = ""
    @Published var newWalletName: String = ""
    @Published var newWalletType: WalletType = .hot
    
    enum TimeRange: String, CaseIterable {
        case day = "1D"
        case week = "1W"
        case month = "1M"
        case threeMonths = "3M"
        case year = "1Y"
        case all = "All"
    }
    
    enum WalletType: String, CaseIterable {
        case hot = "Hot Wallet"
        case cold = "Cold Wallet"
        case exchange = "Exchange"
        case defi = "DeFi"
        
        var icon: String {
            switch self {
            case .hot: return "flame.fill"
            case .cold: return "snowflake"
            case .exchange: return "arrow.triangle.2.circlepath"
            case .defi: return "cube.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .hot: return .orange
            case .cold: return Color(red: 0.21, green: 0.31, blue: 0.78)
            case .exchange: return .purple
            case .defi: return Color(red: 0.3, green: 0.43, blue: 0.96)
            }
        }
    }
    
    struct CryptoWallet: Identifiable {
        let id = UUID()
        let name: String
        let type: WalletType
        let address: String
        let balance: Balance
        let change24h: Double
        let assets: [CryptoAsset]
        let isActive: Bool
        let lastTransaction: Date
    }
    
    struct Balance {
        let btc: Double
        let inr: Double
    }
    
    struct CryptoAsset: Identifiable {
        let id = UUID()
        let symbol: String
        let name: String
        let balance: Double
        let value: Double
        let change24h: Double
        let icon: String
        let color: Color
        let allocation: Double
    }
    
    struct PerformancePoint: Identifiable {
        let id = UUID()
        let date: String
        let value: Double
    }
    
    init() {
        loadWallets()
        loadAssets()
        generatePerformanceData()
    }
    
    private func loadWallets() {
        wallets = [
            CryptoWallet(
                name: "Main Wallet",
                type: .hot,
                address: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh",
                balance: Balance(btc: 0.001526, inr: 112342.05),
                change24h: 4.6,
                assets: loadMainWalletAssets(),
                isActive: true,
                lastTransaction: Date().addingTimeInterval(-3600)
            ),
            CryptoWallet(
                name: "Cold Storage",
                type: .cold,
                address: "bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq",
                balance: Balance(btc: 0.000600, inr: 45000.00),
                change24h: 2.3,
                assets: loadColdWalletAssets(),
                isActive: false,
                lastTransaction: Date().addingTimeInterval(-86400 * 7)
            ),
            CryptoWallet(
                name: "Trading Wallet",
                type: .exchange,
                address: "3FZbgi29cpjq2GjdwV8eyHuJJnkLtktZc5",
                balance: Balance(btc: 0.000000, inr: 0.00),
                change24h: 0.0,
                assets: [],
                isActive: false,
                lastTransaction: Date().addingTimeInterval(-86400 * 30)
            )
        ]
        
        selectedWallet = wallets.first
    }
    
    private func loadMainWalletAssets() -> [CryptoAsset] {
        return [
            CryptoAsset(symbol: "BTC", name: "Bitcoin", balance: 0.001526, value: 112342.05, change24h: 4.6, icon: "bitcoinsign.circle.fill", color: .orange, allocation: 70),
            CryptoAsset(symbol: "ETH", name: "Ethereum", balance: 0.05, value: 25000.00, change24h: 3.2, icon: "e.circle.fill", color: .purple, allocation: 20),
            CryptoAsset(symbol: "SOL", name: "Solana", balance: 2.5, value: 20000.00, change24h: 8.9, icon: "s.circle.fill", color: Color(red: 0.4, green: 0.5, blue: 0.9), allocation: 10)
        ]
    }
    
    private func loadColdWalletAssets() -> [CryptoAsset] {
        return [
            CryptoAsset(symbol: "BTC", name: "Bitcoin", balance: 0.000600, value: 45000.00, change24h: 4.6, icon: "bitcoinsign.circle.fill", color: .orange, allocation: 100)
        ]
    }
    
    private func loadAssets() {
        assets = [
            CryptoAsset(symbol: "BTC", name: "Bitcoin", balance: 0.002126, value: 157342.05, change24h: 4.6, icon: "bitcoinsign.circle.fill", color: .orange, allocation: 60),
            CryptoAsset(symbol: "ETH", name: "Ethereum", balance: 0.05, value: 25000.00, change24h: 3.2, icon: "e.circle.fill", color: .purple, allocation: 15),
            CryptoAsset(symbol: "SOL", name: "Solana", balance: 2.5, value: 20000.00, change24h: 8.9, icon: "s.circle.fill", color: Color(red: 0.4, green: 0.5, blue: 0.9), allocation: 10),
            CryptoAsset(symbol: "ADA", name: "Cardano", balance: 500, value: 15000.00, change24h: -2.1, icon: "a.circle.fill", color: Color(red: 0.11, green: 0.09, blue: 0.47), allocation: 8),
            CryptoAsset(symbol: "DOT", name: "Polkadot", balance: 10, value: 10000.00, change24h: 5.7, icon: "d.circle.fill", color: .pink, allocation: 7)
        ]
    }
    
    private func generatePerformanceData() {
        performanceData = []
        let baseValue = 150000.0
        
        switch selectedTimeRange {
        case .day:
            for hour in 0..<24 {
                let variation = Double.random(in: -5000...8000)
                performanceData.append(PerformancePoint(date: "\(hour):00", value: baseValue + variation))
            }
        case .week:
            let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            for day in days {
                let variation = Double.random(in: -10000...15000)
                performanceData.append(PerformancePoint(date: day, value: baseValue + variation))
            }
        case .month:
            for day in 1...30 {
                let variation = Double.random(in: -15000...20000)
                performanceData.append(PerformancePoint(date: "\(day)", value: baseValue + variation))
            }
        default:
            for month in 1...12 {
                let variation = Double.random(in: -20000...30000)
                performanceData.append(PerformancePoint(date: "M\(month)", value: baseValue + variation))
            }
        }
    }
    
    func selectTimeRange(_ range: TimeRange) {
        selectedTimeRange = range
        generatePerformanceData()
    }
    
    func addNewWallet() {
        guard !newWalletName.isEmpty else { return }
        
        let newWallet = CryptoWallet(
            name: newWalletName,
            type: newWalletType,
            address: generateWalletAddress(),
            balance: Balance(btc: 0.0, inr: 0.0),
            change24h: 0.0,
            assets: [],
            isActive: false,
            lastTransaction: Date()
        )
        
        wallets.append(newWallet)
        newWalletName = ""
        showAddWallet = false
    }
    
    func deleteWallet(_ wallet: CryptoWallet) {
        wallets.removeAll { $0.id == wallet.id }
        if selectedWallet?.id == wallet.id {
            selectedWallet = wallets.first
        }
    }
    
    func toggleWalletActive(_ wallet: CryptoWallet) {
        if let index = wallets.firstIndex(where: { $0.id == wallet.id }) {
            let updatedWallet = CryptoWallet(
                name: wallet.name,
                type: wallet.type,
                address: wallet.address,
                balance: wallet.balance,
                change24h: wallet.change24h,
                assets: wallet.assets,
                isActive: !wallet.isActive,
                lastTransaction: wallet.lastTransaction
            )
            wallets[index] = updatedWallet
        }
    }
    
    private func generateWalletAddress() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let prefix = newWalletType == .cold ? "bc1q" : "3"
        let randomString = String((0..<30).map { _ in characters.randomElement()! })
        return prefix + randomString
    }
    
    func getPortfolioGrowth() -> Double {
        return 12.5
    }
    
    func get24hChange() -> Double {
        return 4.6
    }
    
    func getTotalValue() -> String {
        return String(format: "₹%.2f", totalBalance.inr)
    }
    
    func getBTCValue() -> String {
        return String(format: "%.6f BTC", totalBalance.btc)
    }
}