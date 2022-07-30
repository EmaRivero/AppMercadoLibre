//
//  ProductDetailViewController.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 29/07/2022.
//

import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    
    lazy var productImage: UIImageView = {
        let aImage = UIImageView()
        aImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aImage)
        aImage.contentMode = .scaleAspectFit
        aImage.clipsToBounds = true
        return aImage
    }()
    
    lazy var productTitle: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.numberOfLines = 0
        view.addSubview(aLabel)
        return aLabel
    }()
    
    lazy var productPrice: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aLabel)
        return aLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupConstraints()
        view.backgroundColor = .systemYellow
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImage.widthAnchor.constraint(equalToConstant: 300),
            productImage.heightAnchor.constraint(equalToConstant: 300),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            productPrice.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            productPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            productTitle.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 40),
            productTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            productTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
}
