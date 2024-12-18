//
//  AirticleModel.swift
//  FunIOS
//
//  Created by redli on 2021/7/22.
//

import HandyJSON


import HandyJSON


class ArticleModel : HandyJSON {
    
    var curPage : Int = 0
    var datas : [ArticleItemModel] = []
    var offset : Int = 0
    var over : Bool = false
    var pageCount : Int = 0
    var size : Int = 0
    var total : Int = 0
    
    
    required init() {}
    
}

class ArticleItemModel : HandyJSON {
    
    var apkLink : String = ""
    var audit : Int = 0
    var author : String = ""
    var canEdit : Bool = false
    var chapterId : Int = 0
    var chapterName : String = ""
    var collect : Bool = false
    var courseId : Int = 0
    var desc : String = ""
    var descMd : String = ""
    var envelopePic : String = ""
    var fresh : Bool = false
    var host : String = ""
    var id : Int = 0
    var link : String = ""
    var niceDate : String = ""
    var niceShareDate : String = ""
    var origin : String = ""
    var prefix : String = ""
    var projectLink : String = ""
    var publishTime : Int = 0
    var realSuperChapterId : Int = 0
    var selfVisible : Int = 0
    var shareDate : Int = 0
    var shareUser : String = ""
    var superChapterId : Int = 0
    var superChapterName : String = ""
    var tags : [Tag] = []
    var title : String = ""
    var type : Int = 0
    var userId : Int = 0
    var visible : Int = 0
    var zan : Int = 0
    
    
    required init() {}
    
}

class Tag : HandyJSON {
    
    var name : String = ""
    var url : String = ""
    
    
    required init() {}
    
}
