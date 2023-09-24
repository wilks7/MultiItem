
import SwiftUI
import Charts

@available(iOS 16.0, *)
public struct ItemChart<X:Plottable, Y:Plottable>: View where X: Hashable, Y: Hashable, X:Comparable, Y:Comparable {
    public typealias PointFor = (X) -> Y
    public typealias ChartPoint = (X,Y)
    
    public var chartPoints: [(X,Y)]
    public var now: ChartPoint? = nil
    public var showZero = false
    public var pointFor: PointFor? = nil
    
    @State var selected: ChartPoint?

    public var body: some View {
        Chart {
            ForEach(chartPoints, id: \.self.0){
                LineMark(
                    x: .value("Time", $0.0),
                    y: .value("Value", $0.1)
                )
                .lineStyle(.init(lineWidth: 4))
            }
            if showZero {
                RuleMark(y: .value("Value", 0))
                    .foregroundStyle(.white)
            }
            if let selected {
                RuleMark(x: .value("Time", selected.0))
                    .foregroundStyle(.gray)
                    .annotation(position: .overlay) {
                        if let date = selected.0 as? Date {
                            Text(date.formatted())
                                .font(.caption)
                        }
                    }
                PointMark(
                    x: .value("Time", selected.0),
                    y: .value("Value", selected.1)
                )
                .foregroundStyle(.white)
            } else if let now {
                PointMark(
                    x: .value("Time", now.0),
                    y: .value("Value", now.1)
                )
                .foregroundStyle(.white)
            }
        }

        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if #available(iOS 17.0, *) {
                                    selectedValue(proxy: proxy, geometry: geometry, value: value)
                                }
                            }
                            .onEnded{ _ in
                                if #available(iOS 17.0, *) {
                                    self.selected = nil
                                }
                            }
                    )
            }
        }
        .chartYAxis(.hidden)

    }
    
    @available(iOS 17.0, *)
    private func selectedValue(proxy: ChartProxy, geometry: GeometryProxy, value: DragGesture.Value) {
        guard let plotFrame = proxy.plotFrame else {return}
        
        let origin = geometry[plotFrame].origin
        
        let location = CGPoint(
            x: value.location.x - origin.x,
            y: value.location.y - origin.y
        )
        let point = proxy.value(
            at: location,
            as: (X, Y).self
        )

        guard
            let reference = point?.0,
            let first = chartPoints.first?.0,
            let last = chartPoints.last?.0,
            reference >= first && reference <= last
        else {
            return
        }
        
        if let pointFor {
            self.selected = (reference, pointFor(reference))
        }
//        else if let yValue = chartPoints.first(where: {$0.reference == reference }) {
//            self.selected = (reference, yValue.value)
//            print("yooo")
//        }
    }

}
 
public extension ItemChart {
    
    init<C:Chartable>(
        item: C,
        now: (C.DataX, C.DataY)? = nil,
        showZero: Bool = false,
        pointFor: @escaping (C.DataX) -> C.DataY
    ) where X == C.DataX, Y == C.DataY {
        self.chartPoints = item.points
        self.now = now
        self.showZero = showZero
        self.pointFor = pointFor
    }
    
}
