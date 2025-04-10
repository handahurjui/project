//
//  SecVC.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import SwiftUI

class HistoryViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var viewModel: HistoryViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    private let cellReuseID = "expenses"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadExpenses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        tableView.accessibilityLabel = "tableView"
        setupNavigationBar()
//        createSwiftUIList()
    }

    // MARK: Functions
    private func createSwiftUIList() {
        guard let vm = viewModel else { return }
        let expensesHistoryVM = ExpensesHistoryViewModel(storage: vm.storage)
        let listController = UIHostingController(
          rootView:
            ExpensesHistory(viewModel: expensesHistoryVM)
        )
        view.pinView(listController.view)
        addChild(listController)
        listController.didMove(toParent: self)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addBtnTapped))
    }
    
    @objc private func addBtnTapped() {
        viewModel.addBtnTapped(controller: self)
    }
}

//MARK: TableView Delegate & Data Source
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseID)
        let cellData = viewModel.cellDataFor(row: indexPath.row)
        cell.textLabel?.text = cellData.title
        cell.detailTextLabel?.text = cellData.createdDate
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

//MARK: TableView Events
extension HistoryViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let deletetAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] _,_,_ in
            guard let self else { return }
            self.viewModel.deleteBtnTapped(row: indexPath)
        }
        deletetAction.backgroundColor = .red
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _,_,_ in
            guard let self else { return }
            self.viewModel.editBtnTapped(row: indexPath, controller: self)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deletetAction, editAction])
        return swipeActions
    }
}

// MARK: - ViewModel Delegate
extension HistoryViewController: HistoryViewModelDelegate {
    func refreshScreen() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            AlertPresenter.shared.present(title: "Error",
                                              message: errorMessage,
                                              on: self)
        }
    }
}
