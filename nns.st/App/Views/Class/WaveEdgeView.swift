//
//  WaveEdgeView.swift
//  nns.st
//
//  Created by SHOHE on 2018/12/22.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class WaveEdgeView: UIView {
    
    private var points: [CGPoint] = []
    private var outLinePoints: [CGPoint] = []
    private var inLinePoints: [CGPoint] = []
    private var shapeLayer = CAShapeLayer()
    private let waveAnimation = CABasicAnimation(keyPath: "path")
    private let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    private let animationGroup = CAAnimationGroup()
    private var isFirst: Bool = true
    
    @IBInspectable var fillColor: UIColor = UIColor.init(hex: "427FC5", alpha: 0.6)
    @IBInspectable var corner: Int = 7
    @IBInspectable var max: CGFloat = 15.0
    @IBInspectable var isReverse: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override func draw(_ rect: CGRect) {
        self.points = initPoints(r: Double(frame.width*0.5), corner: corner)
        self.outLinePoints = initPoints(r: Double((frame.width+max)*0.5), corner: corner)
        self.inLinePoints = initPoints(r: Double((frame.width-max)*0.5), corner: corner)

        initShapeLayer()
        animatePath()
    }
    
    override func layoutSubviews() { }
    
    
    private func initView() {
        backgroundColor = UIColor.clear
        waveAnimation.delegate = self
    }
    
    private func initPoints(r: Double, corner: Int) -> [CGPoint] {
        var points: [CGPoint] = []
        let center = CGPoint(x: frame.width/2, y: frame.height/2)
        let angle: Double = 360.0 / Double(corner)
        
        for i in stride(from: 0.0, to: 360.0, by: angle) {
            let radian = Double.pi * i / Double(180.0)
            points.append(CGPoint(x: r*cos(radian)+Double(center.x), y: r*sin(radian)+Double(center.y)))
        }
        return points
    }
    
    private func initShapeLayer() {
        updateShapeLayer()
        layer.sublayers = nil
        layer.addSublayer(shapeLayer)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.cornerRadius = 5.0
    }
    
    
    private func currentPath() -> CGPath {
        let path = UIBezierPath(roundedPolygon: points, ratio: 0.7)
        path.close()
        
        return path.cgPath
    }
    
    private func updateShapeLayer() {
        shapeLayer.path = currentPath()
    }
    
    private func updatePath() {
        for (index, _) in points.enumerated() {
            if (index % 2 == 0) {
                points[index] = (isFirst) ? outLinePoints[index] : inLinePoints[index]
            } else {
                points[index] = (isFirst) ? inLinePoints[index] : outLinePoints[index]
            }
        }

        isFirst = !isFirst
    }
    
    private func animatePath() {
        animateWave()
        animateRotation()
    }
    
    private func animateWave() {
        shapeLayer.removeAnimation(forKey: waveAnimation.keyPath!)
        waveAnimation.duration = 1
        waveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        waveAnimation.fillMode = kCAFillModeBoth
        waveAnimation.isRemovedOnCompletion = false
        
        waveAnimation.fromValue = shapeLayer.path
        updatePath()
        updateShapeLayer()
        waveAnimation.toValue = currentPath()
        
        shapeLayer.add(waveAnimation, forKey: waveAnimation.keyPath)
    }
    
    private func animateRotation() {
        rotateAnimation.duration = 5
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = isReverse ? CGFloat.pi * -2.0 : CGFloat.pi * 2.0
        rotateAnimation.fillMode = kCAFillModeForwards
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.repeatCount = .infinity
        layer.add(rotateAnimation, forKey: rotateAnimation.keyPath)
    }

}

extension WaveEdgeView : CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag { animateWave() }
    }
    
}
