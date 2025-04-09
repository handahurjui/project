//
//  SecVC.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import SwiftUI

class HistoryViewController: UIViewController, Storyboarded {
    
    //MARK: Properties
    var viewModel: HistoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
