//
//  Api.swift
//  FunIOS
//
//  Created by 杨充 on 2021/7/22.
//

import Foundation
import HandyJSON
import Alamofire

class Api {
    
    //获取轮播图列表
    static func fetchBanners(success: @escaping(_ result: Array<BannerModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "banner/json", success: success, error: error)
    }
    
    //获取置顶文章列表
    static func fetchTopArticles(success: @escaping(_ result: Array<ArticleItemModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "article/top/json", success: success, error: error)
    }
    
    //获取文章列表
    static func fetchArticles(page: Int, success: @escaping(_ result: ArticleModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "article/list/\(page)/json", success: success, error: error)
    }
    
    //获取项目分类
    static func fetchProjectSegmented(success: @escaping(_ result: Array<StructureModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "project/tree/json", success: success, error: error)
    }
    
    //获取项目文章列表
    static func fetchProjectArticles(page: Int, cid: Int, success: @escaping(_ result: ArticleModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "article/list/\(page)/json?cid=\(cid)", success: success, error: error)
    }
    
    //获取公众号分类
    static func fetchWechatSegmented(success: @escaping(_ result: Array<StructureModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "wxarticle/chapters/json", success: success, error: error)
    }
    
    //获取公众号文章列表
    static func fetchWechatArticles(page: Int, cid: Int, success: @escaping(_ result: ArticleModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "wxarticle/list/\(cid)/\(page)/json", success: success, error: error)
    }
    
    //获取navigation item 体系中的体系列表
    static func fetchStructures(success: @escaping(_ result: Array<StructureModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "tree/json", success: success, error: error)
    }
    
    //获取navigation item 体系中的导航列表
    static func fetchNavigations(success: @escaping(_ result: Array<NavigationModel>?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "navi/json", success: success, error: error)
    }
    
    //登录
    static func login(username: String, password: String, success: @escaping(_ result: UserModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "user/login", type: MethodType.post, params: ["username": username, "password" : password], success: success, error: error)
    }
    
    //获取用户等级和积分
    static func fetchUserCoinLevel(success: @escaping(_ result: UserCoinLevelModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "lg/coin/userinfo/json", success: success, error: error)
    }
    
    //获取收藏文章列表
    static func fetchCollectArticles(page: Int, success: @escaping(_ result: ArticleModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "/lg/collect/list/\(page)/json", success: success, error: error)
    }
    
    //获取个人积分
    static func fetchMyIntegral(page: Int, success: @escaping(_ result: IntegralModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "lg/coin/list/\(page)/json", success: success, error: error)
    }
    
    //获取积分排行榜
    static func fetchRanking(page: Int, success: @escaping(_ result: RankingModel?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "coin/rank/\(page)/json", success: success, error: error)
    }
    
    //收藏文章
    static func collect(cid: Int, success: @escaping(_ result: Any?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "lg/collect/\(cid)/json", type: MethodType.post, success: success, error: error)
    }
    
    //收藏网址
    static func collectUrl(name: String, link: String, success: @escaping(_ result: Any?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "lg/collect/addtool/json", params: ["name": name, "link": link], success: success, error: error)
    }
    
    //取消收藏文章
    static func uncollect(cid: Int, success: @escaping(_ result: Any?) -> (), error: @escaping(_ error: String?) -> ()) {
        HttpUtils.request(url: "lg/uncollect_originId/\(cid)/json", type: MethodType.post, success: success, error: error)
    }
    
}

enum MethodType {
    //get请求
    case get
    //post请求
    case post
}

class HttpUtils {
    
    // static 也可以用 class 替代 效果是一样的
    static func request<T>(url: String, type: MethodType? = MethodType.get, params: [String: Any]? = nil, success: @escaping(_ result: T?) -> (), error: @escaping(_ error: String?) -> ()) {
        //请求方法
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        //let headers: HTTPHeaders = ["Cookie": ""]
        //var requestUrl = baseUrl + url
        let requestUrl: URL = URL(string: baseUrl + url)!
        print("请求地址 ---> \(baseUrl + url)")
        //Alamofire支持4种返回响应处理方式：Data、String、 JSON、自定义类型。
        //request请求接口方法，源码中参数含义
        //参数一： convertible（可变化）一个可变化的参数。其实就是请求的url地址。
        //参数二：method 请求方式。就是我们常说的GET，POST。
        //参数三：parameters 请求参数。业务数据的参数部分，如登录模块的userName，Password等之类的业务数据。
        //参数四：encoding 编码方式。
        AF.request(requestUrl, method: method, parameters: params)
        //返回json数据
            .responseJSON { response in
                
                //使用guard语句对返回的数据进行校验
                guard let data = response.value else {
                    error(response.error?.errorDescription ?? "请求错误")
                    log(log: "请求错误  ---> \(response.error?.errorDescription ?? "")")
                    return
                }
                
                //解析数据
                let result = JSONDeserializer<BaseResponse<T>>.deserializeFrom(dict: data as? [String: Any])
                
                //处理业务上数据逻辑
                if result?.errorCode == 0 {
                    success(result?.data)
                    print("请求成功 ---> \(baseUrl + url)")
                } else{
                    error(result?.errorMsg)
                    print("请求失败 ---> \(baseUrl + url)")
                }
                
                //打印返回json内容
                print("打印返回json内容 ---> \(response.value ?? "")" )
            }
    }
}
