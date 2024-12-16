//
//  HttpUtils.swift
//  FunIOS
//
//  Created by redli on 2021/7/21.
//

import Foundation
import HandyJSON
import Alamofire

enum MethodType {
    case get
    case post
}

class HttpUtils {
    
    // static 也可以用 class 替代 效果是一样的
    static func request<T>(url: String, type: MethodType? = MethodType.get, params: [String: Any]? = nil, success: @escaping(_ result: T?) -> (), error: @escaping(_ error: String?) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//        let headers: HTTPHeaders = ["Cookie": ""]
        
        print("请求地址 ---> \(baseUrl + url)")
        
        AF.request(baseUrl + url, method: method, parameters: params).responseJSON { response in
            
            guard let data = response.value else {
                error(response.error?.errorDescription ?? "请求错误")
                log(log: "请求错误  ---> \(response.error?.errorDescription ?? "")")
                return
            }
            
            let result = JSONDeserializer<BaseResponse<T>>.deserializeFrom(dict: data as? [String: Any])
        
            if result?.errorCode == 0 {
                success(result?.data)
                print("请求成功 ---> \(baseUrl + url)")
            } else{
                error(result?.errorMsg)
                print("请求失败 ---> \(baseUrl + url)")
            }
            print(response.value ?? "")
        }
    }
}
