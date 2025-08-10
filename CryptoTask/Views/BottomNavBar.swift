//
//  BottomNavBar.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI


struct BottomNavBar: View {
    @Binding var selectedTab: String
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 20) {
            HStack(spacing: 0) {
                TabBarButton(icon: "chart.line.uptrend.xyaxis", title: "Analytics", selectedTab: $selectedTab, animation: animation)
                TabBarButton(icon: "arrow.left.arrow.right", title: "Exchange", selectedTab: $selectedTab, animation: animation)
                TabBarButton(icon: "list.bullet.rectangle", title: "Record", selectedTab: $selectedTab, animation: animation)
                TabBarButton(icon: "creditcard", title: "Wallet", selectedTab: $selectedTab, animation: animation)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                    )
            )
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            if selectedTab != "Exchange" {
            Button(action: {
                print("Plus button tapped")
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(width: 56, height: 56)
                    .background(
                        Circle()
                            .fill(Color.white)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray.opacity(0.1), lineWidth: 0.5)
                            )
                    )
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            }
        }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 34)
        .background(Color.clear)
    }
}
