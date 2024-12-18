//
//  CoinModel.swift
//  FunIOS
//
//  Created by redli on 2021/8/9.
//

/**
 {"coinCount":2308,"level":24,"nickname":"","rank":"782","userId":45070,"username":"r**li"}
 */

import HandyJSON

class UserCoinLevelModel : HandyJSON {

    var coinCount : Int = 0
    var level : Int = 0
    var nickname : String = ""
    var rank : String = ""
    var userId : Int = 0
    var username : String = ""


    required init() {}

}
