//
//  ViewController.swift
//  Animation
//
//  Created by Nikita on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var dropViewButton: UIButton!
    
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collider: UICollisionBehavior?
    var itemBehavior: UIDynamicItemBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collider = UICollisionBehavior()
        itemBehavior = UIDynamicItemBehavior()
        
        collider?.translatesReferenceBoundsIntoBoundary = true
        collider?.collisionMode = .everything
        
        collider?.addItem(dropViewButton)
        
        itemBehavior?.elasticity = 0.5
        itemBehavior?.friction = 0.5
        itemBehavior?.allowsRotation = true
        
        animator?.addBehavior(gravity!)
        animator?.addBehavior(collider!)
        animator?.addBehavior(itemBehavior!)
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
    
    @IBAction func didTapDropView() {
        let view = UIView(frame: CGRect(x: dropViewButton.frame.origin.x, y: 40, width: 30, height: 30))
        view.backgroundColor = .darkGray
        self.view.addSubview(view)
        
        itemBehavior?.addItem(view)
        gravity?.addItem(view)
        collider?.addItem(view)
        
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

