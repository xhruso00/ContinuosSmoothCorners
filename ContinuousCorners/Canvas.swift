import AppKit

class Canvas : NSView {
    @Invalidating(.display) var width : CGFloat = 500
    @Invalidating(.display) var height : CGFloat = 500
    @Invalidating(.display) var radius : CGFloat = 0.5
    @Invalidating(.display) var isContinuos : Bool = true
    @Invalidating(.display) var color : NSColor = .black
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let context = NSGraphicsContext.current {
            if context.isDrawingToScreen {
                NSColor.white.setFill()
                bounds.fill()
            }
        }
        
        let radiusPx = (min(width, height)) / 2.0 * radius
        
        let originX = bounds.midX - width / 2
        let originY = bounds.midY - height / 2
        
        let drawingRect = NSMakeRect(originX, originY, width, height)
        let bezierPath = NSBezierPath._bezierPath(withRoundedRect:drawingRect,
                                                  radius: radiusPx,
                                                  continuousCorners: isContinuos)
        color.setFill()
        bezierPath.fill()
    }
}
