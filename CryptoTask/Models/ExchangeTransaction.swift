//
//  ExchangeTransaction.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//
import SwiftUI

struct ExchangeTransaction: Identifiable {
    let id = UUID()
    let type: ExchangeTransactionType
    let title: String
    let date: String
    let currency: String
    let amount: String
    
    enum ExchangeTransactionType {
        case send, receive
    }
}
