//
//  BadgeView.swift
//  RingProgressIndicator
//
//  Created by Sudhanshu Sudhanshu on 19/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class BadgeView: UIView, RingProgressable {
    
    var fromValue: CGFloat
    var toValue: CGFloat
    var style: RingStyle?
    
    let imageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    
    init(image link: String, margin: CGFloat = 16, fromValue: CGFloat) {
        
        self.fromValue = fromValue
        self.toValue = 0
        super.init(frame: .zero)
        
        let style = RingStyle(blankColor: UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0), fillColor: UIColor(red: 61/255, green: 91/255, blue: 86/255, alpha: 1.0))
        self.style = style
        if let imageURL = URL(string: link) {
            self.addSubview(imageView)
            imageView.fillSuperview(margin)
            
//            self.imageView.sd_setImage(with: imageURL)
        }
        
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGR.numberOfTapsRequired = 1
        addGestureRecognizer(tapGR)
    }
    
    func loadImage(_ link: String) {
        if let imageURL = URL(string: link) {
//            self.imageView.sd_setImage(with: imageURL)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func viewTapped() {
        self.layer.sublayers?.forEach({ (layer) in
            if let layer = layer as? CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        })
        self.prepare()
        self.update(value: .random(in: 0.25...1), animated: true)
    }
}
