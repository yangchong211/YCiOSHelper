//
//  WebVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/25.
//

import UIKit
import WebKit

class WebVController: UIViewController {
    var url : String?
    
    convenience init(title: String? , url: String?) {
        self.init()
        self.title = title
        self.url = url
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let barButton = UIBarButtonItem()
//        barButton.title = ""
//        self.navigationItem.backBarButtonItem = barButton
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = title ?? "网页"
        //添加webview
        let webView =  WKWebView.init(frame: view.frame)
        
        if url != nil {
            webView.load(URLRequest.init(url:URL.init(string: url!)!))
        }
        
        self.view.addSubview(webView)
    }
}
