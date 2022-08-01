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
    let cellIdentifier = "cellIdentifier"
    var service = ProductListService()
    var viewMargin: CGFloat = 20
    
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
        title = "Busqueda"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productSearchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            productSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            productListTableView.topAnchor.constraint(equalTo: productSearchBar.bottomAnchor, constant: viewMargin),
            productListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductListViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else { return }
        service.getList(query: text) { [weak self] data in
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


