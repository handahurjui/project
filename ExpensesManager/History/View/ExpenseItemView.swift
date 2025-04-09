//
//  ExpenseItemView.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//


import SwiftUI

struct ExpenseItemView: View {
    let expense: ExpenseModel
    
    static let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(expense.title ?? "")
                Spacer()
            }
            Text(expense.descriptionData ?? "")
                .font(.caption)
            HStack {
                Text("\(expense.createdDate ?? Date(), formatter: Self.dateFormatter)")
                Spacer()
            }
        }
    }
}
