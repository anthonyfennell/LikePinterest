//
//  User.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let identifier: String
    let username: String
    let name: String
    let profileImageURLs: [String: String]
    let links: [String: String]
    
    enum ProfileImageType: String {
        case small, medium, large
    }
    
    enum LinkType: String {
        case user = "self", html, photos, likes
    }
    
    init(identifier: String, username: String, name: String, profileImageURLs: [String: String], links: [String: String]) {
        self.identifier = identifier
        self.username = username
        self.name = name
        self.profileImageURLs = profileImageURLs
        self.links = links
    }
    
}
