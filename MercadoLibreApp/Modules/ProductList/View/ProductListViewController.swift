//
//  ProductListViewController.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 28/07/2022.
//

import UIKit
import Alamofire

class ProductListViewController: UIViewController {
    
    var list: [Product] = []
    
    private lazy var productSearchBar: UISearchBar = {
        let aSearch = UISearchBar()
        aSearch.delegate = self
        aSearch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aSearch)
        return aSearch
    }()
    
    private lazy var productListTableView: UITableView = {
        let aTable = UITableView()
        aTable.translatesAutoresizingMaskIntoConstraints = false
        aTable.dataSource = self
        aTable.delegate = self
        aTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        title = "Busqueda"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productSearchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            productSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            productListTableView.topAnchor.constraint(equalTo: productSearchBar.bottomAnchor, constant: 20),
            productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = ProductDetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        
        detailViewController.productPrice.text = list[indexPath.row].price?.description
        detailViewController.productTitle.text = list[indexPath.row].title
        if let url = list[indexPath.row].thumbnail {
            detailViewController.productImage.loadImage(url: url)
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else { return }
        ApiManager.shared.getList(query: text) { [weak self] data in
            self?.list = data
            DispatchQueue.main.async {
                self?.productListTableView.reloadData()
            }
        }
    }
}
