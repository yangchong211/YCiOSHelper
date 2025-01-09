//
//  NavigationModel.swift
//  FunIOS
//
//  Created by redli on 2021/7/27.
//

import HandyJSON

open class NavigationModel: HandyJSON {
    
    var articles: [ArticleItemModel] = []
    var cid: Int = 0
    var name: String = ""
    
    required public init() {}
}
