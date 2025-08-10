//
//  MainViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedTab: String = "Analytics"
    @Published var selectedRange: String = "6m"
    
    let availableTabs = ["Analytics", "Exchange", "Record", "Wallet"]
    let availableRanges = ["1d", "1w", "1m", "3m", "6m", "1y"]
    
    func selectTab(_ tab: String) {
        selectedTab = tab
    }
    
    func selectRange(_ range: String) {
        selectedRange = range
    }
} 