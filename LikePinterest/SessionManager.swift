//
//  SessionManager.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import AFNetworking

class SessionManager: AFHTTPSessionManager {
    
    static func jsonSessionManager() -> SessionManager {
        
        let manager = SessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/plain"]
        
        return manager
        
    }
    
    static func xmlSessionManager() -> SessionManager {
        
        let manager = SessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFXMLParserResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/xml"]
        
        return manager
        
    }
    
    static func imageSessionManager() -> SessionManager {
        
        let manager = SessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFImageResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["image/jpeg"]
        
        return manager
        
    }
    
}
