
import SwiftUI

public protocol MultiItem {
    associatedtype Compact:View
    associatedtype Chart:View
    associatedtype Small:View
    associatedtype Medium: View
    associatedtype Glyph: View

    var label: String {get}
    var detail: String? {get}
    var symbolName: String {get}

    var compact: Compact {get}
    var small: Small {get}
    var medium: Medium {get}

    var chart: Chart {get}
    var glyph: Glyph {get}
    

}

public extension MultiItem {
    var compact: some View {
        CompactView(item: self)
    }
    
    var small: some View {
        SmallView(item: self)
    }
    
    var medium: some View {
        MediumView(item: self)
    }
    
    var glyph: some View {
        Image(systemName: symbolName)
    }
    
}
