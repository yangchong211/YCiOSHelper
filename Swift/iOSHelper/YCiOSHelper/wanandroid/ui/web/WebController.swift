//
//  WebVController.swift
//  FunIOS
//
//  Created by 杨充 on 2021/7/25.
//

import UIKit
import WebKit

//H5页面
class WebController: UIViewController , WKNavigationDelegate{
    
    var url : String?
    
    convenience init(title: String? , url: String?) {
        self.init()
        self.title = title
        self.url = url
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = title ?? "网页"
        //添加webview
        let webView =  WKWebView.init(frame: view.frame)
        //加载url
        if url != nil {
            webView.load(URLRequest.init(url:URL.init(string: url!)!))
        }
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    
    // WKNavigationDelegate 方法
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载完成")
    }
}
