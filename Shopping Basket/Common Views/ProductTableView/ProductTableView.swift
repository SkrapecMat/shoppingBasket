//
//  ProductTableView.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 09/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

protocol ProductTableViewDelegate: class {
    func getTotalAmountOfProduct(_ product: Product) -> Int
    func addProductToBasket(_ product: Product)
    func removeProductFromBasket(_ product: Product)
}

class ProductTableView: UITableView {

    weak var productsDelegate: ProductTableViewDelegate?

    private var products: [Product] = []

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setupTable()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTable()
    }

    // MARK: Setup methods
    private func setupTable() {
        self.register(UINib(nibName: ProductTableViewCell.cellIdentifier(),
                                     bundle: nil),
                               forCellReuseIdentifier: ProductTableViewCell.cellIdentifier())
        self.dataSource = self
    }

    // MARK: Public methods
    func reloadTable(withProducts products: [Product]) {
        self.products = products
        self.reloadData()
    }

    func setAmountForProducts(withUUID uuid: String, amount: Int) {
        guard let productIndex = products.index(where: { uuid == $0.uuid }) else {
            return
        }
        let indexPath = IndexPath(row: productIndex, section: 0)
        if let cell = self.cellForRow(at: indexPath) as? ProductTableViewCell {
            cell.setProductAmount(amount)
        }
    }
}

extension ProductTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellIdentifier(), for: indexPath)
            as? ProductTableViewCell else {
                return UITableViewCell()
        }

        let product = products[indexPath.row]
        guard let totalAmount = productsDelegate?.getTotalAmountOfProduct(
            product) else {
            return cell
        }

        let viewModel = ProductTableViewCellViewModel(product,
                                                      totalAmount: totalAmount)
        cell.configure(with: viewModel)
        cell.delegate = self

        return cell
    }

    // MARK: Helpers
    fileprivate func getProduct(displayedBy cell: ProductTableViewCell) -> Product? {
        guard let indexPath = self.indexPath(for: cell) else {
            return nil
        }

        return products[indexPath.row]
    }
}

extension ProductTableView: ProductTableViewCellDelegate {
    func addOneItem(_ sender: ProductTableViewCell) {
        if let product = getProduct(displayedBy: sender) {
            productsDelegate?.addProductToBasket(product)
        }
    }

    func removeOneItem(_ sender: ProductTableViewCell) {
        if let product = getProduct(displayedBy: sender) {
            productsDelegate?.removeProductFromBasket(product)
        }
    }
}
