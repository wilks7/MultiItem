
import SwiftUI

public struct MediumView<G:View>: View {
    public let label: String
    public var detail: String? = nil
    public let glyph: G
    
    public var body: some View {
        HStack {
            glyph
                .frame(width: 70, height: 70)
            Spacer()
            VStack {
                Text(label)
                Text(detail ?? "--")
            }
        }
    }
}

public extension MediumView {
    init<M:MultiItem>(item: M) where G == M.Glyph {
        self.label = item.label
        self.detail = item.detail
        self.glyph = item.glyph
    }
}
