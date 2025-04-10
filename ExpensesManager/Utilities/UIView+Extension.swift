//
//  UIView+Autolayout.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import UIKit

//MARK: Autolayout
extension UIView {
  public func pinView(_ child: UIView, padding: UIEdgeInsets = .zero) {
    child.translatesAutoresizingMaskIntoConstraints = false
    addSubview(child)
    NSLayoutConstraint.activate([
      child.leadingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.leadingAnchor,
        constant: padding.left
      ),
      child.trailingAnchor.constraint(
        equalTo: safeAreaLayoutGuide.trailingAnchor,
        constant: padding.right
      ),
      child.topAnchor.constraint(
        equalTo: safeAreaLayoutGuide.topAnchor,
        constant: padding.top
      ),
      child.bottomAnchor.constraint(
        equalTo: safeAreaLayoutGuide.bottomAnchor,
        constant: padding.bottom
      )
    ])
  }
}

extension UIView {
    func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }
        return view
    }
}
