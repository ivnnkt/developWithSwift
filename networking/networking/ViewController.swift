//
//  ViewController.swift
//  networking
//
//  Created by Nikita on 23.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PostCellId")
        }
    }
    
    var posts: [Post] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        networkManager.getAllPosts { [weak self] (posts) in
//            DispatchQueue.main.async {
//                self?.posts = posts
//            }
//        }
        
        networkManager.getPostsBy(userId: 3) { [weak self] (posts) in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
    }
    
    @IBAction func createPost(_ sender: Any) {
        let post = Post(userId: 1, title: "myTitle", body: "myBody")
        
        networkManager.postCreatePost(post) { serverPost in
            post.id = serverPost.id
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "AWESOME", message: "Your post has been created!", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    alert.dismiss(animated: true)
                })
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellId", for: indexPath) as! PostTableViewCell
        cell.comfigure(posts[indexPath.row])
        return cell
    }
}
