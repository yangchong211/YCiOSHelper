//
//  HomeTabView.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/9.
//

import Foundation
import UIKit

protocol HomeTabViewDelegate : NSObjectProtocol {
    func didselect(item: HomeTabView.Item,in tabView: HomeTabView);
}

//自定义tab布局view
class HomeTabView : UIView {
    
    struct Item {
        var index: Int
        var title: String
    }
    
    private var items: [Item] = []
    private var buttons: [UIButton] = [UIButton]()
    private var selectedIndex = 0;
    public weak var delegate:HomeTabViewDelegate?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView();
        stackView.alignment = .center;
        stackView.distribution = .fillEqually;
        return stackView;
    }()
    
    private lazy var bottomLine : UIView = {
        let line = UIView();
        line.backgroundColor = .red
        return line;
    }()
    
    init(items: [Item], delegate: HomeTabViewDelegate? = nil) {
        self.items = items
        self.delegate = delegate
        super.init(frame: .zero)
        self.buttons = self.items.map({ Item in
            return self.createButton(item: Item)
        })
        self.buttons.forEach { button in
            self.stackView.addArrangedSubview(button)
        }
        addSubview(stackView)
        addSubview(bottomLine)
        backgroundColor = .cyan
        //初始化
        updateSelectedIndex(with: 0)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createButton(item: Item) -> UIButton {
        let button = UIButton(type: .custom);
        button.setTitle(item.title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.red, for: .selected)
        button.addTarget(self, action: #selector(didTap(button:)), for: .touchUpInside);
        return button;
    }
    
    @objc private func didTap(button: UIButton) {
        print("按钮被点击了")
        guard let index = buttons.firstIndex(of: button) ,index < items.count else {
            return;
        }
        print("调用父布局中方法")
        //通过协议，代理调用父布局中方法
        delegate?.didselect(item: items[index], in: self)
    }
    
    public func updateSelectedIndex(with progress : CGFloat) {
        let buttonWidth = bounds.width / CGFloat(items.count);
        //对线时时更新
        var frame: CGRect = .zero
        frame.size = CGSize(width: 20, height: 4)
        frame.origin.y = bounds.height - frame.size.height;
        frame.origin.x = (buttonWidth - frame.width) / 2 + buttonWidth * progress;
        bottomLine.frame = frame;
        //取整
        selectedIndex = Int(round(progress))
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.isSelected = (i == selectedIndex)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds;
        updateSelectedIndex(with: CGFloat(selectedIndex))
    }
    
}



