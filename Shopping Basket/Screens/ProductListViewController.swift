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
    @IBOutlet weak var openBasketButton: PrimaryButton!
    
    private var productRepository = InMemoryProductRepository()
    private var basket = Basket()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()

        productsTable.productsDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTable()
        setTotalPrice()
    }

    // MARK: Setup methods
    private func setupTable() {
        productsTable.reloadTable(withProducts: productRepository.getAll())
        productsTable.canRemoveProductFromList = false
    }

    private func setTotalPrice() {
        totalPriceLabel.text = basket.totalPriceInUSDollars.toString()
        openBasketButton.isEnabled = !basket.totalPriceInUSDollars.equalsZero()
    }

    // MARK: UI methods
    private func setNavBarTitle() {
        self.navigationItem.setupTitle(withText:
            NSLocalizedString("PRODUCT_LIST_VC__TITLE", comment: ""))
    }

    // MARK: Segue methods
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool {
        if identifier == "BasketSegue"
            && basket.totalPriceInUSDollars.equalsZero() {
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let basketVC = segue.destination as? BasketViewController {
            basketVC.basket = basket
        }
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
