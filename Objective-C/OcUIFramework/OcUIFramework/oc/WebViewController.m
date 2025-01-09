//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic , strong) UIWebView *webView;

@end

//UIWebView 是 iOS 开发中用于显示网页内容的视图控件。它是基于 WebKit 引擎的，可以加载并显示网页、执行 JavaScript 代码以及处理与网页交互的事件。
@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWebView];
}


- (void) setWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //创建了一个 NSURLRequest 对象，用于加载指定的网页。
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //使用 loadRequest: 方法加载网页，并将 UIWebView 添加到视图中。
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    //设置代理
    _webView.delegate = self;
}

//实现 UIWebViewDelegate 中的代理方法来处理网页加载事件。
//在示例中，我们展示了三个常用的代理方法，分别在网页开始加载、加载完成和加载失败时被调用。
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 网页开始加载时的处理
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 网页加载完成时的处理
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 网页加载失败时的处理
}

//可以实现 shouldStartLoadWithRequest:navigationType: 方法来处理与网页交互的事件。在上面的示例中，我们返回 YES 表示允许加载请求，你可以根据需要进行逻辑处理。
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 处理与网页交互的事件，如点击链接、提交表单等
    return YES;
}

@end
