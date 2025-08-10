//
//  CryptoTaskApp.swift
//  CryptoTask
//
//  Created by Kartikay singh on 05/08/25.
//

import SwiftUI
import NavKit
@main
struct CryptoTaskApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationContainerView {
                MainView()
            }
        }
    }
}
