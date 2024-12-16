//
//  CollectCell.swift
//  FunIOS
//
//  Created by redli on 2021/8/10.
//

import Foundation
import UIKit

class CollectCell: BaseTableViewCell {
    private lazy var  labelAuthor = UILabel().then({ (attr) in
        attr.text = "author"
        attr.font = UIFont.systemFont(ofSize: 15)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    private lazy var  labelTime = UILabel().then({ (attr) in
        attr.text = "Time"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 14)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    
    private lazy var labelTitle: UILabel = UILabel().then {(attr) in
        attr.text = "Titile"
        attr.textColor = .black
        attr.font = UIFont.boldSystemFont(ofSize: 15)
        attr.numberOfLines = 2 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    }
    
    private lazy var labelDesc: UILabel = UILabel().then { (attr) in
        attr.text = "desc"
        attr.font = UIFont.systemFont(ofSize: 14)
        attr.numberOfLines = 2 //相当于不限制行数
        attr.lineBreakMode = .byTruncatingTail
        attr.sizeToFit()
        attr.isHidden = true
        attr.backgroundColor = UIColor.white
    }
    
    
    private lazy var labelChapterName = UILabel().then({(attr) in
        attr.text = "ChapterName"
        attr.textColor = .gray
        attr.font = UIFont.boldSystemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    private lazy var labelSuperChapterName = UILabel().then({(attr) in
        attr.text = "SuperChapterName"
        attr.textColor = .gray
        attr.font = UIFont.boldSystemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    private lazy var line = UIView().then({ (attr) in
        attr.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    })
    
    var model: ArticleItemModel?{
        didSet {
            guard model == nil else {
                labelAuthor.text = (model?.author.isEmpty)! ? model?.shareUser : model?.author
                labelTime.text = model?.niceDate
                labelTitle.text = model?.title
                labelDesc.text = model?.desc
                labelSuperChapterName.text = model?.superChapterName
                labelChapterName.text = " · \(model?.chapterName ?? "")"
                return
            }
        }
    }
    
    
    override func configUI() {
        contentView.addSubview(labelAuthor)
        labelAuthor.snp.makeConstraints {(maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(10)
            
        }

        contentView.addSubview(labelTime)
        labelTime.snp.makeConstraints({(maker) in
            maker.trailing.equalToSuperview().offset(-10)
            maker.top.equalToSuperview().offset(10)
        })

        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints({(maker) in
            maker.top.equalTo(labelAuthor.snp.bottom).offset(10)
            maker.top.equalTo(labelTime.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
        })
        
//        contentView.addSubview(labelDesc)
//        labelDesc.snp.makeConstraints { (maker) in
//            maker.top.equalTo(labelTitle.snp.bottom).offset(10)
//            maker.leading.equalToSuperview().offset(10)
//            maker.trailing.equalToSuperview().offset(-10)
//        }
        
        contentView.addSubview(labelSuperChapterName)
        labelSuperChapterName.snp.makeConstraints {(maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalTo(labelTitle.snp.bottom).offset(10)
        }

        contentView.addSubview(labelChapterName)
        labelChapterName.snp.makeConstraints({(maker) in
            maker.leading.equalTo(labelSuperChapterName.snp.trailing)
            maker.top.equalTo(labelTitle.snp.bottom).offset(10)
        })
        
        contentView.addSubview(line)
        line.snp.makeConstraints { (maker) in
            maker.top.equalTo(labelSuperChapterName.snp.bottom).offset(10)
            maker.top.equalTo(labelChapterName.snp.bottom).offset(10)
            maker.bottom.equalToSuperview()
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
            maker.height.equalTo(1)
        }
    }
}
