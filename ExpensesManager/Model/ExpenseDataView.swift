//
//  ExpenseDataView.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//


import Foundation

protocol ExpenseDataViewProtocol {
    var id: UUID { get }
    var title: String { get }
    var descriptionData: String { get }
    var createdDate: String { get }
    var image: Data { get }
}

struct ExpenseDataView: ExpenseDataViewProtocol {
    var id: UUID { return expense.id! }
    var title: String { return expense.title! }
    var descriptionData: String { return expense.descriptionData! }
    var createdDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.string(from: expense.createdDate ?? Date())
        return stringDate
    }
    var image: Data { return expense.image! }
        
    let expense: ExpenseModel
    
    init(expense: ExpenseModel) {
        self.expense = expense
    }
}
