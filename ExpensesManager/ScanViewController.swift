//
//  ScanViewController.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import VisionKit

class ScanViewController: UIViewController, Storyboarded {

    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scan"
           
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - Action
    @IBAction private func tapped(scan button: UIButton) {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        present(scanner, animated: true)
    }
    
    //MARK: - Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset.bottom = keyboardHeight
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension ScanViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = scan.imageOfPage(at: 0)
            
            guard let self = self else { return }
            AlertPresenter.shared.present(title: "Success!", message: "Document \(scan.title) scanned with \(scan.pageCount) pages.", on: self)
        }
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = nil
            
            guard let self else { return }
            AlertPresenter.shared.present(title: "Cancelled", message: "User cancelled the scanning process.", on: self)
        }
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        controller.dismiss(animated: true) { [weak self] in
            self?.imageView.image = nil
            
            guard let self else { return }
            AlertPresenter.shared.present(title: "Error", message: error.localizedDescription, on: self)
        }
    }
}
