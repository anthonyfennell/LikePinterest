//
//  SyncManager.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation
import UIKit

class SyncManager: PageParserDelegate {
    
    static let shared = SyncManager()
    private let pageResultsURL = "http://pastebin.com/raw/wgkJgazE"
    
    
    func getPageResults() {
        
        let sessionManager = SessionManager.jsonSessionManager()
        
        sessionManager.get(pageResultsURL, parameters: nil, progress: nil, success: { (dataTask, response) in
            
            if let items = response as? [Any] {
                let parser = PageParser(items: items, delegate: self)
                parser.parse()
            }
            
        }, failure: { (dataTask, error) in
            
            print(error.localizedDescription)
            
        })
        
    }
    
    func getImage(urlString: String, completion: @escaping (UIImage?) -> ()) {
        
        let sessionManager = SessionManager.imageSessionManager()
        
        sessionManager.get(urlString, parameters: nil, progress: nil, success: { (dataTask, response) in
            
            if let image = response as? UIImage {
                completion(image)
            }
            
            completion(nil)
            
        }, failure: { (dataTask, error) in
         
            print(error.localizedDescription)
            completion(nil)
            
        })
        
    }
    
    // MARK: - PageParserDelegate
    
    func pageParserDidComplete(pages: [Page]) {
        NotificationCenter.default.post(name: .PageResultsComplete, object: pages)
    }
    
}
