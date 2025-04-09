//
//  ScanViewController.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit
import VisionKit

protocol ScanViewModelDataSource {
    
}

class ScanViewModel {
    var storage: ExpenseDataStorage
    
    init(storage: ExpenseDataStorage) {
        self.storage = storage
    }
    
    func loadData(completion: @escaping (Result<[Expense]?, Error>) -> ()) {
        storage.fetchEntry { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveData(title: String, description: String, image: UIImage) {
        storage.saveEntry(title: title, description: description, image: image.toData()!) { result in
            switch result {
            case .success(let response):
                print("Successful saved")
            case .failure(let error):
                print("Clould not save")
            }
        }
    }
}

class ScanViewController: UIViewController, Storyboarded {

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
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
        
        configureUIViews()
        viewModel?.loadData(completion: { result in
            switch result {
            case .success(let response):
                if let item = response?.first as? Expense {
                    self.imageView.image = UIImage(data: item.image!)
                    self.titleTextField.text = item.title
                    self.descriptionTextView.text = item.descriptionData
                }
            case .failure(let error):
                print("could not retrieve entity")
            }
        })
    }
    
    private func configureUIViews() {
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.black.cgColor
        descriptionTextView.layer.borderWidth = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadData(completion: { result in
            switch result {
            case .success(let response):
                if let item = response?.first as? Expense {
                    self.imageView.image = UIImage(data: item.image!)
                    self.titleTextField.text = item.title
                    self.descriptionTextView.text = item.descriptionData
                }
            case .failure(let error):
                if let error = error as NSError? {
                  print("Could not retrieve entity \(error), \(error.userInfo)")
                }
            }
        })
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    // MARK: - Action
    @IBAction private func takePhotoBtnTapped(scan button: UIButton) {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = self
        present(scanner, animated: true)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        guard let title = titleTextField.text, title != "",
              let description = descriptionTextView.text, // check description text
              description != descriptionPlaceHolderText,
              description != "",
              let image = imageView.image
        else {
            AlertPresenter.shared.present(title: "Save entry", message: "Clould not save entry,please add content", on: self)
            return
        }
        viewModel?.saveData(title: title, description: description, image: image)
    }
    
    
    //MARK: - Methods
    

    //MARK: Keyboard notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
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

//MARK: - VNDocumentCameraViewControllerDelegate
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

//MARK: - UITextViewDelegate
extension ScanViewController: UITextViewDelegate {
    
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
