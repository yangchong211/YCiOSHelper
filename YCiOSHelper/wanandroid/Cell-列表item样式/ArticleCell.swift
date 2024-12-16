//
//  ArticleCell.swift
//  FunIOS
//
//  Created by redli on 2021/7/22.
//

import UIKit
import SnapKitExtend

public protocol CollectDelegate : NSObjectProtocol{
    
    //收藏 文章
    func collectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) -> Void
    
    //取消收藏 文章
    func uncollectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) -> Void
}


class ArticleCell: BaseTableViewCell {
    
    private lazy var  labelAuthor = UILabel().then({ (attr) in
        attr.text = "author"
        attr.font = UIFont.systemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    private lazy var  labelTime = UILabel().then({ (attr) in
        attr.text = "Time"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    
    private lazy var labelTitle: UILabel = UILabel().then {(attr) in
        attr.text = "Titile"
        attr.textColor = .black
        attr.font = UIFont.systemFont(ofSize: 14)
        attr.numberOfLines = 2 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    }
    
    
    private lazy var labelChapterName = UILabel().then({(attr) in
        attr.text = "ChapterName"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 10)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    private lazy var  labelSuperChapterName = UILabel().then({(attr) in
        attr.text = "SuperChapterName"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 10)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    var model: ArticleItemModel?{
        didSet {
            guard model == nil else {
                labelAuthor.text = (model?.author.isEmpty)! ? model?.shareUser : model?.author
                labelTime.text = model?.niceShareDate
                labelTitle.text = model?.title
                labelSuperChapterName.text = model?.superChapterName
                labelChapterName.text = " · \(model?.chapterName ?? "")"

                isCollect = model?.collect ?? false
                
                refreshCollect(isCollect: isCollect)
                
                imgCollect.tag = model?.id ?? 0
                return
            }
        }
    }
    
    override func configUI() {
        contentView.addSubview(labelAuthor)
        labelAuthor.snp.makeConstraints {maker in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(10)
        }

        contentView.addSubview(labelTime)
        labelTime.snp.makeConstraints({maker in
            maker.trailing.equalToSuperview().offset(-10)
            maker.top.equalToSuperview().offset(10)
        })

        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints({maker in
            maker.top.equalTo(labelAuthor.snp.bottom).offset(10)
            maker.leading.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-10)
            
        })
        
        contentView.addSubview(labelSuperChapterName)
        labelSuperChapterName.snp.makeConstraints {maker in
            maker.leading.equalToSuperview().offset(10)
            maker.top.equalTo(labelTitle.snp.bottom).offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }

        contentView.addSubview(labelChapterName)
        labelChapterName.snp.makeConstraints({maker in
            maker.leading.equalTo(labelSuperChapterName.snp.trailing)
            maker.top.equalTo(labelTitle.snp.bottom).offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        })
        
        contentView.addSubview(imgCollect)
        imgCollect.snp.makeConstraints { maker in
            maker.height.equalTo(20)
            maker.width.equalTo(20)
            maker.trailing.equalToSuperview().offset(-10)
            maker.bottom.equalToSuperview().offset(-5)
        }
        
        imgCollect.addTarget(self, action: #selector(self.collect(btn:)), for: .touchUpInside)
    }
}
