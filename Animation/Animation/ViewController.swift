//
//  ViewController.swift
//  Animation
//
//  Created by Nikita on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startTransform() {
        let label = UILabel(frame: CGRect(x: 25, y: 25, width: 100, height: 100))
        label.text = "Dark side"
        
        UIView.transition(with: self.animationView, duration: 2, options: [UIView.AnimationOptions.transitionCurlUp], animations: {
            self.animationView.addSubview(label)
        }) { (isFinished) in
            UIView.transition(with: self.animationView, duration: 2, options: UIView.AnimationOptions.transitionCurlDown, animations: {
                label.removeFromSuperview()
            }, completion: nil)
        }
    }
    
    @IBAction func startMove() {
        
        let backgroundColor = animationView.backgroundColor
        let alpha = animationView.alpha
        let center = animationView.center
        let transform = animationView.transform
        
        UIView.animate(withDuration: 4, animations: {
            self.animationView.backgroundColor = .blue
            self.animationView.alpha = 0
            self.animationView.center = CGPoint(x: 400, y: 700)
            self.animationView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }) { (isFinished) in
            if isFinished {
                UIView.animate(withDuration: 4, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                    self.animationView.backgroundColor = backgroundColor
                    self.animationView.alpha = alpha
                    self.animationView.center = center
                    self.animationView.transform = transform
                }, completion: nil)
            }
        }
    }
}

