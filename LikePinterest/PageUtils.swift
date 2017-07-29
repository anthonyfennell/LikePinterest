//
//  PageUtils.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation

class PageUtils {
    
    static let IdentifierKey    = "id"
    static let CreatedAtKey     = "created_at"
    static let WidthKey         = "width"
    static let HeightKey        = "height"
    static let ColorKey         = "color"
    static let LikesKey         = "likes"
    static let LikedByUserKey   = "liked_by_user"
    static let UserKey          = "user"
    static let CurrentUserCollectionsKey = "current_user_collections"
    static let URLsKey          = "urls"
    static let CategoriesKey    = "categories"
    static let LinksKey         = "links"
    
    enum LinkType: String {
        case user = "self", html, download
    }
    
    static func pageItemWithJSON(_ dictionary: [String: Any]) -> Page? {
        
        guard let userDictionary = dictionary[UserKey] as? [String: Any], let user = UserUtils.userWithJSON(userDictionary) else {
            print("Error extracting User")
            return nil
        }
        
        guard let identifier = dictionary[IdentifierKey] as? String, let createdAt = dictionary[CreatedAtKey] as? String, let width = dictionary[WidthKey] as? Int, let height = dictionary[HeightKey] as? Int, let color = dictionary[ColorKey] as? String, let likes = dictionary[LikesKey] as? Int, let likedByUser = dictionary[LikedByUserKey] as? Bool, let urls = dictionary[URLsKey] as? [String: String] else {
            print("Error extracting page information from JSON")
            return nil
        }
        
        return Page(identifier: identifier, createdAt: createdAt, width: width, height: height, color: color, likes: likes, likedByUser: likedByUser, urls: urls, user: user)
    }
    
}



















