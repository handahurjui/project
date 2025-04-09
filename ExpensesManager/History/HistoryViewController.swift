//
//  SecVC.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import SwiftUI

class HistoryViewModel {
    var storage: ExpenseDataStorage
    
    init(storage: ExpenseDataStorage) {
        self.storage = storage
    }
}

class HistoryViewController: UIViewController, Storyboarded {
    
    //MARK: Properties
    var viewModel: HistoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        
//        let expenseHistoryVM = ExpensesHistoryViewModel()
        let expenseHistoryVM = ExpenseDataStorage()
        let listController = UIHostingController(
          rootView:
            ExpensesHistory(viewModel: expenseHistoryVM)
        )
        view.pinView(listController.view)
        addChild(listController)
        listController.didMove(toParent: self)
    }
}
