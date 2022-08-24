//
//  SecondViewController.swift
//  CocoaPods
//
//  Created by Nikita on 24.08.2022.
//

import UIKit
import LTMorphingLabel

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lable = LTMorphingLabel(frame: CGRect(x: 120, y: 350, width: 450, height: 100))
        lable.text = "CocoaPods is Working!"
        lable.adjustsFontSizeToFitWidth = true
        lable.morphingEffect = .burn
        lable.morphingEnabled = true
        lable.morphingDuration = 3
        lable.morphingCharacterDelay = 0.3
        lable.start()
        view.addSubview(lable)
    }
}
