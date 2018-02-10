//
//  CheckoutViewController.swift
//  Shopping Basket
//
//  Created by Mateja Škrapec on 10/02/2018.
//  Copyright © 2018 Mateja Škrapec. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var currenciesTable: UITableView!

    var basket: Basket?
    private var currencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let totalPrice = basket?.totalPriceInUSDollars {
            setupTotalPrice(price: totalPrice)
        }

        setupTable()
        fetchCurrencies()
    }

    // MARK: Setup methods
    private func setupTable() {
        currenciesTable.register(UINib(nibName: CheckoutTableViewCell.cellIdentifier(),
                            bundle: nil),
                      forCellReuseIdentifier: CheckoutTableViewCell.cellIdentifier())
        currenciesTable.dataSource = self
    }

    private func setupTotalPrice(price: Money) {
        totalPriceLabel.text = price.toString()
    }

    // MARK: Networking
    private func fetchCurrencies() {
        let currencyService = JSONRatesCurrencyService()
        currencyService.getAvailableCurrencies({ [weak self] (currencies) in
            self?.currencies = currencies
            DispatchQueue.main.async {
                self?.currenciesTable.reloadData()
            }
        }) { (error) in

        }
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutTableViewCell.cellIdentifier(), for: indexPath)
            as? CheckoutTableViewCell else {
            return UITableViewCell()
        }

        let viewModel = CheckoutTableViewCellViewModel(currencies[indexPath.row])
        cell.configure(withViewModel: viewModel)
        return cell
    }
}
