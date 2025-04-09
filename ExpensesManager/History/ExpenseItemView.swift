//
//  ExpenseItemView.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//


import SwiftUI

struct ExpenseItemView: View {
    let expense: Expense
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(expense.title ?? "")
                Spacer()
            }
            Text(expense.descriptionData ?? "")
                .font(.caption)
        }
    }
}
