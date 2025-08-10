//
//  ChartView.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.

import SwiftUI

import SwiftUI

public struct ChartView: View {
    @Binding var selectedRange: String
    @StateObject private var viewModel = ChartViewModel()
    
    public init(selectedRange: Binding<String>) {
        self._selectedRange = selectedRange
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geo in
                let barWidth: CGFloat = 40
                let chartHeight = geo.size.height * 0.7
                let spacing = (geo.size.width - (CGFloat(viewModel.chartData.count) * barWidth)) / CGFloat(viewModel.chartData.count - 1)
                
                
                VStack(spacing: 4) {
                    Text(viewModel.getSelectedDate())
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .medium))
                    HStack(spacing: 4) {
                        Text("₹").font(.system(size: 18, weight: .semibold))
                        Text(viewModel.getFormattedSelectedValue())
                            .font(.system(size: 24, weight: .bold))
                    }
                    .foregroundColor(.white)
                }
                .position(
                    x: min(
                        max(viewModel.calculateXPosition(for: viewModel.selectedIndex, barWidth: barWidth, spacing: spacing), 60),
                        geo.size.width - 60                     ),
                    y: geo.size.height * 0.15
                )


                ZStack {
                    
                    HStack(alignment: .bottom, spacing: spacing) {
                        ForEach(viewModel.chartData.indices, id: \.self) { i in
                            let barHeight = viewModel.calculateBarHeight(for: viewModel.chartData[i].value, chartHeight: chartHeight)
                            RoundedRectangle(cornerRadius: 8)
                                .fill( LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.082, green: 0.082, blue: 0.082),
                                        Color(red: 0.031, green: 0.031, blue: 0.039) 
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
)
                                .frame(width: barWidth, height: barHeight)
                        }
                    }
                    
                
                    Path { path in
                        for i in viewModel.chartData.indices {
                            let x = viewModel.calculateXPosition(for: i, barWidth: barWidth, spacing: spacing)
                            let y = chartHeight - viewModel.calculateBarHeight(for: viewModel.chartData[i].value, chartHeight: chartHeight)
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                let prevX = viewModel.calculateXPosition(for: i - 1, barWidth: barWidth, spacing: spacing)
                                let prevY = chartHeight - viewModel.calculateBarHeight(for: viewModel.chartData[i - 1].value, chartHeight: chartHeight)
                                let controlX = (prevX + x) / 2
                                path.addCurve(to: CGPoint(x: x, y: y),
                                              control1: CGPoint(x: controlX, y: prevY),
                                              control2: CGPoint(x: controlX, y: y))
                            }
                        }
                    }
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    
                    let handleY = chartHeight - viewModel.calculateBarHeight(for: viewModel.chartData[viewModel.selectedIndex].value, chartHeight: chartHeight)
                    Rectangle()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 1, height: chartHeight)
                        .position(x: viewModel.calculateXPosition(for: viewModel.selectedIndex, barWidth: barWidth, spacing: spacing),
                                  y: chartHeight / 2)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10, height: 10)
                        .shadow(color: .black.opacity(0.5), radius: 4)
                        .position(x: viewModel.calculateXPosition(for: viewModel.selectedIndex, barWidth: barWidth, spacing: spacing),
                                  y: handleY)
                }
                .frame(height: chartHeight)
                .offset(y: geo.size.height * 0.3)
                .contentShape(Rectangle())
                .onTapGesture { location in
                    let closest = viewModel.findClosestDataPoint(to: location.x, barWidth: barWidth, spacing: spacing)
                    if closest != viewModel.selectedIndex {
                        viewModel.selectDataPoint(at: closest)
                    }
                }

            }
        }
        .frame(height: 250)
        .padding()
        .background(Color.black)
        .onChange(of: selectedRange) { newRange in
            viewModel.updateRange(newRange)
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.selectedIndex)

    }
}
