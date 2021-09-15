//
//  UserModel.swift
//  RealMWrapper
//
//  Created by Intuz on 08/09/21.
//

import UIKit
import RealmSwift

class UserModel: Object {
    @objc dynamic var id    = 0
    @objc dynamic var name: String?
    @objc dynamic var mobileNo: String?
    @objc dynamic var gender: String?
    @objc dynamic var createdAt = Date()
    
    @objc override class func primaryKey() -> String? {
        return "id"
    }
}


//struct UserModel {
//    var id: Int?
//    var name: String?
//    var mobileNo: String?
//    var gender: String?
//    
//    init() { }
//}
