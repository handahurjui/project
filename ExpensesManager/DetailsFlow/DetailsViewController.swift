//
//  DetailsViewController.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//


import UIKit

class DetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var detailsView: DetailsView!
    
    var expenseDataView: ExpenseDataView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIViews()
        // Do any additional setup after loading the view.
    }
    
    func configureUIViews() {
        detailsView.accessibilityIdentifier = "detailsView"
        detailsView.titleTextField.accessibilityLabel = "titleLabel"
        detailsView.descriptionTextView.accessibilityLabel = "descriptionTextView"
        
        detailsView.titleTextField.isUserInteractionEnabled = false
        detailsView.descriptionTextView.isUserInteractionEnabled = false
        
        detailsView.saveBtn.isHidden = true
        detailsView.takePhotoBtn.isHidden =  true
        
        detailsView.titleTextField.text = expenseDataView.title
        detailsView.descriptionTextView.text = expenseDataView.descriptionData
        detailsView.imageView.image = UIImage(data: expenseDataView.image)
    }
}
