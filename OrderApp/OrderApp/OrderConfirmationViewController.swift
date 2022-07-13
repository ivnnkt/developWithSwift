//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Nikita on 11.07.2022.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    let minuteToPrepare: Int
    
    @IBOutlet weak var confirmationLabel: UILabel!
    
    
    init?(coder: NSCoder, minuteToPrepare: Int) {
        self.minuteToPrepare = minuteToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minuteToPrepare) minutes."
    }
    

    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
