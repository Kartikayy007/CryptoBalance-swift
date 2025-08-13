//
//  ChartViewModel.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var selectedIndex: Int = 4
    @Published var selectedRange: String = "6m"
    
    struct DataPoint: Identifiable {
        let id = UUID()
        let date: String
        let value: Double
    }
    
    @Published var chartData: [DataPoint] = (20...26).map { day in
        .init(date: "\(day) Mar", value: Double.random(in: 85000...145000))
    }

    
    var maxValue: Double {
        chartData.map { $0.value }.max() ?? 1
    }
    
    func selectDataPoint(at index: Int) {
        selectedIndex = index
    }
    
    func updateRange(_ range: String) {
        selectedRange = range
        // In a real app, this would fetch new data based on the range
        // For now, we'll just randomly select a new data point
        withAnimation(.easeInOut(duration: 0.3)) {
            selectedIndex = Int.random(in: 0..<chartData.count)
        }
    }
    
    func getSelectedDataPoint() -> DataPoint {
        return chartData[selectedIndex]
    }
    
    func getSelectedDate() -> String {
        return chartData[selectedIndex].date
    }
    
    func getSelectedValue() -> Double {
        return chartData[selectedIndex].value
    }
    
    func getFormattedSelectedValue() -> String {
        return Int(chartData[selectedIndex].value).formatted(.number)
    }
    
    func calculateBarHeight(for value: Double, chartHeight: CGFloat) -> CGFloat {
        return CGFloat(value / maxValue) * chartHeight
    }
    
    func calculateXPosition(for index: Int, barWidth: CGFloat, spacing: CGFloat) -> CGFloat {
        return CGFloat(index) * (barWidth + spacing) + barWidth / 2
    }
    
    func findClosestDataPoint(to xPosition: CGFloat, barWidth: CGFloat, spacing: CGFloat) -> Int {
        var closest = 0
        var minDist = CGFloat.infinity
        
        for i in chartData.indices {
            let dist = abs(xPosition - calculateXPosition(for: i, barWidth: barWidth, spacing: spacing))
            if dist < minDist {
                minDist = dist
                closest = i
            }
        }
        
        return closest
    }
} 
