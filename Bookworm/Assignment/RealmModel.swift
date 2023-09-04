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
    @Persisted var like: Bool
    
    convenience init(author: String, title: String, publisher: String, price: Int, image: String) {
        self.init()
        
        self.author = author
        self.title = title
        self.publisher = publisher
        self.price = price
        self.image = image
        self.like = false
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
