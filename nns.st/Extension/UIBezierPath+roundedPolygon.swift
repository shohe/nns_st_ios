//
//  UIBezierPath+roundedPolygon.swift
//  nns.st
//
//  Created by SHOHE on 2018/12/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

extension UIBezierPath {
    
    public convenience init(roundedPolygon points: [CGPoint], ratio: CGFloat) {
        self.init()
        
        for i in 0 ..< points.count {
            var prev = i - 1
            if prev < 0 {
                prev = points.count - 1
            }
            
            var next = i + 1
            if next >= points.count {
                next = 0
            }
            
            let p1 = points[prev]
            let p2 = points[i]
            let p3 = points[next]
            
            let p12 = CGPoint(
                x: (p1.x + p2.x) / 2 * ratio + p2.x * (1 - ratio),
                y: (p1.y + p2.y) / 2 * ratio + p2.y * (1 - ratio)
            )
            let p23 = CGPoint(
                x: (p2.x + p3.x) / 2 * ratio + p2.x * (1 - ratio),
                y: (p2.y + p3.y) / 2 * ratio + p2.y * (1 - ratio)
            )
            
            if self.isEmpty {
                self.move(to: p12)
            } else {
                self.addLine(to: p12)
            }
            self.addQuadCurve(to: p23, controlPoint: p2)
        }
    }
    
}
