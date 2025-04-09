//
//  ExpensesHistoryViewModel.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation

class ExpensesHistoryViewModel: ObservableObject {
  @Published var expenses: [ExpenseProtocol] = []

  func loadExpenses() {
      assertionFailure("Missing ovveride")
  }
}
