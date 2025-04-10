//
//  AddViewController.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

class EditViewController: UIViewController, Storyboarded  {

    @IBOutlet weak var detailsView: DetailsView!{
        didSet {
            detailsView.delegate = self
        }
    }
    var historyVM: HistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
extension EditViewController: DetailsViewDelegate {
    func didTapSaveBtn() {
        
    }
    
    func didTapTakePhotoBtn() {
        
    }
    
    
}
