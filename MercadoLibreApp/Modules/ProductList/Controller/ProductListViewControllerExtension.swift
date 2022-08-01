//
//  ProductListViewControllerExtension.swift
//  MercadoLibreApp
//
//  Created by Ema Rivero on 01/08/2022.
//

import UIKit

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = ProductDetailViewController()
        detailViewController.setupProduct(product: list[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

