//
//  ViewController.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 06/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productsTable: ProductTableView!
    @IBOutlet weak var totalPriceLabel: UILabel!

    private var productRepository = InMemoryProductRepository()
    private var basket = Basket()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        setTotalPrice()

        productsTable.productsDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTable()
    }

    // MARK: Setup methods
    private func setupTable() {
        productsTable.reloadTable(withProducts: productRepository.getAll())
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

extension ProductListViewController: ProductTableViewDelegate {
    func getTotalAmountOfProduct(_ product: Product) -> Int {
        return basket.getTotalAmountOfProduct(product)
    }

    func addProductToBasket(_ product: Product) {
        let totalAmount = basket.add(product: product)
        productsTable.setAmountForProducts(withUUID: product.uuid,
                                           amount: totalAmount)
        setTotalPrice()
    }

    func removeProductFromBasket(_ product: Product) {
        let totalAmount = basket.remove(product: product)
        productsTable.setAmountForProducts(withUUID: product.uuid,
                                           amount: totalAmount)
        setTotalPrice()
    }
}
