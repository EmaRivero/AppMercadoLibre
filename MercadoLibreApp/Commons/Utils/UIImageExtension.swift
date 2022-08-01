//
//  UIImageExtension.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 29/07/2022.
//


import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
