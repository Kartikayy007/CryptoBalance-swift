//
//  TabBarButton.swift
//  CryptoTask
//
//  Created by Kartikay singh on 05/08/25.
//
import SwiftUI


struct TabBarButton: View {
    var icon: String
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID

    private var isSelected: Bool {
        selectedTab == title
    }

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                selectedTab = title
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .white : .gray.opacity(0.7))
                    .frame(width: 24, height: 24)

                Text(title)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? .white : .gray.opacity(0.7))
                    .lineLimit(1)
            }
            .frame(width: 72, height: 60)
            .background(
                ZStack {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.blue.opacity(0.9),
                                        Color.blue
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                            )
                            .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                            .matchedGeometryEffect(id: "TAB_BACKGROUND", in: animation)
                    }
                }
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}



