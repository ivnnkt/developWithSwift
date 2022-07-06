//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Nikita on 01.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var descriptionLable: UILabel!
    @IBOutlet var copyrightLable: UILabel!

    
    let photoInfoController = PhotoInfoController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = ""
        photoImage.image = UIImage(systemName: "photo.on.rectangle")
        descriptionLable.text = ""
        copyrightLable.text = ""
        
        Task {
            do {
                let photoInfo = try await photoInfoController.fetchPhotoInfo()
                updateUI(with: photoInfo)
            } catch {
                updateUI(with: error)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        Task {
            do {
                let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                title = photoInfo.title
                photoImage.image = image
                descriptionLable.text = photoInfo.description
                copyrightLable.text = photoInfo.copyright
            } catch {
                updateUI(with: error)
            }
        }
    }
    
    func updateUI(with error: Error) {
        title = "Error Fetching Photo"
        photoImage.image = UIImage(systemName: "exclamationmark.octagon")
        descriptionLable.text = error.localizedDescription
        copyrightLable.text = ""
    }
}

