//
//  Alert.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

import UIKit

protocol Alert {
    func present(title: String, message: String, on vc: UIViewController)
}

class AlertPresenter: Alert {
    
    static let shared = AlertPresenter()
    
    func present(title: String, message: String, on vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
