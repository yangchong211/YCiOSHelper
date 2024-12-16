//
//  CoinModel.swift
//  FunIOS
//
//  Created by redli on 2021/8/9.
//

/**
 {"curPage":1,"datas":[{"coinCount":13,"date":1628475372000,"desc":"2021-08-09 10:16:12 签到 , 积分：13 + 0","id":478599,"reason":"签到","type":1,"userId":45070,"userName":"redli"}],"offset":0,"over":false,"pageCount":5,"size":20,"total":91}
 */

import HandyJSON

class IntegralModel : HandyJSON {
    
    var curPage : Int = 0
    var datas : [IntegralItemModel] = []
    var offset : Int = 0
    var over : Bool = false
    var pageCount : Int = 0
    var size : Int = 0
    var total : Int = 0
    
    required init() {}
    
}

class IntegralItemModel: HandyJSON {
    var coinCount : Int = 0
    var date : Int = 0
    var desc : String = ""
    var id : Int = 0
    var reason : String = ""
    var type : Int = 0
    var userId : Int = 0
    var userName : String = ""
    
    
    required init() {}
}
