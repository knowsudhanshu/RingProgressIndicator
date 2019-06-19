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
        let view = BadgeView(image: "http://ichef.bbci.co.uk/news/976/cpsprodpb/12787/production/_95455657_3312a880-230e-474c-b1d9-bb7c94f8b00e.jpg", fromValue: 0)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(badgeImageView)
        badgeImageView.centerInSuperview()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.badgeImageView.update(value: 0.25, animated: true)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        badgeImageView.prepare()
        badgeImageView.update(value: 0.5, animated: true)
    }
}


extension UIView {
    func centerInSuperview(with offset: CGFloat = 0) {
        guard let superview = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: offset).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: offset).isActive = true
    }
    
    // Autolayout - Anchors
    func fillSuperview(_ margin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -margin),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: margin),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margin)
            ])
    }
}
