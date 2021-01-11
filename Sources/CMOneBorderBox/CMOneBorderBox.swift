import SwiftUI

/// One Side Bordered Box
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
                getForegroundSquare(edge: edge, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
            )
            .foregroundColor(accentColor)
            .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 0)
        }
    }
    
    public func getForegroundSquare(edge: Edge.Set, topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) -> some View {
        var topRight: CGFloat = topRight
        var topLeft: CGFloat = topLeft
        var bottomRight: CGFloat = bottomRight
        var bottomLeft: CGFloat = bottomLeft
        
        if(edge == [.leading]) {
            topRight -= 2
            topLeft = 0
            bottomRight -= 2
            bottomLeft = 0
        }
        else if(edge == [.top]) {
            topRight = 0
            topLeft = 0
            bottomRight -= 2
            bottomLeft -= 2
        }
        else if(edge == [.trailing]) {
            topRight = 0
            topLeft -= 2
            bottomRight = 0
            bottomLeft -= 2
        }
        else if(edge == [.bottom]) {
            topRight -= 2
            topLeft -= 2
            bottomRight = 0
            bottomLeft = 0
        }
        
        return RoundSquare(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight).fill(Color(UIColor.secondarySystemGroupedBackground)).padding(edge, width)
    }
    
    public init() {
        
    }
    
    public init(color: Color) {
        self.accentColor = color
    }
    
    public init(edge: Edge.Set, color: Color) {
        self.edge = edge
        self.accentColor = color
    }
    
    public init(edge: Edge.Set, color: Color, width: CGFloat) {
        self.edge = edge
        self.accentColor = color
        self.width = width
    }
    
    public init(edge: Edge.Set, color: Color, width: CGFloat, cornerRadius: CGFloat) {
        self.edge = edge
        self.accentColor = color
        self.width = width
        self.topRight = cornerRadius
        self.topLeft = cornerRadius
        self.bottomRight = cornerRadius
        self.bottomLeft = cornerRadius
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

public extension View {
    /// Make background CMOneBorderBox.
    func CMOneBorderBox() -> some View {
        self.modifier(CMOneBorderBoxModifier())
    }
    /// Make background CMOneBorderBox with custom color
    func CMOneBorderBox(color: Color) -> some View {
        self.modifier(CMOneBorderBoxModifier(color: color))
    }
    /// Make background CMOneBorderBox with custom edge set and color
    func CMOneBorderBox(edge: Edge.Set, color: Color) -> some View {
        self.modifier(CMOneBorderBoxModifier(edge: edge, color: color))
    }
    /// Make background CMOneBorderBox with custom edge set and color, width
    func CMOneBorderBox(edge: Edge.Set, color: Color, width: CGFloat) -> some View {
        self.modifier(CMOneBorderBoxModifier(edge: edge, color: color, width: width))
    }
    /// Make background CMOneBorderBox with custom edge set and color, width, cornerRadius
    func CMOneBorderBox(edge: Edge.Set, color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        self.modifier(CMOneBorderBoxModifier(edge: edge, color: color, width: width, cornerRadius: cornerRadius))
    }
    /// Make background CMOneBorderBox with custom edge set and color, width, cornerRadius
    func CMOneBorderBox(edge: Edge.Set, color: Color, width: CGFloat, cornerRadius: CGFloat, topRight: CGFloat, topLeft: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) -> some View {
        self.modifier(CMOneBorderBoxModifier(edge: edge, width: width, color: color, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
}

public struct CMOneBorderBoxModifier: ViewModifier {
    var edge: Edge.Set = [.leading]
    var accentColor: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    var width: CGFloat = 5
    var topLeft: CGFloat = 5
    var topRight: CGFloat = 5
    var bottomLeft: CGFloat = 5
    var bottomRight: CGFloat = 5
    
    public func body(content: Content) -> some View {
        return content
            .padding()
            .background(CMOneBorderBox(edge: edge, width: width, color: accentColor, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
    
    public init() {
        
    }
    
    public init(color: Color) {
        self.accentColor = color
    }
    
    public init(edge: Edge.Set, color: Color) {
        self.edge = edge
        self.accentColor = color
    }
    
    public init(edge: Edge.Set, color: Color, width: CGFloat) {
        self.edge = edge
        self.accentColor = color
        self.width = width
    }
    
    public init(edge: Edge.Set, color: Color, width: CGFloat, cornerRadius: CGFloat) {
        self.edge = edge
        self.accentColor = color
        self.width = width
        self.topRight = cornerRadius
        self.topLeft = cornerRadius
        self.bottomRight = cornerRadius
        self.bottomLeft = cornerRadius
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
