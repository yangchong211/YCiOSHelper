//
//  BaseResponse.swift
//  FunIOS
//
//  Created by redli on 2021/7/21.
//

import Foundation
import HandyJSON

class BaseResponse<T>: HandyJSON {
    
    var errorCode : Int?    //服务返回码
    
    var errorMsg : String?
    
    var data : T?
    
    required init() {}
}
