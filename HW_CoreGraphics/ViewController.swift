//
//  ViewController.swift
//  HW_CoreGraphics
//
//  Created by Gena on 22.04.15.
//  Copyright (c) 2015 Gena. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func drawLinesInContext(context: CGContextRef!, lines: [Line], withColor color: UIColor = UIColor.brownColor()) {
        for line: Line in lines {
            line.drawInContext(context, withColor: color)
        }
    }
}

extension Int {
    func toBool() -> Bool {
        switch self {
        case 0:
            return false
        default:
            return true
        }
    }
}

struct Level {
    var lines = [Line]()
    
    init(lines: [Line]) {
        self.lines = lines
    }
    
    init() {
    }
    
    mutating func addLines(lines: [Line]) {
        for line in lines {
            self.lines.append(line)
        }
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var levels: [Level]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = self.drawTreeWithSize(self.view.frame.size, numberOfLevels: 9)
    }

    func drawTreeWithSize(size: CGSize, numberOfLevels: Int, startLength: CGFloat = 150) -> UIImage {
        assert(numberOfLevels > 0, "Tree must have at least one level")
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let startPoint = CGPointMake(self.view.frame.width / 2, self.view.frame.height)
        let endPoint = CGPointMake(startPoint.x, startPoint.y - startLength)
        let startLine = Line(startPoint: startPoint, endPoint: endPoint, strokeWidth: 8)
        startLine.drawInContext(context, withColor: UIColor.brownColor())
        
        levels = [Level(lines: [startLine])]
        
        for i in 1...numberOfLevels {
            var newLevel = Level()
            if let previousLevel: Level = levels?[i - 1] {
                for line in previousLevel.lines {
                    let branch = Branch(normalLine: line, angleBetweenLines: 50, percentageOfCompression: 35)
                    newLevel.addLines(branch.getLines())
                }
                self.drawLinesInContext(context, lines: newLevel.lines)
                self.levels!.append(newLevel)
            }
            
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }

}

