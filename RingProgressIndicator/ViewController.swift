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
        let imageView = BadgeView(image: UIImage(named: "mypic"))
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
        badgeImageView.setupRing()
        print(badgeImageView)
        
    }
}

class BadgeView: UIImageView, RingProgress {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol RingProgress where Self: UIView {}

extension RingProgress {
    func setupRing(animated: Bool = true) {
        self.backgroundColor = .yellow
        self.clipsToBounds = true
        self.backgroundColor = .clear
        
        let radius = self.bounds.height / 2
        self.layer.cornerRadius = radius

        let lineWidth: CGFloat = 4
        
        let startAngle: CGFloat = -(.pi / 2)
        let endAngle: CGFloat = .pi//(.pi * 3/2)
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
            drawingAnimation.damping = 9
            drawingAnimation.initialVelocity = 2
            drawingAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            shapeLayer.add(drawingAnimation, forKey: "drawRing")
        }
        
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
