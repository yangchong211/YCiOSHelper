//
//  BaseResponse.swift
//
//  Created by 杨充 on 2021/7/21.
//

import Foundation
import HandyJSON

//这个是base类
class BaseResponse<T>: HandyJSON {
    
    var errorCode : Int?    //服务返回码
    
    var errorMsg : String?
    
    var data : T?
    
    required init() {}
}
