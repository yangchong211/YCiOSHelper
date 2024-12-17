//
//  UserCell.swift
//  FunIOS
//
//  Created by redli on 2021/8/9.
//

import UIKit

class UserCell: BaseTableViewCell {

    private let icon = UIImageView().then { attr in
        attr.contentMode = .scaleAspectFit
    }
    
    private let title = UILabel().then { attr in
        
    }
    
    private lazy var line = UIView().then({ attr in
        attr.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    var model: MenuItem? {
        didSet {
            guard model == nil else {
                title.text = model?.title
                icon.image = UIImage(named: model?.icon ?? "")
                return
            }
        }
    }
    
    override func configUI() {
        contentView.addSubview(line)
        line.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
            maker.height.equalTo(1)
        }
        contentView.addSubview(icon)
        icon.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(title)
        title.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(icon.snp.trailing).offset(10)
        }
        
    }
}
