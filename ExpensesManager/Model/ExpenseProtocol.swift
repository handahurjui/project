//
//  ExpenseProtocol.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation

protocol ExpenseProtocol {
    var id: UUID? { get }
    var title: String? { get }
    var descriptionData: String? { get }
    var createdDate: Date? { get }
    var image: Data? { get }
}
