//
//  RankingModel.swift
//  FunIOS
//
//  Created by redli on 2021/8/10.
//
/**
 {"curPage":1,"datas":[{"coinCount":48606,"level":487,"nickname":"","rank":"1","userId":20382,"username":"g**eii"}],"offset":0,"over":false,"pageCount":2685,"size":30,"total":80540}
 */


import Foundation
import HandyJSON

class RankingModel : HandyJSON {

    var curPage : Int = 0
    var datas : [UserCoinLevelModel] = []
    var offset : Int = 0
    var over : Bool = false
    var pageCount : Int = 0
    var size : Int = 0
    var total : Int = 0


    required init() {}

}
