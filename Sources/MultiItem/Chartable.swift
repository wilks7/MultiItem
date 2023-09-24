import Charts
import SwiftUI

public protocol Chartable: MultiItem {
    associatedtype DataX:Plottable, Comparable, Hashable
    associatedtype DataY:Plottable, Comparable, Hashable
    func data(for _: ClosedRange<Date>, component: Calendar.Component) -> [(DataX,DataY)]

    var points: [ (DataX, DataY) ] {get}
    
    func point(for reference: DataX) -> DataY?
}

public extension Chartable {
    func point(for reference: DataX) -> DataY? {
        points.first{ $0.0 == reference }?.1
    }
}
