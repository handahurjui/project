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
        title = "History"
        
        guard let vm = viewModel else { return }
        let listController = UIHostingController(
          rootView:
            ExpensesHistory(viewModel: vm.storage)
        )
        view.pinView(listController.view)
        addChild(listController)
        listController.didMove(toParent: self)
    }
}
