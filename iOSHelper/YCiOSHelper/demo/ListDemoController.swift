//
//  ListDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import UIKit

//这个list条目
class ListDemoController: UIViewController {

    private let tableView = UITableView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List条目控件View展示案例"
        setupTableView()
        //当数据源发生变化时，表格视图将刷新其内容，显示最新的数据。
        //这是一个常见的动态更新用户界面的策略。
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //填充整个布局
        tableView.frame = view.bounds
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: HeroSectionHeaderView.identifierString)
        tableView.register(HeroTableViewCell.self, forCellReuseIdentifier: HeroTableViewCell.identifierString)
        tableView.rowHeight = 80
        view.addSubview(tableView)
    }
}

//这里使用拓展类，专门处理tableView
extension ListDemoController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeroSectionHeaderView.identifierString) as! HeroSectionHeaderView
        let sections = HeroDataBase.sections()
        headerView.title = sections[section].category.rawValue
        return headerView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return HeroDataBase.sections().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = HeroDataBase.sections()
        return sections[section].heros.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifierString, for: indexPath)
        if let heroCell = cell as? HeroTableViewCell,
            let hero = heroItem(at: indexPath) {
            heroCell.config(with: hero)
        }
        return cell
    }

    func heroItem(at indexPath: IndexPath) -> Hero? {
        let sections = HeroDataBase.sections()
        guard sections.count > indexPath.section else {
            return nil
        }
        let section = sections[indexPath.section]
        guard section.heros.count > indexPath.row else {
            return nil
        }
        return section.heros[indexPath.row]
    }
}


class HeroSectionHeaderView: UITableViewHeaderFooterView {

    static let identifierString = "HeroSectionHeaderView"

    private var label: UILabel!

    public var title: String = "" {
        didSet {
            label.text = title
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        label = UILabel(frame: CGRect.zero)
        contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = contentView.bounds
        frame.origin.x = 10
        label.frame = frame
    }
}

class HeroTableViewCell: UITableViewCell {
    static let identifierString = "HeroTableViewCell"

    private var heroImageView = UIImageView()
    private var titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heroImageView.contentMode = .scaleAspectFit
        contentView.addSubview(heroImageView)
        contentView.addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = contentView.frame.size.height
        heroImageView.frame = CGRect(x: 10, y: 0, width: height, height: height)
        titleLabel.frame = CGRect(x: heroImageView.frame.maxX + 10, y: 0, width: contentView.bounds.size.width - height - 10, height: height)
    }

    public func config(with hero: Hero) {
        heroImageView.image = UIImage(named: hero.imageName)
        titleLabel.text = hero.name;
    }

}

