//
//  Page.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation
import UIKit

class Page {
    
    let identifier: String
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let likes: Int
    let likedByUser: Bool
    let user: User
    let urls: [String: String]
    
    enum URLType: String {
        case raw, full, regular, small, thumb
    }
    
    init(identifier: String, createdAt: String, width: Int, height: Int, color: String, likes: Int, likedByUser: Bool, urls: [String: String], user: User) {
        self.identifier = identifier
        self.createdAt = createdAt
        self.width = width
        self.height = height
        self.color = color
        self.likes = likes
        self.likedByUser = likedByUser
        self.user = user
        self.urls = urls
    }
    
}
