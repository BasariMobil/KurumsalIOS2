//
//  UIView+.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

extension UIView {

    func add(subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
