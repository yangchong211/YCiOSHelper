//
//  StructureModel.swift
//  FunIOS
//
//  Created by redli on 2021/7/25.
//

import HandyJSON


open class StructureModel : HandyJSON {

    var children : [StructureModel] = []
    var courseId : Int = 0
    var id : Int = 0
    var name : String = ""
    var order : Int = 0
    var parentChapterId : Int = 0
    var userControlSetTop : Bool = false
    var visible : Int = 0


    required public init() {}

}
