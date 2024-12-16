//
//  MenuCell.swift
//  FunIOS
//
//  Created by redli on 2021/7/29.
//

import UIKit
import Reusable

class MenuCell: UICollectionViewCell, Reusable {
    
    var labelTitle: UILabel!
    var imgIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.labelTitle = UILabel().then({ (attr) in
            attr.textAlignment = .center
            attr.font = UIFont.systemFont(ofSize: 12)
        })
        
        self.imgIcon = UIImageView().then({ (attr) in
            attr.contentMode = .scaleAspectFit
        })
        
        contentView.addSubview(self.imgIcon)
        self.imgIcon.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(7)
//            maker.leading.equalToSuperview()
//            maker.trailing.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        contentView.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.imgIcon.snp.bottom).offset(5)
//            maker.leading.equalToSuperview()
//            maker.trailing.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
