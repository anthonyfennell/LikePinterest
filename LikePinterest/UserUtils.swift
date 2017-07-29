//
//  UserUtils.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation

class UserUtils {
    
    static let IdentifierKey      = "id"
    static let UserNameKey        = "username"
    static let NameKey            = "name"
    static let ProfileImageKey    = "profile_image"
    static let LinksKey           = "links"
    
    static func userWithJSON(_ dictionary: [String: Any]) -> User? {
        
        guard let identifier = dictionary[IdentifierKey] as? String, let username = dictionary[UserNameKey] as? String, let name = dictionary[NameKey] as? String,
            let profileImageURLs = dictionary[ProfileImageKey] as? [String: String], let links = dictionary[LinksKey] as? [String: String] else {
            print("Error extracting user from JSON")
            return nil
        }
        
        return User(identifier: identifier, username: username, name: name, profileImageURLs: profileImageURLs, links: links)
    }
    
}
