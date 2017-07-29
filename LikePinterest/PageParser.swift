//
//  PageParser.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation

protocol PageParserDelegate {
    func pageParserDidComplete(pages: [Page])
}

class PageParser: Parser {
    
    private let items: [Any]
    private let delgate: PageParserDelegate    
    private var pages = [Page]()
    
    init(items: [Any], delegate: PageParserDelegate) {
        self.items = items
        self.delgate = delegate
    }
    
    func parse() {
        
        pages.removeAll()
        
        for item in items {
            parseItem(item)
        }
        
        delgate.pageParserDidComplete(pages: pages)
        
    }
    
    func parseItem(_ item: Any) {
        
        if let dictionary = item as? [String: Any], let page = PageUtils.pageItemWithJSON(dictionary) {
            pages.append(page)
        }
        
    }
    
}
