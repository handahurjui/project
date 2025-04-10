//
//  ScanViewController.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import VisionKit

class ScanViewController: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet weak var detailsViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailsView: DetailsView! {
        didSet {
            detailsView.delegate = self
        }
    }
    
    
    //MARK: Properties
    var viewModel: ScanViewModel?
    private let descriptionPlaceHolderText = "Write description of your photo"
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scan"
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        configureUIViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    private func configureUIViews() {
        detailsView.titleTextField.text = ""
        detailsView.descriptionTextView.text = descriptionPlaceHolderText
        detailsView.imageView.image = UIImage(systemName: "photo.badge.magnifyingglass.fill")
    }
    
    //MARK: Keyboard notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] is CGRect {
            if let userInfo = notification.userInfo,
               let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
               let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
                detailsViewBottomConstraint.constant = keyboardFrame.height
                UIView.animate(withDuration: animationDuration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            detailsViewBottomConstraint.constant = 0
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - DetailsViewDelegate
extension ScanViewController: DetailsViewDelegate {
    func didTapSaveBtn() {
        guard let title = detailsView.titleTextField.text, title != "",
              let description = detailsView.descriptionTextView.text,
              description != descriptionPlaceHolderText,
              description != "",
              let image = detailsView.imageView.image?.toData()
        else {
            AlertPresenter.shared.present(title: "Save entry", message: "Clould not save entry,please add content", on: self)
            return
        }
        let expense = ExpenseModel(id: UUID(), title: title, descriptionData: description, createdDate: Date(), image: image)
        viewModel?.saveData(expense: expense)
    }
    
    func didTapTakePhotoBtn() {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        present(scanner, animated: true)
    }
}

//MARK: - VNDocumentCameraViewControllerDelegate
extension ScanViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true) { [weak self] in
            self?.detailsView.imageView.image = scan.imageOfPage(at: 0)
            
            guard let self = self else { return }
            AlertPresenter.shared.present(title: "Success!", message: "Document \(scan.title) scanned \(scan.pageCount) pages.", on: self)
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.detailsView.imageView.image = nil
            
            guard let self else { return }
            AlertPresenter.shared.present(title: "Cancelled", message: "User cancelled the scanning process.", on: self)
        }
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true) { [weak self] in
            self?.detailsView.imageView.image = nil
            
            guard let self else { return }
            AlertPresenter.shared.present(title: "Error", message: error.localizedDescription, on: self)
        }
    }
}


