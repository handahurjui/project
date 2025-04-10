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
        
        detailsView.titleTextField.text = expenseDataView.title
        detailsView.descriptionTextView.text = expenseDataView.descriptionData
        detailsView.imageView.image = UIImage(data: expenseDataView.image)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
