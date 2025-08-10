//
//  ActionButton.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI


struct ActionButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
                .frame(width: 56, height: 56)
                .background(Color.white.opacity(0.15))
                .clipShape(Circle())
        }
    }
}
