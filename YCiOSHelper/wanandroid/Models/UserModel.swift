//
//  UserModel.swift
//  FunIOS
//
//  Created by redli on 2021/8/4.
//

import HandyJSON

class UserModel : HandyJSON {

    var admin : Bool = false
    var chapterTops : [AnyObject] = []
    var coinCount : Int = 0
    var collectIds : [Int] = []
    var email : String = ""
    var icon : String = ""
    var id : Int = 0
    var nickname : String = ""
    var password : String = ""
    var publicName : String = ""
    var token : String = ""
    var type : Int = 0
    var username : String = ""


    required init() {}

}
