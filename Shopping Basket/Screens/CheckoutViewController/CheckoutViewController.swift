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
    @IBOutlet weak var searchWrapperView: UIView!

    private let currencyService = JSONRatesCurrencyService()

    private let searchController = UISearchController(
        searchResultsController: nil)

    var basket: Basket?
    private var currencies: [Currency] = [] {
        didSet {
            currencies.sort { $0.isoCode < $1.isoCode }
        }
    }
    private var filteredCurrencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()

        if let totalPrice = basket?.totalPriceInUSDollars {
            setupTotalPrice(price: totalPrice)
        }

        setupTable()
        fetchCurrencies()
        setupSearchViewController()

        spinnerView.isHidden = true
    }

    // MARK: Setup methods
    private func setupTable() {
        currenciesTable.register(UINib(nibName: CheckoutTableViewCell.cellIdentifier(),
                            bundle: nil),
                      forCellReuseIdentifier: CheckoutTableViewCell.cellIdentifier())

        currenciesTable.dataSource = self
        currenciesTable.delegate = self

        //to hide keyboard when search is opened
        currenciesTable.keyboardDismissMode = .onDrag

        //to remove empty table lines
        currenciesTable.tableFooterView = UIView()
    }

    private func setupTotalPrice(price: Money) {
        totalPriceLabel.text = price.toString()
    }

    private func setupSearchViewController() {

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true

        searchWrapperView.addSubview(searchController.searchBar)

        //UI setup
        searchController.searchBar.placeholder = NSLocalizedString("CHECKOUT_VC__SEARCH_TEXT", comment: "")
        searchController.searchBar.tintColor = UIColor.titleColor
        searchController.searchBar.barTintColor = UIColor.lightBackgroundColor
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
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.hideSpinner()
                self?.showErrorAlert()
            }
        }
    }

    private func fetchConversionRate(for currency: Currency) {

        guard let totalPrice = basket?.totalPriceInUSDollars else {
            return
        }

        showSpinner()
        currencyService.getConversionRate(to: currency.isoCode,
                                          success: { [weak self] (rate) in
            let convertedPrice = totalPrice.convert(to: currency, withConversionRate: rate)

            DispatchQueue.main.async {
                self?.setupTotalPrice(price: convertedPrice)
                self?.hideSpinner()
            }

        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.hideSpinner()
                self?.showErrorAlert()
            }
        }
    }

    // MARK: Actions

    @IBAction func pressedClose(_ sender: UIBarButtonItem) {
        searchController.isActive = false
        dismiss(animated: true, completion: nil)
    }

    // MARK: Spinner methods

    private func showSpinner() {
        spinnerView.isHidden = false
        spinnerView.startAnimating()
        view.isUserInteractionEnabled = false
    }

    private func hideSpinner() {
        spinnerView.stopAnimating()
        spinnerView.isHidden = true
        view.isUserInteractionEnabled = true
    }

    // MARK: Error Handling

    private func showErrorAlert() {
        let alertController = UIAlertController(
            title: NSLocalizedString("GENERAL_ERROR_ALERT_TITLE", comment: ""),
            message: NSLocalizedString("GENERAL_ERROR_ALERT_TEXT", comment: ""),
            preferredStyle: .alert)

        let okAction = UIAlertAction(
            title: NSLocalizedString("GENERAL_ERROR_ALERT_BUTTON", comment: ""),
            style: .default, handler: nil)

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Search Helper

    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredCurrencies = currencies.filter({(currency: Currency) -> Bool in
            if currency.name.lowercased().contains(searchText.lowercased()) ||
                currency.isoCode.lowercased().contains(searchText.lowercased()) {
                return true
            }
            return false
        })

        currenciesTable.reloadData()
    }

    private func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    private func getCurrencyAtIndex(_ index: Int) -> Currency {
        if isFiltering() {
            return filteredCurrencies[index]
        } else {
            return currencies[index]
        }
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCurrencies.count
        }
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutTableViewCell.cellIdentifier(), for: indexPath)
            as? CheckoutTableViewCell else {
            return UITableViewCell()
        }

        let currency = getCurrencyAtIndex(indexPath.row)
        let viewModel = CheckoutTableViewCellViewModel(currency)
        cell.configure(withViewModel: viewModel)
        return cell
    }
}

extension CheckoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let convertToCurrency = getCurrencyAtIndex(indexPath.row)
        fetchConversionRate(for: convertToCurrency)
    }
}

// MARK: UISearchResultsUpdating Delegate
extension CheckoutViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(text)
        }
    }
}
