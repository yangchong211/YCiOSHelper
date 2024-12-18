//
//  ScrollDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/28.
//

import UIKit

//滚动布局
class ScrollDemoController: UIViewController,UIScrollViewDelegate {

    private let scrollView : UIScrollView = UIScrollView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewUI();
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame.size = view.frame.size;
        scrollView.frame.origin.y = view.safeAreaInsets.top;
        scrollView.frame.size.height -= view.safeAreaInsets.top + view.safeAreaInsets.bottom;
    }
    
    private func scrollViewUI() {
        scrollView.backgroundColor = UIColor.yellow;
        scrollView.contentOffset = CGPoint(x: 0, y: 0);// 设置内容的中心点, 默认是0
        scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20);//设置UIScrollView的边距, 默认是0
        scrollView.isPagingEnabled = false; //设置UIScrollView是否可以翻页, 默认是false
        scrollView.isScrollEnabled = true;  //设置UIScrollView是否滚动可用, 默认是true
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero;//设置UIScrollView滚动条显示的位置, 默认是0
        scrollView.scrollsToTop = true; //设置点击状态栏就回到ScrollView的最顶部, 默认是true
        scrollView.bouncesZoom = true;  //设置缩放视图时是否有弹簧效果, 默认是true
        scrollView.delegate = self;
        //scrollView.contentSize = CGSize(width: 0, height: 0);//设置内容的宽高, 默认是0
        scrollView.contentSize = CGSize(width: view.frame.width, height: 5000);
        //是否隐藏进度条
        scrollView.automaticallyAdjustsScrollIndicatorInsets = true;
        view.addSubview(scrollView);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("did scroll \(scrollView.contentOffset)");
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("did scroll to top \(scrollView.contentOffset)");
    }
    
}
