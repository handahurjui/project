//
//  SaveProtocol.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation

protocol SaveProtocol {
    func saveEntry(title: String, description: String, image: Data, completion: @escaping (Result<Bool, Error>) -> ())
}
