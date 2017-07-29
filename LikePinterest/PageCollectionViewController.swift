//
//  PageCollectionViewController.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import UIKit
import AFNetworking

class PageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "cell"
    private var selectedUser: User?
    
    private let ShowUserSegueIdentifier = "showUserDetailSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "LikePinterest"
        let nib = UINib(nibName: "PageCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(imageResultComplete(notification:)), name: .PageImageResultComplete, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(imageResultComplete(notification:)), name: .UserImageResultComplete, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ShowUserSegueIdentifier {
            if let viewController = segue.destination as? UserViewController, let user = selectedUser{
                viewController.user = user
            }
        }
        
    }
    
    func imageResultComplete(notification: Notification) {
        
        collectionView?.reloadData()
        
    }
    
    
    // MARK: - Collection View
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PageModel.shared.pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let page = PageModel.shared.pages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PageCollectionViewCell
        
        cell?.pageImageView.image = PageModel.shared.imageForPage(page, type: Page.URLType.regular)
        cell?.userImageView.image = PageModel.shared.imageForUser(page.user, type: User.ProfileImageType.medium)
        cell?.usernameButton.setTitle(page.user.username, for: .normal)
        cell?.usernameButton.addTarget(self, action: #selector(showUserProfile(sender:)), for: .touchUpInside)
        cell?.usernameButton.tag = indexPath.row
        
        if indexPath.row == PageModel.shared.pages.count - 1 {
            PageModel.shared.loadPageBatch()
        }
        
        return cell!
        
    }
    
    
    // MARK: - Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height / 2.0
        
        return CGSize(width: width, height: height)
    }
    
    
    // MARK: - User Selection
    
    func showUserProfile(sender: UIButton) {
        
        let page = PageModel.shared.pages[sender.tag]
        selectedUser = page.user
        performSegue(withIdentifier: ShowUserSegueIdentifier, sender: nil)
        
    }

}

