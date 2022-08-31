//
//  ViewController.swift
//  WorkingWithCoreData
//
//  Created by Nikita on 30.08.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let container = AppDelegate.container

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save() {
//        container.viewContext.perform {
//            let user = UserEntity(context: self.container.viewContext)
//            user.id = UUID().uuidString
//            user.name = "Marrri"
//
//            print(user.id)
//        }
        
        container.viewContext.perform {
            let post = PostEntity(context: self.container.viewContext)
            post.id = UUID().uuidString
            post.title = "The Best post!"
            
            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            
            let users = try? self.container.viewContext.fetch(request)
            
            post.user = users?.last
        }
    }
    
    @IBAction func load() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        let users = try? container.viewContext.fetch(request)
        
        print(users?.last?.posts?.count)
    }
    
}

