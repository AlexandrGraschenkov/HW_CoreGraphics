//
//  Line.swift
//  HW_CoreGraphics
//
//  Created by Gena on 23.04.15.
//  Copyright (c) 2015 Gena. All rights reserved.
//

import UIKit

class Line: NSObject {
    
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    var strokeWidth: CGFloat!
    
    override convenience init() {
        self.init(startPoint: CGPointMake(0, 0), endPoint: CGPointMake(0, 0))
    }
    
    init(startPoint: CGPoint!, endPoint: CGPoint!, strokeWidth: CGFloat! = 1.0) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.strokeWidth = strokeWidth
    }
    
    func drawInContext(context: CGContextRef!, withColor color: UIColor! = UIColor.blackColor()) {
        CGContextMoveToPoint(context, startPoint.x, startPoint.y)
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextSetLineWidth(context, strokeWidth)
        CGContextStrokePath(context)
    }
    
    func getLenght() -> CGFloat {
        return sqrt((endPoint.x - startPoint.x)*(endPoint.x - startPoint.x) + (endPoint.y - startPoint.y)*(endPoint.y - startPoint.y))
    }
    
}
