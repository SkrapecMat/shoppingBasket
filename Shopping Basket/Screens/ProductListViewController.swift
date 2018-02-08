//
//  ViewController.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productsTable: UITableView!

    private var productRepository = InMemoryProductRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }

    private func setupTable() {
        productsTable.register(UINib(nibName: ProductTableViewCell.cellIdentifier(),
                                     bundle: nil),
                               forCellReuseIdentifier: ProductTableViewCell.cellIdentifier())
        productsTable.dataSource = self
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productRepository.total()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellIdentifier(), for: indexPath)
            as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let products = productRepository.getAll()
        let viewModel = ProductTableViewCellViewModel(products[indexPath.row])
        cell.configure(with: viewModel)

        return cell
    }
}
