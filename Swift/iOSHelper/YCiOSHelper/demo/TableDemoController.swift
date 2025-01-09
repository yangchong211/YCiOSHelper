//
//  TableDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/28.
//

import UIKit

class TableDemoController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    private var tableView : UITableView = UITableView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView();
    }
    
    private func myTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain);//设置 TableView 的 frame 和 style
        tableView.backgroundColor =  UIColor(red: 0.0, green: 127.0, blue: 127.0, alpha: 1.0);//设置 TableView 的背景色
        tableView.delegate = self;  //设置 TableView 的代理对象
        tableView.dataSource = self //设置 TableView 的数据源对象
        tableView.rowHeight = 44;   //设置 TableView 每一行 Cell 的高度
        tableView.sectionHeaderHeight = 50; //设置 TableView 每一行 Cell 页头的行高
        tableView.sectionFooterHeight = 50; //设置 TableView 每一行 Cell 页尾的行高
        tableView.estimatedRowHeight = 100; //设置 TableView 每一行 Cell 的估计行高
        tableView.separatorColor = UIColor.gray;//设置 TableView 每一行 Cell 之间分割线的颜色
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 50, bottom: 0, right: 50);//设置 TableView 每一行 Cell 之间分割线位置(分别是: 上, 左, 下, 右)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine;//设置 TableView 每一行 Cell 之间的分割线样式(默认是 SingleLine 样式)
        tableView.setEditing(true, animated: true);//设置 TableView 的编辑模式是否开启, 并且是否使用动画效果
        tableView.allowsSelection = true;        //是否可以支持选中
        self.view.addSubview(tableView);//添加到 self.view 上
    }
    
    // 1.该方法是用来设置 TableView 有多少组 Cell
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // 2.该方法是用来设置 TableView 有多少行 Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    // 3.该方法是用来设置 TableView 每一行 Cell 的详细内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.dequeueReusableCell 是 UITableView 的一个方法，用于获取可重用的 UITableViewCell 实例。
        //在使用 UITableView 显示大量数据时，为了提高性能和内存利用率，UITableView 会使用可重用的 UITableViewCell 实例来显示不同的行。
        //当滚动 UITableView 时，超出屏幕范围的 UITableViewCell 会被回收并放入可重用队列中，然后可以通过 dequeueReusableCell(withIdentifier:for:) 方法来获取可重用的实例。
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCustomCell.reuseIdenfitifer, for: indexPath)
        //let cell = UITableViewCell();
        cell.textLabel?.text = "我是cell"; //设置 UITableViewCell 的标题Label
        cell.detailTextLabel?.text = "Cell"; //设置 UITableViewCell 的简介Label
        cell.imageView?.image = UIImage(named: "1.png"); //设置 UITableViewCell 的 imageView 图片
        cell.setEditing(true, animated: true); //设置 UITableViewCell 的编辑模式是否开启, 以及是否执行动画效果
        cell.backgroundColor = UIColor.blue;    //设置 UITableViewCell 的背景色
        cell.selectionStyle = UITableViewCell.SelectionStyle.default;//设置 UITableViewCell 被选中的样式
        cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 20);//设置 UITableViewCell 分割线的位置
        return cell;
    }
    
    // 4.该方法是用来设置 TableView 每一行 Cell 的标题内容
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "我是页头"
    }
    
    // 5.该方法是用来设置 TableView 每一行 Cell 的页尾内容
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "我是页尾"
    }
    
    // 6.该方法是用来设置 TableView 每一行 Cell 的高度, 一旦这里设置了, 那么在自定义里的 rowHeight 属性就会被覆盖
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    // 7.该方法是用来响应 TableVIewCell 被点击的事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("我被点击了");
    }
    
    // 8.该方法是用来设置 TableView 每一行 Cell 的编辑模式, 如果不设置, 默认都是删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.insert
    }
    
    // 9.该方法是用来设置 Tabelview 的左滑快捷按钮, 只要写了该方法, 默认打开
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: IndexPath) {
    }
    
    // 10.该方法是用来设置 TabelView 左滑快捷按钮的详细内容以及操作
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "删除"
    }
    
    // 11.该方法是用来设置 TableView 是否可以拖拽到其他行数, 只要写了该方法, 默认打开
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    }
    
    // 12.cell开始显示了
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //IndexPath 是一个用于表示 UITableView 中行和节的索引的结构体。它由两个属性组成：section 和 row。
        //section 属性表示 UITableView 中的节（section）的索引，从 0 开始计数。
        //row 属性表示指定节中的行（row）的索引，也从 0 开始计数。
        let section = indexPath.section
        let row = indexPath.row
        // 处理选中的行
        print("tableView开始显示 \(section) 节的第 \(row) 行")
        
        print("tableView开始显示 \(indexPath)")
    }
    
    // 13.cell不被显示了
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView开始销毁 \(indexPath)")
    }
    
    //14.item点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView(_:didSelectRowAt:) 是 UITableView 的委托方法之一，用于响应用户在 UITableView 中选中某一行的事件。
        //当用户点击 UITableView 中的某一行时，系统会调用 tableView(_:didSelectRowAt:) 方法，并传递选中行的 IndexPath 参数。
    }
}

class TableViewCustomCell : UITableViewCell {
    //定义了一个 UITableViewCell 的重用标识符 cellIdentifier
    static let reuseIdenfitifer = "TableViewCustomCell"
}
