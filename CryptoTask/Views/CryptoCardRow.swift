//
//  CryptoCardRow.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI

struct CryptoCardRow: View {
    let cryptos = [
        ("bitcoinsign.circle.fill", "Bitcoin", "BTC", 7562502.14, 3.2),
        ("bitcoinsign.circle.fill", "Ethereum", "ETH", 245502.10, -1.4),
        ("bitcoinsign.circle.fill", "Dogecoin", "DOGE", 12.45, 5.8)
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(cryptos, id: \.1) { icon, name, symbol, price, change in
                    CryptoCard(icon: icon, name: name, symbol: symbol, price: price, change: change)
                        .frame(width: 220)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.black.ignoresSafeArea())
    }
}
