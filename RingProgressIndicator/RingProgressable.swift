//
//  RingProgressable.swift
//  RingProgressIndicator
//
//  Created by Sudhanshu Sudhanshu on 19/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

struct RingStyle {
    var blankColor: UIColor = .gray
    var fillColor: UIColor = .red
}

protocol RingProgressable where Self: UIView {
    var fromValue: CGFloat{get set}
    var toValue: CGFloat{get set}
    var style: RingStyle? { get set }
}

extension RingProgressable {
    
    func prepare(_ value: CGFloat = 0) {
        
        self.backgroundColor = .yellow
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        let radius = self.bounds.height / 2
        self.layer.cornerRadius = radius
        
        let shapeLayer = ringShapeLayer(with: style?.blankColor ?? .gray)
        self.layer.addSublayer(shapeLayer)
    }
    
    func fillRing(value: CGFloat, animated: Bool = true) {
        let shapeLayer = ringShapeLayer(with: style?.fillColor ?? .red, value: value)
        self.layer.addSublayer(shapeLayer)
        
        // Drawing Animation
        if animated {
            let drawingAnimation = CASpringAnimation(keyPath: "strokeEnd")
            drawingAnimation.fromValue = 0
            drawingAnimation.toValue = 1
            drawingAnimation.duration = 2
            drawingAnimation.damping = 9.5
            drawingAnimation.initialVelocity = 2
            drawingAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            shapeLayer.add(drawingAnimation, forKey: "drawRing")
        }
    }
    
    func update(value: CGFloat, animated: Bool = true) {
        
        guard 0...1 ~= value else {
            fatalError("RingProgress: value=\(value) out of range (0...1)")
        }
        fillRing(value: value, animated: animated)
    }
    
    
    func ringShapeLayer(with color: UIColor, value: CGFloat = 1) -> CAShapeLayer {
        
        let lineWidth: CGFloat = 12
        
        let offset: CGFloat = (.pi / 2)
        let startAngle: CGFloat = -offset
        
        let defaultFullCircleAngle: CGFloat = (2 * .pi)
        let endAngle: CGFloat = (defaultFullCircleAngle * value) - offset
        
        
        let radius = self.bounds.height / 2
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        let cgCircle = circle.cgPath
        shapeLayer.path = cgCircle
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        return shapeLayer
    }
    
}

