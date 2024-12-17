//
//  MainVController.swift
//  FunIOS
//
//  Created by 杨充 on 2021/7/21.
//

import UIKit
import Then
import LLCycleScrollView
import SnapKit
import SVProgressHUD
import MBProgressHUD
import HandyJSON

//首页
class HomeController: UIViewController {
    
    var page = 0
    
    private var floatAnimal = false
    
    private var floatButton = UIButton().then({attr in
        attr.setImage(UIImage(named: "ic_top"), for: .normal)
        attr.contentMode = .scaleToFill
        attr.isHidden = true
    })
    
    private var backButton = UIButton().then({attr in
        attr.setImage(UIImage(named: "back"), for: .normal)
        attr.contentMode = .scaleToFill
        attr.isHidden = true
    })
    //文章list
    private var articleList = Array<ArticleItemModel>()
    //轮播图list
    private var bannerLists = Array<BannerModel>()
    
    //DispatchGroup 是一个用于管理多个异步任务的工具。它可以让你等待一组任务完成后再执行其他操作。
    private lazy var dispatchGroup = { return DispatchGroup.init() }()
    
    //这个是容器
    private lazy var controllerTableView: HomeControllerTableView = HomeControllerTableView(frame: .zero, style: .plain).then({ (attr) in
        attr.backgroundColor = UIColor.white
        attr.delegate = self
        attr.dataSource = self
        attr.homeTableDelegate = self
        attr.alwaysBounceVertical = true
        //        attr.separatorStyle = .none
        attr.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    })
    
    //轮播图
    private lazy var bannerView = LLCycleScrollView().then({ (attr) in
        attr.backgroundColor = UIColor.yellow
        attr.autoScrollTimeInterval = 5
        attr.placeHolderImage = UIImage(named: "normal_placeholder_h")
        attr.coverImage = UIImage(named: "normal_placeholder_h")
        attr.imageViewContentMode = .scaleToFill
        attr.pageControlPosition = .right
        attr.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth / 2)
        attr.lldidSelectItemAtIndex = self.didSelectBanner(index:)
    })
    
    //轮播图选中
    private func didSelectBanner(index: NSInteger) {
        let bannerModel = self.bannerLists[index]
        let webVController = WebVController(title: bannerModel.title, url: bannerModel.url)
        navigationController?.pushViewController(webVController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        //添加tableView，这个是容器View
        self.view.addSubview(controllerTableView)
        controllerTableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(statusBarHeight)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-40)
        }
        //添加banner轮播图
        controllerTableView.tableHeaderView = bannerView
        //添加悬浮btn按钮
        self.view.addSubview(floatButton)
        floatButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-100)
            maker.right.equalToSuperview().offset(-30)
        }
        floatButton.addTarget(self, action: #selector(topOffset), for: .touchUpInside)
        
        if #available(iOS 11.0, *) {
            //是一个用于设置全局 UIScrollView 的 contentInsetAdjustmentBehavior 属性的方法。
            //该属性用于控制 UIScrollView 在滚动时是否自动调整其内容的内边距。
            //.never：不自动调整内容的内边距。
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            //automaticallyAdjustsScrollViewInsets 是一个 UIViewController 的属性
            //用于控制视图控制器中的 UIScrollView 是否自动调整其内容的内边距。
            automaticallyAdjustsScrollViewInsets = false
        }
        //设置刷新
        setRefresh()
    }
    
    //悬浮按钮点击事件，点击回到顶部
    @objc func topOffset() {
        //tableView.scrollToRow 是一个用于将 UITableView 滚动到指定行的方法
        //要滚动到的行的索引路径
        let indexPath = IndexPath.init(row: 0, section: 0)
        //at 参数用于指定滚动到行的位置，可以是 .top、.middle 或 .bottom。
        //animated 参数用于指定是否使用动画效果进行滚动。
        self.controllerTableView.scrollToRow(at: indexPath, at: .bottom, animated: floatAnimal)
    }
    
    //设置刷新
    private func setRefresh() {
        let refreshHeader = RefreshHeader{ [weak self] in
            self?.page = 0
            //开始获取数据
            self?.getData(false)
        }
        refreshHeader.isAutomaticallyChangeAlpha = true
        refreshHeader.lastUpdatedTimeLabel?.isHidden = true
        controllerTableView.mj_header = refreshHeader
        refreshHeader.beginRefreshing()
        controllerTableView.mj_footer =  RefreshFooter{ [weak self] in
            self?.getData(true)
        }
        controllerTableView.mj_footer?.isAutomaticallyChangeAlpha = true
    }
    
    //开始获取数据
    private func getData(_ loadMore: Bool = false) {
        if !loadMore {
            page = 0
        } else {
            page += 1
        }
        
        if !loadMore {
            //开始获取轮播图数据
            Api.fetchBanners(success: {(value:Array<BannerModel>?) in
                self.bannerLists = value ?? []
                self.bannerView.imagePaths = value?.map{$0.imagePath} ?? []
                self.bannerView.titles = value?.map{ $0.title} ?? []
            }, error: error(error:))
            
            
            //enter() 和 leave() 方法可以嵌套使用，以处理更复杂的任务结构。
            self.dispatchGroup.enter()
            //获取置顶文章列表
            Api.fetchTopArticles(success: {(value: Array<ArticleItemModel>?) in
                self.articleList = value ?? []
                self.dispatchGroup.leave()
            }, error: error(error:))
        }
        
        
        self.dispatchGroup.enter()
        //获取文章列表
        Api.fetchArticles(page: page, success: { (value: ArticleModel?) in
            //结束刷新
            if self.controllerTableView.mj_header!.isRefreshing  { self.controllerTableView.mj_header?.endRefreshing()
            }
            
            if self.controllerTableView.mj_footer!.isRefreshing { self.controllerTableView.mj_footer?.endRefreshing()
            }
            //是否加载更多
            if loadMore {
                if value?.datas.count ?? 0 <= 0 {
                    self.controllerTableView.mj_footer?.endRefreshingWithNoMoreData()                } else {
                        self.articleList.append(contentsOf: value!.datas)
                    }
            } else {
                if value?.datas.count ?? 0 < (loadMore ? 20 : 19) {
                    self.controllerTableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.articleList.append(contentsOf: value!.datas)
            }
            self.dispatchGroup.leave()
        }, error: error(error:))
        
        // 等待 DispatchGroup 中的任务完成
        self.dispatchGroup.notify(queue: DispatchQueue.main) {
            self.controllerTableView.reloadData()
        }
    }
    
}

extension HomeController: UITableViewDataSource, UITableViewDelegate, CollectDelegate , HomeTableDelegate {
    
    //数据
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //这个是table有多少个cell
        return articleList.count
    }
    
    //每行行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    //每行加载样式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.dequeueReusableCell 是 UITableView 的一个方法，用于获取可重用的 UITableViewCell 实例。
        //在使用 UITableView 显示大量数据时，为了提高性能和内存利用率，UITableView 会使用可重用的 UITableViewCell 实例来显示不同的行。
        //当滚动 UITableView 时，超出屏幕范围的 UITableViewCell 会被回收并放入可重用队列中，然后可以通过 dequeueReusableCell(withIdentifier:for:) 方法来获取可重用的实例。
        let tableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: ArticleCell.self)
        tableViewCell.collectDelegate = self
        tableViewCell.model = articleList[indexPath.row]
        return tableViewCell
    }
    
    //item点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.articleList[indexPath.row]
        let webVController = WebVController(title: model.title, url: model.link)
        navigationController?.pushViewController(webVController, animated: true)
    }
    
    //收藏文章
    func collectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) {
        Api.collect(cid: id, success: { value in
            let cell = tabviewCell as! ArticleCell
            cell.refreshCollect(isCollect: true)
            self.view.makeToast("收藏成功")
        }, error: error(error:))
    }
    
    //取消收藏文章
    func uncollectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) {
        Api.uncollect(cid: id, success: { value in
            let cell = tabviewCell as! ArticleCell
            cell.refreshCollect(isCollect: false)
            self.view.makeToast("取消收藏成功")
        }, error: error(error:))
    }
    
    //悬浮按钮的状态
    func floatStatus(forHide hide: Bool, withAnimal animal: Bool) {
        floatButton.isHidden = hide
        floatAnimal = animal
    }
}


