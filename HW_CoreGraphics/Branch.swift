//
//  Branch.swift
//  HW_CoreGraphics
//
//  Created by Gena on 23.04.15.
//  Copyright (c) 2015 Gena. All rights reserved.
//

import UIKit
import Foundation

extension CGFloat {
    func angleInRadians() -> CGFloat {
        return self * CGFloat(M_PI) / 180.0
    }
}

class Branch: NSObject {
    
    var angleBetweenLines: CGFloat!
    var normalLine: Line!
    var leftLine: Line!
    var rightLine: Line!
    
    func getLines() -> [Line] {
        return [leftLine, rightLine]
    }
    
    override convenience init() {
        self.init(normalLine: Line())
    }
    
    /*
    Quaters:
     4 | 1
    -------
     3 | 2
    */
    
    init(normalLine: Line!, angleBetweenLines angelA: CGFloat! = 60.0, percentageOfCompression percent: CGFloat! = 0) {
        
        assert(angelA > 0 && angelA <= 180, "Angle between lines must be less than 180 degrees and greater than 0")
        assert(percent >= 0 && percent <= 100, "Percentage of compression must be from 0 up to 100")
        
        let length: CGFloat = normalLine.getLenght() * (1 - percent / 100)
        let strokeWidth: CGFloat = normalLine.strokeWidth * (1 - percent / 100)
        
        self.angleBetweenLines = angelA
        self.normalLine = normalLine
        
        let _x = abs(normalLine.endPoint.x - normalLine.startPoint.x)
        let _y = abs(normalLine.startPoint.y - normalLine.endPoint.y)
        let angleF = atan(_x / _y)
        
        var angleRight = (90.0 - angelA / 2).angleInRadians()
        var angleLeft = (90.0 + angelA / 2).angleInRadians()
        
        var k: CGFloat = 1;
        
        //if normal line in 1st quater
        if (normalLine.startPoint.x >= normalLine.endPoint.x && normalLine.startPoint.y < normalLine.endPoint.y) {
            angleRight += angleF
            angleLeft += angleF
        }
        
        //if normal line in 2rd quater
        if (normalLine.startPoint.x > normalLine.endPoint.x && normalLine.startPoint.y >= normalLine.endPoint.y) {
            angleRight += angleF
            angleLeft += angleF
            k = -1
        }
        
        //if normal line in 3rd quater
        if (normalLine.startPoint.x <= normalLine.endPoint.x && normalLine.startPoint.y >= normalLine.endPoint.y) {
            angleRight -= angleF
            angleLeft -= angleF
            k = -1
        }
        
        //if normal line in 4th quater
        if (normalLine.startPoint.x <= normalLine.endPoint.x && normalLine.startPoint.y < normalLine.endPoint.y) {
            angleRight -= angleF
            angleLeft -= angleF
        }
        
        let x1 = length * cos(angleRight) + normalLine.endPoint.x
        let y1 = k * length * sin(angleRight) + normalLine.endPoint.y
        
        let x2 = length * cos(angleLeft) + normalLine.endPoint.x
        let y2 = k * length * sin(angleLeft) + normalLine.endPoint.y
        
        rightLine = Line(startPoint: normalLine.endPoint, endPoint: CGPointMake(x1, y1), strokeWidth: strokeWidth)
        leftLine = Line(startPoint: normalLine.endPoint, endPoint: CGPointMake(x2, y2), strokeWidth: strokeWidth)
    }
    
    func drawInContext(context: CGContextRef!, withColor color: UIColor! = UIColor.blackColor()) {
        self.leftLine.drawInContext(context, withColor: color)
        self.rightLine.drawInContext(context, withColor: color)
    }
   
}
