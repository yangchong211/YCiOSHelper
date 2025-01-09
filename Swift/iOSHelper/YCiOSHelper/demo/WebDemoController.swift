//
//  WebDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/2.
//

import UIKit
import WebKit

class WebDemoController: UIViewController , UIWebViewDelegate ,UISearchBarDelegate{
    
    // 搜索栏
    @IBOutlet weak var searchBar: UISearchBar!
    // WebView
    @IBOutlet weak var webView: UIWebView!
    // 后退Button
    @IBOutlet weak var goBack: UIBarButtonItem!
    // 前进Button
    @IBOutlet weak var goForward: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        myBarView();
        myWebView();
    }
    
    private func myBarView() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200))
        //searchBar.delegate = self;
        self.view.addSubview(searchBar);
    }
    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar){
//        // 1.获取当前 UISearchBar 的 Text
//        var str = searchBar.text
//        // 2.判断 UISearchBar 是否有前缀, 如果有, 就使用自定义的网址, 如果没有就默认使用百度搜索
////        if !str.hasPrefix("http://") {
////            str = "http://www.baidu.com/s?word=" + str
////        }
//        // 3.将输入的文字或者是需要搜索的东西转成 UTF8 格式, 并且解包
//        let url = NSURL(string:str!)
//        // 4.建立网络请求
//        let request = NSURLRequest(url: url)
//        // 5.加载网络请求
//        webView.loadRequest(request)
//        // 6.关闭 UISearchBar 的弹出键盘
//        self.view.endEditing(true)
//    }
    
    private func myWebView() {
        //webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 200, height: 200));
        webView = UIWebView(frame: self.view.bounds)
        // 1.获取 UIWebView 的 UIScrollView 属性
        let webScroll = webView.scrollView;
        print("webScroll = \(webScroll)")
        
        // 2.获取 UIWebView 的 request 属性
        let webRequest = webView.request
        print("webRequest = \(webRequest)")
        
        // 3.获取 UIWebView 是否在接收数据的时候可以退后一步
        let webCanBack = webView.canGoBack
        print("webCanBack = \(webCanBack)")
        
        // 4.获取 UIWebView 是否在接收数据的时候可以前进一步
        let webCanGo = webView.canGoForward
        print("webCanGo = \(webCanGo)")
        
        // 5.获取 UIWebVIew 是否接受完数据
        let webLoading = webView.isLoading
        print("webLoading = \(webLoading)")
        
        // 6.设置 UIWebView 接收的数据是否可以通过手势来调整页面内容大小
        webView.scalesPageToFit = true
        
        // 7.设置 UIWebView 接收到得数据是什么类型的
        webView.dataDetectorTypes = UIDataDetectorTypes.all
        
        // 8.设置 UIWebView 内是否可以回放媒体
        webView.allowsInlineMediaPlayback = true
        
        // 9.设置 UIWebView 中的 HTML5 视频是否自动播放
        webView.mediaPlaybackRequiresUserAction = true
        
        // 10.设置 UIWebView 是否可以使用 Air 播放
        webView.mediaPlaybackAllowsAirPlay = true
        
        // 11.设置 UIWebView 是否使用同步加载(默认是False)
        webView.suppressesIncrementalRendering = false
        
        // 12.设置 UIWebView 在点击视图或者元素时是否显示键盘(默认是True)
        webView.keyboardDisplayRequiresUserAction = true
        
        // 13.设置 UIWebView 的分页模式
        webView.paginationMode = UIWebView.PaginationMode.rightToLeft
        
        // 14.设置 UIWebView 的分页打破模式
        webView.paginationBreakingMode = UIWebView.PaginationBreakingMode.column
        
        // 15.设置 UIWebView 的分页长度
        webView.pageLength = 400
        
        // 16.设置 UIWebView 每个分页之间的宽度
        webView.gapBetweenPages = 100
        
        // 17.获取 UIWebView 的分页数量
        let webViewPageCount = webView.pageCount
        print(webViewPageCount)
        
        // 18.设置 UIWebView 的代理对象
        webView.delegate = self
        
        
        // 19.发送网络请求
        let url = URL(string: "https://baidu.com")
        var request = URLRequest(url: url!)
        webView.loadRequest(request);
        
        // 20.添加到视图中
        self.view.addSubview(webView);
    }
    
    // 1.该方法是用来设置是否在 UIWebView 加载之前发送一个请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
    // 2.该方法是在 UIWebView 在开发加载时调用
    func webViewDidStartLoad(_ webView: UIWebView){
        print("开始加载")
    }
    
    // 3.该方法是在 UIWebView 加载完之后才调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("加载完成")
        //UIWebView 代理方法, 自动检测是否有加载过数据, 如果有的话就会根据系统的判断来显示前进或者后退的按钮
        self.goBack.isEnabled = webView.canGoBack;
        self.goForward.isEnabled = webView.canGoForward;
    }
    
    // 4.该方法是在 UIWebView 请求失败的时候调用
    func webView(_ webView: UIWebView, didFailLoadWithError error: any Error){
        print("加载失败")
    }
    
    @IBAction func goToBack(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func goToForward(sender: UIBarButtonItem) {
        webView.goForward()
    }
}
