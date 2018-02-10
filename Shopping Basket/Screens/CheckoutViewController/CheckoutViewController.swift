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
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!

    private let currencyService = JSONRatesCurrencyService()

    var basket: Basket?
    private var currencies: [Currency] = [] {
        didSet {
            currencies.sort { $0.isoCode < $1.isoCode }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()

        if let totalPrice = basket?.totalPriceInUSDollars {
            setupTotalPrice(price: totalPrice)
        }

        setupTable()
        fetchCurrencies()

        spinnerView.isHidden = true
    }

    // MARK: Setup methods
    private func setupTable() {
        currenciesTable.register(UINib(nibName: CheckoutTableViewCell.cellIdentifier(),
                            bundle: nil),
                      forCellReuseIdentifier: CheckoutTableViewCell.cellIdentifier())
        currenciesTable.dataSource = self
        //to remove empty table lines
        currenciesTable.tableFooterView = UIView()
    }

    private func setupTotalPrice(price: Money) {
        totalPriceLabel.text = price.toString()
    }

    // MARK: UI methods
    private func setNavBarTitle() {
        self.navigationItem.setupTitle(withText:
            NSLocalizedString("CHECKOUT_VC__TITLE", comment: ""))
    }

    // MARK: Networking
    private func fetchCurrencies() {
        showSpinner()
        currencyService.getAvailableCurrencies({ [weak self] (currencies) in
            self?.currencies = currencies
            DispatchQueue.main.async {
                self?.currenciesTable.reloadData()
                self?.hideSpinner()
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.hideSpinner()
            }
        }
    }

    // MARK: Actions
    @IBAction func pressedClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: Spinner methods
    private func showSpinner() {
        spinnerView.isHidden = false
        spinnerView.startAnimating()
    }

    private func hideSpinner() {
        spinnerView.stopAnimating()
        spinnerView.isHidden = true
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
