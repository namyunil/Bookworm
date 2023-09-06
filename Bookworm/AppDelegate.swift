//
//  AppDelegate.swift
//  Bookworm
//
//  Created by NAM on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } // test Column 추가
            
            if oldSchemaVersion < 2 { } // test Column 삭제
            
            if oldSchemaVersion < 3 { // memo -> memoTest
                migration.renameProperty(onType: BookWormTable.className(), from: "memo", to: "memoTest")
            }
            
            if oldSchemaVersion < 4 { // like -> likeTest
                migration.renameProperty(onType: BookWormTable.className(), from: "like", to: "likeTest")
            }
            
            if oldSchemaVersion < 5 { // summary 컬럼 추가, author + title 기존 데이터를 활용해서..!
                
                migration.enumerateObjects(ofType: BookWormTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
//                    new["diarySummary"] = "요약하기" // 새로운 column 내용을 쓰고싶을때..!
                    new["summary"] = "저자는 '\(old["author"])'이고, 제목은 '\(old["title"])'입니다."
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

