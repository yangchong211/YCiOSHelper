//
//  Api.swift
//  FunIOS
//
//  Created by redli on 2021/7/22.
//

import Foundation
import HandyJSON

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
