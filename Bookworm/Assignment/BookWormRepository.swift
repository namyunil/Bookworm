//
//  BookWormRepository.swift
//  Bookworm
//
//  Created by NAM on 2023/09/07.
//

import Foundation
import RealmSwift

protocol BookWormRepositoryType: AnyObject {
    func fetch() -> Results<BookWormTable>
    func createItem(_ item: BookWormTable)
    func editItem(id: ObjectId, likeTest: Bool)
}

class BookWormRepository: BookWormRepositoryType {
    
    private let realm = try! Realm()
    
    func checkSchemaVersion() { // Schema Version을 체크하는 코드..! Default로 0부터 시작한다.
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!) //database.default.url의 url을 요청하는 코드..!
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<BookWormTable> { // Generic..!
        let data = realm.objects(BookWormTable.self)
        return data
    }
    
    func createItem(_ item: BookWormTable) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    func editItem(id: ObjectId, likeTest: Bool) {
        do {
            try realm.write {
                //단순 추가가 아닌 수정하는 것이라 명시..!
                realm.create(BookWormTable.self, value: ["_id": id.self, "likeTest": likeTest], update: .modified)
            }
            
        } catch {
            print("")
        }
        
    }
    
    
    
    
}
