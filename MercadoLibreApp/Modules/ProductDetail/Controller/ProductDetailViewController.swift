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
    
    private lazy var productImage: UIImageView = {
        let aImage = UIImageView()
        aImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aImage)
        aImage.contentMode = .scaleAspectFit
        aImage.clipsToBounds = true
        return aImage
    }()
    
    private lazy var productTitle: UILabel = {
        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.numberOfLines = 0
        view.addSubview(aLabel)
        aLabel.textAlignment = .center
        return aLabel
    }()
    
    private lazy var productPrice: UILabel = {
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
            productImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor, multiplier: 1),
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
        guard let price = product.price else {return}
        productPrice.text = "$\(price)"
        if let url = product.thumbnail {
            productImage.loadImage(url: url)
        }
        setupView()
    }
}

