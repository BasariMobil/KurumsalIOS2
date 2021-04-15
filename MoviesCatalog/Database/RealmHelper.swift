//
//  RealmHelper.swift
//  moviesCatalog
//
//  Created by Yiğitcan Luş on 8.04.2021.
//

import Foundation
import RealmSwift

var mRealm = try! Realm()
func defs() -> UserDefaults{
    
    return UserDefaults.standard
    
}

func getAuntoIncIntId () -> Int {
    
    let lastId : Int = defs().integer(forKey: "rank")
    defs().set(lastId+1, forKey: "rank")
    return lastId
    
}

func setRealmDBSettings() {
    let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        let path = Bundle.main.path(forResource: "default", ofType: "realm")

        if let defaultPath = defaultPath, let bundledPath = path {
            do {
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
            } catch {
                print("Error copyin-populated Realm \(error)")
            }
        }
        _ = try! Realm()

    print(Realm.Configuration.defaultConfiguration.fileURL)
}


