//
//  ExpenseItemView.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//


import SwiftUI

struct ExpenseItemView: View {
    let expense: ExpenseProtocol
    
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

struct ExpenseItemView_Previews: PreviewProvider {
    struct PreviewExpense: ExpenseProtocol {
        var title: String? = "Preview Title"
        var descriptionData: String? = "Description text for preview"
        var createdDate: Date? = Date()
        var image: Data? = (UIImage(systemName: "archivebox")?.pngData())!
        var id: UUID? = UUID()
    }
    
    static var previews: some View {
        ExpenseItemView(expense: PreviewExpense())
    }
}

