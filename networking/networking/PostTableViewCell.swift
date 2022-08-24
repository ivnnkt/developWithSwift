//
//  PostTableViewCell.swift
//  networking
//
//  Created by Nikita on 23.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    func comfigure(_ post: Post) {
        postTitleLabel.text = post.title.capitalized
        postBodyLabel.text = post.body
    }
}
