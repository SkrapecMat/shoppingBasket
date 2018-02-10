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

    override func viewDidLoad() {
        super.viewDidLoad()

        if let totalPrice = basket?.totalPriceInUSDollars {
            setupTotalPrice(price: totalPrice)
        }
    }

    private func setupTotalPrice(price: Money) {
        totalPriceLabel.text = price.toString()
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
