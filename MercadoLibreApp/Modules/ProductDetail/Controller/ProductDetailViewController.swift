//
//  ProductDetailViewController.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 29/07/2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var product: Product?
    var viewMargin: CGFloat = 20
    
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
        aLabel.textAlignment = .center
        return aLabel
    }()
    
    lazy var productPrice: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aLabel)
        aLabel.textAlignment = .center
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
            productImage.widthAnchor.constraint(equalToConstant: 240),
            productImage.heightAnchor.constraint(equalToConstant: 240),
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            productTitle.bottomAnchor.constraint(equalTo: productImage.topAnchor, constant: -viewMargin),
            productTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewMargin),
            productTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewMargin),
            
            productPrice.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: viewMargin),
            productPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    public func setupProduct(product: Product) {
        productTitle.text = product.title
        productPrice.text = product.price?.description
        if let url = product.thumbnail {
            productImage.loadImage(url: url)
        }
        setupView()
    }
}

