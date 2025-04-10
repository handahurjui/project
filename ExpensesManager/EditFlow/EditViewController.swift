//
//  AddViewController.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

class EditViewController: UIViewController, Storyboarded  {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var viewModel: EditViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    var expenseContainer: ExpenseContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
        
        configureUIViews()
    }
    func configureUIViews() {
        guard let expenseDataView = expenseContainer.expense else { return }
        titleTextField.text = expenseDataView.title
        descriptionTextView.text = expenseDataView.descriptionData
        imageView.image = UIImage(data: expenseDataView.image!)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "",
              let description = descriptionTextView.text, description != "",
              let image = imageView.image?.toData(),
              let currentExpense = expenseContainer.expense
        else {
            AlertPresenter.shared.present(title: "Save entry", message: "Clould not save entry,please add content", on: self)
            return
        }
        let expense = ExpenseModel(id: currentExpense.id, title: title, descriptionData: description, createdDate: Date(), image: image)
        expenseContainer.expense = expense
        viewModel.editExpense(expenseContainer: expenseContainer)
    }
}
extension EditViewController: EditViewModelDelegate {
    func showError(errorMessage: String) {
        DispatchQueue.main.async {
            AlertPresenter.shared.present(title: "Error",
                                          message: errorMessage,
                                          on: self)
        }
    }
}
