//
//  BalloonMarker.swift
//  ChartsDemo-Swift
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//
import Foundation
import Charts

open class BalloonMarker: MarkerImage
{
    open var color: UIColor
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont
    open var textColor: UIColor
    open var insets: UIEdgeInsets
    open var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [String : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
//        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - 2 * width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        var upwardHeight = size.height/2
        if offset.y != 0 {
            upwardHeight = 0
        }
        var rect = CGRect(origin: CGPoint(x: point.x + offset.x,y: point.y - upwardHeight + offset.y / 2),size: size)
        
        
        let height = size.height
        let radius = height / 2
        let width = rect.origin.x + radius + size.width
        
        context.saveGState()
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + radius, y: rect.origin.y - radius))
        context.addArc(center: CGPoint(x: rect.origin.x + radius, y: rect.origin.y), radius: radius, startAngle: 3 * .pi / 2, endAngle: .pi / 2, clockwise: true)
        context.addLine(to: CGPoint(x: width ,y: rect.origin.y + radius))
        context.addArc(center: CGPoint(x: width, y: rect.origin.y), radius: radius, startAngle: .pi / 2, endAngle:  3 * .pi / 2, clockwise: true)
        context.addLine(to: CGPoint(x: rect.origin.x + radius, y: rect.origin.y - radius))
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.orange.cgColor)
        context.drawPath(using: .fillStroke)
        context.closePath()
        
        rect.origin.x += radius
        rect.origin.y -= radius / 2
        
        
        /*UIGraphicsPushContext(context)
        label.draw(in: rect, withAttributes: _drawAttributes as [String : Any])
        
        UIGraphicsPopContext()*/
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
//        if entry.y != 0.0000 {
            setLabel(String(entry.y))
//        }
    }
    
    open func setLabel(_ newLabel: String)
    {
        let commaValue = Int(Double(newLabel) ?? 0.0)
        label = "\(commaValue)"
        
        _drawAttributes.removeAll()
        //_drawAttributes[NSFontAttributeName] = self.font
        //_drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        //_drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
       // _labelSize = label?.size(attributes: _drawAttributes as [String : Any]) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}

