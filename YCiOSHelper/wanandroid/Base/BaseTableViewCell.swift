//
//  BaseTableViewCell.swift
//  FunIOS
//
//  Created by redli on 2021/7/22.
//

import UIKit
import Reusable


// Reusable 是用回收的

/**
 收藏功能提到basecell 。这个项目每个列表都有收藏功能。可加可不加
 */

class BaseTableViewCell: UITableViewCell, Reusable {
    
    weak open var collectDelegate: CollectDelegate?
    
    //是否收藏
    var isCollect = false
    
    lazy var imgCollect = UIButton().then({attr in
        attr.setImage(UIImage(named: "ic_uncollect"), for: .normal)
    })
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    open func configUI() {
        
    }
    
    func refreshCollect(isCollect collect: Bool) {
        if collect {
            imgCollect.setImage(UIImage(named: "ic_collect"), for: .normal)
        } else {
            imgCollect.setImage(UIImage(named: "ic_uncollect"), for: .normal)
        }
        self.isCollect = collect
    }
    
    @objc func collect(btn: UIButton) {
        if self.isCollect {
            collectDelegate?.uncollectAirticle(cid: btn.tag, tabCell: self)
        } else {
            collectDelegate?.collectAirticle(cid: btn.tag, tabCell: self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
