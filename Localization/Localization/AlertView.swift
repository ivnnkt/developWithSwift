//
//  AlertView.swift
//  Localization
//
//  Created by Nikita on 29.08.2022.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func didCloseView(_ view: AlertView)
}

class AlertView: UIView {
    @IBOutlet weak var alertView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    
    weak var delegate: AlertViewDelegate?
    
    func configure(_ text: String, buttomTitle: String) {
        okButton.setTitle(buttomTitle, for: .normal)
        okButton.layer.cornerRadius = 10
        titleLabel.text = text
        alertView.layer.cornerRadius = 18
    }

    @IBAction func closeView() {
        removeFromSuperview()
        delegate?.didCloseView(self)
    }
}
