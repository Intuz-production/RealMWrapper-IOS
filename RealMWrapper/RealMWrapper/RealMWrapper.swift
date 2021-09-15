//
//  RealMWrapper.swift
//  RealMWrapper
//
//  Created by Intuz on 08/09/21.
//

import UIKit
import RealmSwift

class RealMWrapper: NSObject {
    static let shared = RealMWrapper()
    let realmSchemeVersion:UInt64 = 1
    
    let realm = try? Realm()
    
}

// MARK:- Create Model
extension RealMWrapper {
    func createUserModelData(with object: UserModel) -> UserModel {
        print(Realm.Configuration.defaultConfiguration.fileURL?.path ?? "")
        do {
            try realm?.write {
                realm?.add(object)
            }
        } catch let error {
            print("RealM Error:\(error.localizedDescription)")
        }
        return object
    }
    
    func updateUserModelData(with object: UserModel, completion: (Bool) -> ()) {
//        print(Realm.Configuration.defaultConfiguration.fileURL?.path ?? "")
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
                completion(true)
            }
        }
        catch {
            print("Problem in UpdtaecreatePlaceDes")
            completion(false)
        }
    }
    
    func getAllData(completion: @escaping ((Results<UserModel>?) -> Void)) {
        completion(realm?.objects(UserModel.self).sorted(byKeyPath: "id", ascending: false) ?? nil)
    }
    
    //MARK:- Delete Record
    func delete(object: UserModel, completion: @escaping (Bool) -> ()) {
        try? realm?.write {
            realm?.delete(object)
            completion(true)
        }
    }
    
    func deleteAll() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}

extension RealMWrapper {
    func migrateRealMDatabase() {
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0)
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: self.realmSchemeVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < self.realmSchemeVersion) {
                    // The enumerateObjects(ofType:_:) method iterates
                    // over every Person object stored in the Realm file
                    migration.enumerateObjects(ofType: UserModel.className()) { oldObject, newObject in
                        // combine name fields into a single field
                    }
                }
            })
    }
}
