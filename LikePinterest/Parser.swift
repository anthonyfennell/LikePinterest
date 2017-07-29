//
//  Parser.swift
//  LikePinterest
//
//  Created by Anthony Fennell on 7/26/17.
//  Copyright © 2017 Anthony Fennell. All rights reserved.
//

import Foundation

protocol Parser {
    func parse()
    func parseItem(_ item: Any)
}
