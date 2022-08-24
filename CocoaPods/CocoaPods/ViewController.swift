//
//  ViewController.swift
//  CocoaPods
//
//  Created by Nikita on 24.08.2022.
//

import UIKit
import Jelly

class ViewController: UIViewController {
    var animator: Jelly.Animator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC")
        
        let interaction = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .edge)
        let presentation = SlidePresentation(direction: .right, interactionConfiguration: interaction)
        animator = Animator(presentation: presentation)
        animator?.prepare(presentedViewController: viewController)
        present(viewController, animated: true, completion: nil)
    }
}
