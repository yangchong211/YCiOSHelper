//
//  MainVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/21.
//

import UIKit
import Then
import LLCycleScrollView
import SnapKit
import SVProgressHUD
import MBProgressHUD
import HandyJSON

class HomeVController: BaseCVontroller {
    
    var page = 0
    
    private var articleList = Array<ArticleItemModel>()
    
    private var bannerLists = Array<BannerModel>()
    
    private lazy var dispatchGroup = { return DispatchGroup.init() }()
    
    private lazy var tableView: FloatButtonTableView = FloatButtonTableView(frame: .zero, style: .plain).then({ (attr) in
        attr.backgroundColor = UIColor.white
        attr.delegate = self
        attr.dataSource = self
        attr.floatButtonDelegate = self
        attr.alwaysBounceVertical = true
        //        attr.separatorStyle = .none
        attr.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    })
    
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
    
    private func didSelectBanner(index: NSInteger) {
        let bannerModel = self.bannerLists[index]
        let webVController = WebVController(title: bannerModel.title, url: bannerModel.url)
        navigationController?.pushViewController(webVController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(statusBarHeight)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-40)
        }
        
        tableView.tableHeaderView = bannerView
        
        self.view.addSubview(floatButton)
        floatButton.snp.makeConstraints { maker in
            maker.bottom.equalToSuperview().offset(-80)
            maker.right.equalToSuperview().offset(-30)
        }
        
        floatButton.addTarget(self, action: #selector(topOffset), for: .touchUpInside)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        setRefresh()
    }
    
    @objc func topOffset() {
        self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: floatAnimal)
    }
    
    private func setRefresh() {
        
        let refreshHeader = RefreshHeader{ [weak self] in
            self?.page = 0
            self?.getData(false)
        }
        
        refreshHeader.isAutomaticallyChangeAlpha = true
        refreshHeader.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = refreshHeader
        refreshHeader.beginRefreshing()
        
        tableView.mj_footer =  RefreshFooter{ [weak self] in
            self?.getData(true)
        }
        tableView.mj_footer?.isAutomaticallyChangeAlpha = true
    }
    
    
    private func getData(_ loadMore: Bool = false) {
        if !loadMore {
            page = 0
        } else {
            page += 1
        }
        
        if !loadMore {
            Api.fetchBanners(success: {(value:Array<BannerModel>?) in
                self.bannerLists = value ?? []
                self.bannerView.imagePaths = value?.map{$0.imagePath} ?? []
                self.bannerView.titles = value?.map{ $0.title} ?? []
            }, error: error(error:))
            
            self.dispatchGroup.enter()
            Api.fetchTopArticles(success: {(value: Array<ArticleItemModel>?) in
                self.articleList = value ?? []
                self.dispatchGroup.leave()
            }, error: error(error:))
        }
        
        self.dispatchGroup.enter()
        Api.fetchArticles(page: page, success: { (value: ArticleModel?) in
            //结束刷新
            if self.tableView.mj_header!.isRefreshing  { self.tableView.mj_header?.endRefreshing()
            }
            
            if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_footer?.endRefreshing()
            }
            
            //是否加载更多
            if loadMore {
                if value?.datas.count ?? 0 <= 0 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()                } else {
                        self.articleList.append(contentsOf: value!.datas)
                    }
            } else {
                if value?.datas.count ?? 0 < (loadMore ? 20 : 19) {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.articleList.append(contentsOf: value!.datas)
            }
            self.dispatchGroup.leave()
        }, error: error(error:))
        
        self.dispatchGroup.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
        }
    }
    
}

extension HomeVController: UITableViewDataSource, UITableViewDelegate, CollectDelegate , FloatButtonDelegate{
    //数据
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    //每行行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    //每行加载样式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func floatStatus(forHide hide: Bool, withAnimal animal: Bool) {
        floatButton.isHidden = hide
        floatAnimal = animal
    }
}
