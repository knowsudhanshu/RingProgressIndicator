//
//  ViewController.swift
//  RingProgressIndicator
//
//  Created by Sudhanshu Sudhanshu on 18/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let badgeImageView: BadgeView = {
        let imageView = BadgeView(image: UIImage(named: "mypic"), fromValue: 0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(badgeImageView)
        badgeImageView.centerInSuperview()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.badgeImageView.update(value: 0.25, animated: true)
        }
    }
}

class BadgeView: UIImageView, RingProgress {
    
    var fromValue: CGFloat
    var toValue: CGFloat
    
    
    override init(image: UIImage?) {
        self.fromValue = 0
        self.toValue = 0
        super.init(image: image)
    }
    
    convenience init(image: UIImage?, fromValue: CGFloat) {
        self.init(image: image)
        self.fromValue = fromValue
        self.prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol RingProgress where Self: UIView {
    var fromValue: CGFloat{get set}
    var toValue: CGFloat{get set}
}

extension RingProgress {
    
    func prepare(_ value: CGFloat = 0) {
        
        self.backgroundColor = .yellow
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        drawShapeLayer(value: value)
    }
    
    func drawShapeLayer(value: CGFloat, animated: Bool = true) {
        
        let radius = self.bounds.height / 2
        self.layer.cornerRadius = radius
        
        let lineWidth: CGFloat = 4
        
        let offset: CGFloat = (.pi / 2)
        let startAngle: CGFloat = -offset
        
        let defaultFullCircleAngle: CGFloat = (2 * .pi)
        let endAngle: CGFloat = defaultFullCircleAngle * value - offset
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        let cgCircle = circle.cgPath
        shapeLayer.path = cgCircle
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = lineWidth
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
        drawShapeLayer(value: value, animated: animated)
    }
}


extension UIView {
    func centerInSuperview(with offset: CGFloat = 0) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset).isActive = true
    }
}
