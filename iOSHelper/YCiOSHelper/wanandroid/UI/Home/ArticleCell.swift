//
//  ArticleCell.swift
//  FunIOS
//
//  Created by 杨充 on 2021/7/22.
//

import UIKit
import SnapKitExtend

//NSObjectProtocol 是一个协议（protocol），它定义了 Objective-C 中的 NSObject 类的基本行为和功能。
//在 Swift 中，NSObjectProtocol 协议也可以被遵循（conform）。
public protocol CollectDelegate : NSObjectProtocol {
    
    //收藏 文章
    func collectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) -> Void
    
    //取消收藏 文章
    func uncollectAirticle(cid id: Int, tabCell tabviewCell: UITableViewCell) -> Void
}

class ArticleCell: BaseTableViewCell {
    
    //作者
    private lazy var  labelAuthor = UILabel().then({ (attr) in
        attr.text = "author"
        attr.font = UIFont.systemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    //时间
    private lazy var  labelTime = UILabel().then({ (attr) in
        attr.text = "Time"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 12)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    //标签title
    private lazy var labelTitle: UILabel = UILabel().then {(attr) in
        attr.text = "Titile"
        attr.textColor = .black
        attr.font = UIFont.systemFont(ofSize: 14)
        attr.numberOfLines = 2 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    }
    
    //标签name
    private lazy var labelChapterName = UILabel().then({(attr) in
        attr.text = "ChapterName"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 10)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    //
    private lazy var  labelSuperChapterName = UILabel().then({(attr) in
        attr.text = "SuperChapterName"
        attr.textColor = .gray
        attr.font = UIFont.systemFont(ofSize: 10)
        attr.numberOfLines = 0 //相当于不限制行数
        attr.lineBreakMode = .byWordWrapping
        attr.sizeToFit()
        attr.backgroundColor = UIColor.white
    })
    
    //model数据
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
    
    //配置UI布局
    override func configUI() {
        contentView.addSubview(labelAuthor)
        labelAuthor.snp.makeConstraints {maker in
            //maker.leftMargin.equalTo(self.contentView).offset(10) //这个不行
            //maker.left.equalTo(self.contentView).offset(10) //1，可以
            //在 maker.leading.equalToSuperview().offset(10) 中，使用 maker.leading 来设置视图的 leading 约束。
            //equalToSuperview() 表示将 leading 约束与父视图的 leading 边缘对齐，
            //而 offset(10) 表示在 leading 约束上增加一个偏移量为 10。
            maker.leading.equalToSuperview().offset(10)   //2，也可以
            maker.top.equalToSuperview().offset(10)
        }

        contentView.addSubview(labelTime)
        labelTime.snp.makeConstraints({maker in
            maker.right.equalTo(self.contentView).offset(-10)   //1，可以
            //maker.trailing.equalToSuperview().offset(-10)     //2，也可以
            //使用 maker.top 来设置视图的顶部约束。equalToSuperview() 表示将顶部约束与父视图的顶部边缘对齐，而 offset(10) 表示在顶部约束上增加一个偏移量为 10。
            maker.top.equalToSuperview().offset(10)
            //使用 maker.topMargin 来设置视图的顶部边距约束。equalToSuperview() 表示将顶部边距约束与父视图的顶部边缘对齐，而 offset(10) 表示在顶部边距约束上增加一个偏移量为 10。
            //maker.topMargin.equalToSuperview().offset(10)
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
        
        //添加点击事件
        //使用 addTarget 方法可以为控件（如 UIButton、UISwitch、UITextField 等）添加一个目标-动作（target-action）的事件处理。
        //addTarget 方法是 UIControl 类的方法，用于为控件添加一个或多个事件处理方法。
        //self 表示当前视图控制器（或其他遵循了相应协议的对象），collect 是一个被调用的方法，.touchUpInside 是事件类型，表示按钮在触摸结束时被点击。
        imgCollect.addTarget(self, action: #selector(self.collect(btn:)), for: .touchUpInside)
    }
}
