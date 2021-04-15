//
//  UIImageView+.swift
//  TheMovies
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import UIKit

extension UIImageView {
    convenience init(_ image: UIImage? = nil, contentMode: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = contentMode
    }
}
