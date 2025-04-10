//
//  XibView.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

class XibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        configureView()
    }
    
    private func setupView() {
        let view = viewFromNibForClass()
        view.backgroundColor = .clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .clear
        addSubview(view)
    }
    
    func configureView() { }
}
