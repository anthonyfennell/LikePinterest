//
//  PageModel.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/29/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation
import UIKit

class PageModel {
    
    static let shared = PageModel()
    
    var pages: [Page] {
        return visiblePages
    }
    
    private var visiblePages = [Page]()
    private var allPages = [Page]()
    private let imageBatchSize = 10
    
    private var userImageCache = NSCache<NSString, UIImage>()
    private var pageImageCache = NSCache<NSString, UIImage>()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(pageResultsComplete(notification:)), name: .PageResultsComplete, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func pageResultsComplete(notification: Notification) {
        
        if let pages = notification.object as? [Page] {
            
            self.allPages = pages
            self.visiblePages.removeAll()
            self.loadPageBatch()
            
        }
        
    }
    
    func imageForPage(_ page: Page, type: Page.URLType) -> UIImage? {
        
        guard let image = pageImageCache.object(forKey: page.identifier + type.rawValue as NSString) else {
            requestImageFor(page: page, type: type)
            return nil
        }
        
        return image
        
    }
    
    func imageForUser(_ user: User, type: User.ProfileImageType) -> UIImage? {
        
        guard let image = userImageCache.object(forKey: user.identifier + type.rawValue as NSString) else {
            requestImageFor(user: user, type: type)
            return nil
        }
        
        return image
        
    }
    
    func loadPageBatch() {
        
        let lastIndex = visiblePages.count > 0 ? visiblePages.count - 1 : 0
        
        guard lastIndex != allPages.count - 1 else {
            print("Last page index reached")
            return
        }
        
        let batchSize = allPages.count > lastIndex + imageBatchSize ? lastIndex + imageBatchSize : allPages.count
        
        for i in lastIndex..<batchSize {
            let page = allPages[i]
            self.visiblePages.append(page)
            requestImageFor(page: page, type: Page.URLType.regular)
            requestImageFor(user: page.user, type: User.ProfileImageType.medium)
        }
        
    }
    
    private func requestImageFor(page: Page, type: Page.URLType) {
        
        if let pageURL = page.urls[type.rawValue] {
            SyncManager.shared.getImage(urlString: pageURL) { image in
                
                if let targetImage = image {
                    self.updatePage(page: page, withImage: targetImage, type: type)
                }
                
            }
        }
        
    }
    
    private func requestImageFor(user: User, type: User.ProfileImageType) {
        
        if let userURL = user.profileImageURLs[type.rawValue] {
            SyncManager.shared.getImage(urlString: userURL) { image in
             
                if let targetImage = image {
                    self.updateUser(user: user, withImage: targetImage, type: type)
                }
                
            }
        }
        
    }
    
    private func updatePage(page: Page, withImage image: UIImage, type: Page.URLType) {
    
        pageImageCache.setObject(image, forKey: page.identifier + type.rawValue as NSString)
        NotificationCenter.default.post(name: .PageImageResultComplete, object: nil)
        
    }
    
    private func updateUser(user: User, withImage image: UIImage, type: User.ProfileImageType) {
        
        userImageCache.setObject(image, forKey: user.identifier + type.rawValue as NSString)
        NotificationCenter.default.post(name: .UserImageResultComplete, object: nil)
        
    }
    
}







