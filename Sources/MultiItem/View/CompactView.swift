import SwiftUI

public struct CompactView<T:View>: View {
    public let title: T
    public var subtitle: String? = nil
    public var alignment: HorizontalAlignment = .center
    
    public var body: some View {
        VStack(alignment: alignment) {
            title
            if let subtitle {
                Text(subtitle)
            }
        }
    }
}

public extension CompactView {
    init(title: String,
         subtitle: String? = nil,
         alignment: HorizontalAlignment = .center)
    where T == Text {
        self.title = Text(title)
        self.subtitle = subtitle
        self.alignment = alignment
    }
    
    init<M:MultiItem>(item: M,
                      alignment: HorizontalAlignment = .center)
    where T == M.Glyph {
        self.title = item.glyph
        self.subtitle = item.detail
        self.alignment = alignment
    }
}

#Preview {
    CompactView(title: "Title", subtitle: "subtitle", alignment: .leading)
}
