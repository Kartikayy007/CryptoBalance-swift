//
//  TimeRangeSelector.swift
//  CryptoTask
//
//  Created by Kartikay singh on 06/08/25.
//


import SwiftUI

struct TimeRangeSelector: View {
    @Binding var selectedRange: String
    @Namespace private var animation
    
    let ranges = ["1h", "8h", "1d", "1w", "1m", "6m", "1y"]
    
    var body: some View {
        HStack(spacing: 32) {
            ForEach(ranges, id: \.self) { range in
                ZStack {
                    if selectedRange == range {
                        Capsule()
                            .fill(Color.gray.opacity(0.3))
                            .matchedGeometryEffect(id: "highlight", in: animation)
                            .frame(width: 48, height: 38)
                    }
                    
                    Text(range)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedRange == range ? .white : .gray)
                }
                .onTapGesture {
                    withAnimation(.default) {
                        selectedRange = range
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedRange = "1d"
        
        var body: some View {
            TimeRangeSelector(selectedRange: $selectedRange)
                .padding()
                .background(Color.black)
        }
    }
    
    return PreviewWrapper()
}
