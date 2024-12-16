//
//  ProjectArticlesVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/25.
//

import UIKit
import JXSegmentedView

class ProjectArticlesVController: BaseCVontroller {
    
    
    // 当前页面
    var page = 0
    //文章id
    var cid : Int = 0
    //实体类数组
    private var articleList = [ArticleItemModel]()
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then({ (attr) in
        attr.backgroundColor = UIColor.white
        attr.delegate = self
        attr.dataSource = self
        attr.alwaysBounceVertical = true
//        attr.separatorStyle = .none
        attr.register(cellType: ProjectCell.self)
//        attr.rowHeight = 150
    })
    
    
    
    convenience init(cid: Int) {
        self.init()
        self.cid = cid
    }
    
    
    override func viewDidLoad() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {  (maker) in
            maker.edges.equalToSuperview()
        }
        
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        setRefresh()
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
        
        Api.fetchProjectArticles(page: page, cid: cid, success: { (value: ArticleModel?) in
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
                if value?.datas.count ?? 0 < 20 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.articleList = value?.datas ?? []
            }
            
            self.tableView.reloadData()
        }, error: error(error:))
    }
}

extension ProjectArticlesVController: JXSegmentedListContainerViewListDelegate, UITableViewDataSource, UITableViewDelegate, CollectDelegate {
    func listView() -> UIView {
        view
    }
    
    //数据
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    //每行加载样式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: ProjectCell.self)
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
            let cell = tabviewCell as! ProjectCell
            cell.refreshCollect(isCollect: true)
            self.view.makeToast("收藏成功")
        }, error: error(error:))
    }
    
    //取消收藏文章
    func uncollectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) {
        Api.uncollect(cid: id, success: { value in
            let cell = tabviewCell as! ProjectCell
            cell.refreshCollect(isCollect: false)
            self.view.makeToast("取消收藏成功")
        }, error: error(error:))
    }
}

