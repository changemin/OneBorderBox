import SwiftUI

public struct CMOneBorderBox: View {
    var edge: Edge.Set = [.leading]
    var accentColor: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    var width: CGFloat = 5
    var topLeft: CGFloat = 5
    var topRight: CGFloat = 5
    var bottomLeft: CGFloat = 5
    var bottomRight: CGFloat = 5
    
    public var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let topRight = min(min(self.topRight, h/2), w/2)
                let topLeft = min(min(self.topLeft, h/2), w/2)
                let bottomLeft = min(min(self.bottomLeft, h/2), w/2)
                let bottomRight = min(min(self.bottomRight, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - topRight, y: 0))
                path.addArc(center: CGPoint(x: w - topRight, y: topRight), radius: topRight, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - bottomRight))
                path.addArc(center: CGPoint(x: w - bottomRight, y: h - bottomRight), radius: bottomRight, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bottomLeft, y: h))
                path.addArc(center: CGPoint(x: bottomLeft, y: h - bottomLeft), radius: bottomLeft, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: topLeft))
                path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .overlay(
                getForegroundSquare(edge: edge)
            )
            .foregroundColor(accentColor)
            .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 0)
        }
    }
    
    public func getForegroundSquare(edge: Edge.Set) -> some View {
        var topRight: CGFloat = 0
        var topLeft: CGFloat = 0
        var bottomRight: CGFloat = 0
        var bottomLeft: CGFloat = 0
        
        if(edge == [.leading]) {
            topRight -= 2
            bottomRight -= 2
        }
        else if(edge == [.top]) {
            bottomRight -= 2
            bottomLeft -= 2
        }
        else if(edge == [.trailing]) {
            topLeft -= 2
            bottomLeft -= 2
        }
        else if(edge == [.bottom]) {
            topRight -= 2
            topLeft -= 2
        }
        
        return RoundSquare(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight).fill(Color(UIColor.secondarySystemGroupedBackground)).padding(edge, width)
    }
    
    public init() {
        
    }
    
    public init(edge: Edge.Set, width: CGFloat, color: Color, cornerRadius: CGFloat) {
        self.edge = edge
        self.width = width
        self.accentColor = color
        self.topLeft = cornerRadius
        self.topRight = cornerRadius
        self.bottomLeft = cornerRadius
        self.bottomRight = cornerRadius
    }
    
    public init(edge: Edge.Set, width: CGFloat, color: Color, topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        self.edge = edge
        self.width = width
        self.accentColor = color
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
}

struct RoundSquare: Shape {
    var topLeft: CGFloat = 0.0
    var topRight: CGFloat = 0.0
    var bottomLeft: CGFloat = 0.0
    var bottomRight: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let topRight = min(min(self.topRight, h/2), w/2)
        let topLeft = min(min(self.topLeft, h/2), w/2)
        let bottomLeft = min(min(self.bottomLeft, h/2), w/2)
        let bottomRight = min(min(self.bottomRight, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - topRight, y: 0))
        path.addArc(center: CGPoint(x: w - topRight, y: topRight), radius: topRight,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - bottomRight))
        path.addArc(center: CGPoint(x: w - bottomRight, y: h - bottomRight), radius: bottomRight,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bottomLeft, y: h))
        path.addArc(center: CGPoint(x: bottomLeft, y: h - bottomLeft), radius: bottomLeft,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(center: CGPoint(x: topLeft, y: topLeft), radius: topLeft,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
