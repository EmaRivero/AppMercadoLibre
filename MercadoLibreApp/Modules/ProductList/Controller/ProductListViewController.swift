//
//  ProductListViewController.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 28/07/2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var list: [Product] = []
    let cellIdentifier = "cellIdentifier"
    var model = ProductListModel()
    var viewMargin: CGFloat = 20
    
    private lazy var productSearchBar: UISearchBar = {
        let aSearch = UISearchBar()
        aSearch.delegate = self
        aSearch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aSearch)
        return aSearch
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buscar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.tintColor = .white
        view.addSubview(button)
        return button
    }()
    
    private lazy var productListTableView: UITableView = {
        let aTable = UITableView()
        aTable.translatesAutoresizingMaskIntoConstraints = false
        aTable.dataSource = self
        aTable.delegate = self
        aTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(aTable)
        return aTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupConstraints()
        productSearchBar.barTintColor = .systemYellow
        productListTableView.separatorColor = .systemYellow
        searchButton.backgroundColor = .systemBlue
        searchButton.addTarget(self, action: #selector(findProduct), for: .touchUpInside)
        title = "Busqueda"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            
            productSearchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            productSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productSearchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -viewMargin),
            
            searchButton.heightAnchor.constraint(equalTo: productSearchBar.heightAnchor),
            
            productListTableView.topAnchor.constraint(equalTo: productSearchBar.bottomAnchor, constant: viewMargin),
            productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    private func findProduct() {
        guard let text = productSearchBar.text else { return }
        model.getList(query: text) { [weak self] data in
            self?.list = data
            DispatchQueue.main.async {
                self?.productListTableView.reloadData()
            }
        } errorHandler: { [weak self] error in
            self?.showError(error)
        }
    }
    
    private func showError(_ error: Error?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProductListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        findProduct()
    }
}


