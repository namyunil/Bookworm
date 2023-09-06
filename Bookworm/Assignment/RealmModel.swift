//
//  RealmModel.swift
//  Bookworm
//
//  Created by NAM on 2023/09/04.
//

import Foundation
import RealmSwift

class BookWormTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: String
    @Persisted var title: String
    @Persisted var publisher: String
    @Persisted var price: Int
    @Persisted var image: String
    @Persisted var likeTest: Bool
    @Persisted var content: String
    @Persisted var memoTest: String
//    @Persisted var test: Bool
    @Persisted var summary: String
    
    convenience init(author: String, title: String, publisher: String, price: Int, image: String, content: String, memo: String) {
        self.init()
        
        self.author = author
        self.title = title
        self.publisher = publisher
        self.price = price
        self.image = image
        self.content = content
        self.likeTest = false
        self.memoTest = memo
//        self.test = false
        self.summary = "저자는 '\(author)'이고, 제목은 '\(title)'입니다."
    }
    
    
}

/*
 var authors: [String]
 let title: String
 let publisher: String
 let content: String
 let image: String
 let date: String
 let price: Int
 
 var info: String
 */
