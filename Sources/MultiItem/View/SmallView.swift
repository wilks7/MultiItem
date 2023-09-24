//
//  ItemSmallView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI

public struct SmallView<G:View>: View {
    public let title: String
    public var detail: String? = nil
    public var glyph: G
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            glyph
            if let detail {
                Text(detail)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }

        }
        .padding(.horizontal)
    }
}

public extension SmallView {
    init<M:MultiItem>(item: M) where G == M.Glyph {
        self.title = item.label
        self.detail = item.detail
        self.glyph = item.glyph
    }
    
}

//#Preview {
////    SmallView(item: MockData.mars)
//}

