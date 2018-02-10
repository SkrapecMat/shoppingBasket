//
//  BasketViewController.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 09/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var basketTable: ProductTableView!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var productRepository: InMemoryProductRepository?
    var basket: Basket?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        setTotalPrice()
        setupTable()

        basketTable.productsDelegate = self
    }

    // MARK: Setup methods
    private func setupTable() {
        if let products = productRepository?.getAll() {
            basketTable.reloadTable(withProducts: products)
        }
    }

    private func setTotalPrice() {
        totalPriceLabel.text = basket?.totalPriceInUSDollars.toString()
    }

    // MARK: UI methods
    private func setNavBarTitle() {
        self.navigationItem.setupTitle(withText:
            NSLocalizedString("BASKET_VC__TITLE", comment: ""))
    }
}

extension BasketViewController: ProductTableViewDelegate {
    func getTotalAmountOfProduct(_ product: Product) -> Int {
        if let amount = basket?.getTotalAmountOfProduct(product) {
            return amount
        }
        return 0
    }

    func addProductToBasket(_ product: Product) {
        guard let totalAmount = basket?.add(product: product) else {
            return
        }
        basketTable.setAmountForProducts(withUUID: product.uuid,
                                           amount: totalAmount)
        setTotalPrice()
    }

    func removeProductFromBasket(_ product: Product) {
        guard let totalAmount = basket?.remove(product: product) else {
            return
        }
        basketTable.setAmountForProducts(withUUID: product.uuid,
                                           amount: totalAmount)
        setTotalPrice()
    }
}
