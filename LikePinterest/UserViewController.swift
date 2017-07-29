//
//  UserViewController.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/29/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.image = PageModel.shared.imageForUser(user, type: User.ProfileImageType.large)
        usernameLabel.text = user.name
        navigationItem.title = user.username
        
        NotificationCenter.default.addObserver(self, selector: #selector(imageResultComplete(notification:)), name: .UserImageResultComplete, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func imageResultComplete(notification: Notification) {
        userImageView.image = PageModel.shared.imageForUser(user, type: User.ProfileImageType.large)
    }

}
