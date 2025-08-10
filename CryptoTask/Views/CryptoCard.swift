//
//  CryptoCard.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//


import SwiftUI
import SwiftUI

struct CryptoCard: View {
    var icon: String
    var name: String
    var symbol: String
    var price: Double
    var change: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Text("₿")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                Text("\(name) (\(symbol))")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
            }
            
            HStack {
                Text("₹ \(price.formattedWithSeparator())")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Text("\(change >= 0 ? "+" : "")\(String(format: "%.1f", change))%")
                    .foregroundColor(change >= 0 ? .green : .red)
                    .font(.system(size: 16, weight: .medium))
            }
        }
        .frame(height: 100)
        .padding(16)
        .background(
                  RoundedRectangle(cornerRadius: 16)
                      .fill(.clear)  
                      .overlay(
                          LinearGradient(
                              colors: [Color.black.opacity(0.2), Color.black.opacity(0.05)],
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing
                          )
                          .clipShape(RoundedRectangle(cornerRadius: 16))
                      )
                      .overlay(
                          RoundedRectangle(cornerRadius: 16)
                              .stroke(Color.white.opacity(0.15), lineWidth: 1) // border
                      )
              )
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}

extension Double {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CryptoCard(
            icon: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            price: 7562502.14,
            change: 3.2
        )
        .padding()
    }
}
