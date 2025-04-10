//
//  DetailsView.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func didTapSaveBtn()
    func didTapTakePhotoBtn()
}

class DetailsView: XibView {
    
    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet {
            descriptionTextView.delegate =  self
        }
    }
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    weak var delegate: DetailsViewDelegate?
    
    //MARK: Propertie
    private let descriptionPlaceHolderText = "Write description of your photo"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func configureView() {
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        delegate?.didTapSaveBtn()
    }
    
    @IBAction func takePhotoBtnTapped(_ sender: Any) {
        delegate?.didTapTakePhotoBtn()
    }
}

//MARK: - UITextViewDelegate
extension DetailsView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if !descriptionTextView.text!.isEmpty && descriptionTextView.text! == descriptionPlaceHolderText {
            descriptionTextView.text = ""
            descriptionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTextView.text.isEmpty {
            descriptionTextView.text = descriptionPlaceHolderText
            descriptionTextView.textColor = .lightGray
        }
    }
}
