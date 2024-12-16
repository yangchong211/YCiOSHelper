//
//  StructureCell.swift
//  FunIOS
//
//  Created by redli on 2021/7/25.
//

import UIKit
import SnapKitExtend
import TagListView

public protocol TagViewDelegate : NSObjectProtocol{
    
    //体系Tag点击事件
    func tagStructureClick(parentModel model: StructureModel, childClickIndex clickIndex: Int) -> Void
    
    //导航Tag点击事件
    func tagNavigationClick(parentModel model: NavigationModel, childClickIndex clickIndex: Int) -> Void
}


class StructureCell: BaseTableViewCell {

    weak open var tagDelegate: TagViewDelegate?
    
    private var tagListView: TagListView = TagListView().then { (attr) in
        attr.textFont = UIFont.systemFont(ofSize: 14)
        attr.textColor = UIColor.white
        attr.cornerRadius = 10
        attr.paddingX = 10
        attr.paddingY = 5
        attr.marginX = 10
        attr.marginY = 5
    }
    
    
    override func configUI() {
        contentView.addSubview(tagListView)
        tagListView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    func setModel(type: Int, model: Any) {
        tagListView.removeAllTags();
        if type == 1 {
            let structure = model as! StructureModel
            for (index, value) in structure.children.enumerated() {
                let tagView = self.tagListView.addTag(value.name)
                tagView.tagBackgroundColor = UIColor.randomColor
                tagView.onTap = { tagView in
                    self.tagDelegate?.tagStructureClick(parentModel: structure, childClickIndex: index)
                }
            }
        } else {
            let navigation = model as! NavigationModel
            for (index, value) in navigation.articles.enumerated() {
                let tagView = self.tagListView.addTag(value.title)
                tagView.tagBackgroundColor = UIColor.randomColor
                tagView.onTap = { tagView in
                    self.tagDelegate?.tagNavigationClick(parentModel: navigation, childClickIndex: index)
                }
            }
        }
        contentView.frame.size.height = self.tagListView.height
        contentView.layoutIfNeeded()
        contentView.setNeedsLayout()
    }
    
    var model: StructureModel? {
        didSet {
            guard model == nil else {
                return
            }
        }
    }
}



