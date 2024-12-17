//
//  RankingVController.swift
//  FunIOS
//
//  Created by redli on 2021/8/10.
//

import Foundation
import UIKit


class RankingVController: BaseCVontroller {
    // 当前页面
    var page = 1
    
    private var data = [UserCoinLevelModel]()
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then({ (attr) in
        attr.backgroundColor = UIColor.white
        attr.delegate = self
        attr.dataSource = self
        attr.alwaysBounceVertical = true
        attr.rowHeight = 60
        attr.register(cellType: RankingCell.self)
    })
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "排行榜"
    }
    
    override func viewDidLoad() {
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {  (maker) in
            maker.top.equalToSuperview().offset(statusBarHeight + navigationHeight)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        setRefresh()
    }
    
    private func setRefresh() {
        
        let refreshHeader = RefreshHeader{ [weak self] in
            self?.page = 1
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
        
        Api.fetchRanking(page: page, success: { (value: RankingModel?) in
            //结束刷新
            if self.tableView.mj_header!.isRefreshing  { self.tableView.mj_header?.endRefreshing()
            }
            
            if self.tableView.mj_footer!.isRefreshing { self.tableView.mj_footer?.endRefreshing()
            }
            
            //是否加载更多
            if loadMore {
                if value?.datas.count ?? 0 <= 0 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()                } else {
                        self.data.append(contentsOf: value!.datas)
                    }
            } else {
                if value?.datas.count ?? 0 < 20 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }
                self.data = value?.datas ?? []
            }
            
            self.tableView.reloadData()
        }, error: error(error:))
    }
}

extension RankingVController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RankingCell.self)
        cell.model = self.data[indexPath.row]
        cell.index = indexPath.row + 1
        return cell
    }
}
