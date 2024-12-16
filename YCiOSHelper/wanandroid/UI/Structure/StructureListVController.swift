//
//  StructureListVController.swift
//  FunIOS
//
//  Created by redli on 2021/7/27.
//

import UIKit
import JXSegmentedView


class StructureListVController: BaseCVontroller {
    
    //type = 1 体系， type = 2 导航
    private var type = 1
    
    private var list = [Any]()
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then({ (attr) in
        attr.backgroundColor = UIColor.white
        attr.delegate = self
        attr.dataSource = self
        attr.alwaysBounceVertical = true
        attr.separatorStyle = .none
    })
    
    convenience init(type: Int) {
        self.init()
        self.type = type
        
        if type == 1 {
            self.list = [StructureModel]()
        } else {
            self.list = [NavigationModel]()
        }
    }
    
    
    override func viewDidLoad() {
        tableView.register(cellType: StructureCell.self)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {  (maker) in
            maker.edges.equalToSuperview()
        }
        
        setRefresh()
    }
    
    private func setRefresh() {
        
        let refreshHeader = RefreshHeader{ [weak self] in
            self?.getData()
        }
        
        refreshHeader.isAutomaticallyChangeAlpha = true
        refreshHeader.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = refreshHeader
        refreshHeader.beginRefreshing()
    }
    
    
    private func getData() {
        if type == 1 {
            Api.fetchStructures(success: { (value: Array<StructureModel>?) in
                self.reloadTable(value: value)
            }, error: error(error:))
        } else {
            Api.fetchNavigations(success: { (value: Array<NavigationModel>?) in
                self.reloadTable(value: value)
            }, error: error(error:))
        }
    }
    
    private func reloadTable(value: Array<Any>?) {
        self.list.append(contentsOf: value ?? [])
        self.tableView.reloadData()
        //结束刷新
        if self.tableView.mj_header!.isRefreshing  { self.tableView.mj_header?.endRefreshing()
        }
        
        //刷新一下tableview布局
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {[weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
    }
}

extension StructureListVController: UITableViewDelegate, UITableViewDataSource,  JXSegmentedListContainerViewListDelegate, TagViewDelegate {
    
    func tagStructureClick(parentModel model: StructureModel, childClickIndex clickIndex: Int) {
        let structureDetailVController = StructureDetailVController.init(parentModel: model, childClickIndex: clickIndex)
        navigationController?.pushViewController(structureDetailVController, animated: true)
    }
    
    func tagNavigationClick(parentModel model: NavigationModel, childClickIndex clickIndex: Int) {
        let item = model.articles[clickIndex]
        let webVController = WebVController(title: item.title, url: item.link)
        navigationController?.pushViewController(webVController, animated: true)
    }
    
    func listView() -> UIView {
        view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        let viewLabel = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        if self.type == 1 {
            viewLabel.text = (self.list[section] as! StructureModel).name
        } else {
            viewLabel.text = (self.list[section] as! NavigationModel).name
        }
        
        viewLabel.textColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        view.addSubview(viewLabel)
        tableView.addSubview(view)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if self.type == 1 {
        //            return (self.list[section] as! StructureModel).children.count
        //        } else {
        //            return (self.list[section] as! NavigationModel).articles.count
        //        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: StructureCell.self)
        tableViewCell.tagDelegate = self
        if self.type == 1 {
            //            tableViewCell.setModel(type: 1, model: (self.list[indexPath.section] as! StructureModel).children[indexPath.row])
            tableViewCell.setModel(type: 1, model: (self.list[indexPath.section] as! StructureModel))
        } else {
            //            tableViewCell.setModel(type: 2, model: (self.list[indexPath.section] as! NavigationModel).articles[indexPath.row])
            tableViewCell.setModel(type: 2, model: (self.list[indexPath.section] as! NavigationModel))
        }
        return tableViewCell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if type == 1 {
    //            let model = (self.list[indexPath.section] as! StructureModel).children[indexPath.row]
    //        } else {
    //            let model = (self.list[indexPath.section] as! NavigationModel).articles[indexPath.row]
    //            let webVController = WebVController(title: model.title, url: model.link)
    //            navigationController?.pushViewController(webVController, animated: true)
    //        }
    //    }
}
