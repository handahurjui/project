//
//  ExpensesHistory.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import SwiftUI
import Combine

struct ExpensesHistory: View {
    
    @ObservedObject var viewModel: ExpensesHistoryViewModel
    
    var body: some View {
        VStack {
          List {
              ForEach(viewModel.expenses, id: \.id) { item in
                  ExpenseItemView(expense: item)
            }
          }
        }
        .onAppear {
            viewModel.loadExpenses()
        }
    }
}
