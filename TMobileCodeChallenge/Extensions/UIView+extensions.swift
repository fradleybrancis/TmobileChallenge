//
//  UIView+extensions.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/28/20.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
