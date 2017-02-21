//
//  Section.swift
//  DataSource
//
//  Created by Matthias Buchetics on 21/02/2017.
//  Copyright © 2017 aaa - all about apps GmbH. All rights reserved.
//

import Foundation

public struct Section<Model>: Collection {
    
    public let key: String
    public let rows: [Row<Model>]
    
    public init(key: String, rows: [Row<Model>]) {
        self.key = key
        self.rows = rows
    }
    
    public typealias Index = Int
    
    public var startIndex: Int {
        return rows.startIndex
    }
    
    public var endIndex: Int {
        return rows.endIndex
    }
    
    public subscript(i: Int) -> Row<Model> {
        return rows[i]
    }
    
    public func index(after i: Int) -> Int {
        return rows.index(after: i)
    }
    
    public static func ==(fst: Section<Model>, snd: Section<Model>) -> Bool {
        return fst.key == snd.key
    }
}