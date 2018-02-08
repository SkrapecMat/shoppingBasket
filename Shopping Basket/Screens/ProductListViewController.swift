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
    @IBOutlet weak var totalPriceLabel: UILabel!

    private var productRepository = InMemoryProductRepository()
    private var basket = Basket()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        setupTable()
        setTotalPrice()
    }

    // MARK: Setup methods

    private func setupTable() {
        productsTable.register(UINib(nibName: ProductTableViewCell.cellIdentifier(),
                                     bundle: nil),
                               forCellReuseIdentifier: ProductTableViewCell.cellIdentifier())
        productsTable.dataSource = self
    }

    private func setTotalPrice() {
        totalPriceLabel.text = basket.totalPriceInUSDollars.toString()
    }

    // MARK: UI methods

    private func setNavBarTitle() {
        self.navigationController?.setupTitle(withTitle:
            NSLocalizedString("PRODUCT_LIST_VC__TITLE", comment: ""))
    }

    // MARK: Actions

    @IBAction func didPressToBasket(_ sender: UIButton) {

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
