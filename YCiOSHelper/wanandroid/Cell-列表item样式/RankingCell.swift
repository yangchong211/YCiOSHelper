//
//  RankingCell.swift
//  FunIOS
//
//  Created by redli on 2021/8/10.
//

import Foundation
import UIKit

class RankingCell: BaseTableViewCell {

    private let labelLeading = UILabel().then { attr in
        attr.textColor = UIColor.white
        attr.layer.cornerRadius = 20
        attr.layer.masksToBounds = true
        attr.backgroundColor = UIColor.randomColor
        attr.font = .boldSystemFont(ofSize: 12)
        attr.textAlignment = .center
    }
    
    private let labelTitle = UILabel().then { attr in
        attr.font = .boldSystemFont(ofSize: 16)
        attr.textColor = UIColor.black
    }
    
    private let labelSubTitle = UILabel().then { attr in
        attr.font = .systemFont(ofSize: 14)
    }
    
    private let labelTrailing = UILabel().then { attr in
        
    }
    
    var model: UserCoinLevelModel? {
        didSet {
            guard model == nil else {
                labelTitle.text = model?.username
                labelSubTitle.text = "\(model?.level ?? 0)"
                labelTrailing.text = "\(model?.coinCount ?? 0)"
                return
            }
        }
    }
    
    var index: Int? {
        didSet {
            guard model == nil else {
                labelLeading.text = "\(index ?? 0)"
                return
            }
        }
    }
    
    override func configUI() {
        contentView.addSubview(labelLeading)
        labelLeading.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(20)
            maker.centerY.equalToSuperview()
            maker.height.equalTo(40)
            maker.width.equalTo(40)
        }
        
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { maker in
            maker.leading.equalTo(labelLeading.snp.trailing).offset(10)
            maker.top.equalToSuperview().offset(10)
        }

        contentView.addSubview(labelSubTitle)
        labelSubTitle.snp.makeConstraints { maker in
            maker.leading.equalTo(labelLeading.snp.trailing).offset(10)
//            maker.top.equalTo(labelTitle.snp.bottom).offset(5)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(labelTrailing)
        labelTrailing.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().offset(-20)
            maker.centerY.equalToSuperview()
        }
    }
}
