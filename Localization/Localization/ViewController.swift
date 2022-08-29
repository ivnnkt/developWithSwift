//
//  ViewController.swift
//  Localization
//
//  Created by Nikita on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showText() {
        label.text = NSLocalizedString("ViewController.label.text", comment: "title text on the main screen.")
    }
    
    @IBAction func showAlertView() {
        
        guard let alertView = Bundle.main.loadNibNamed("AlertView", owner: nil, options: nil)?.first as? AlertView else { return }
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.frame = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
        let alertTitle = NSLocalizedString("ViewController.Alert.title", comment: "title text on custom alert")
        let alertButtonTitle = NSLocalizedString("ViewController.Alert.button", comment: "button title on custom alert")
        alertView.configure(alertTitle, buttomTitle: alertButtonTitle)
        alertView.delegate = self
        
        view.addSubview(alertView)
        
        NSLayoutConstraint.activate([alertView.leftAnchor.constraint(equalTo: view.leftAnchor), alertView.rightAnchor.constraint(equalTo: view.rightAnchor), alertView.topAnchor.constraint(equalTo: view.topAnchor), alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        

        
    }
    
}

extension ViewController: AlertViewDelegate {
    func didCloseView(_ view: AlertView) {
        print("did tap")
    }
}

