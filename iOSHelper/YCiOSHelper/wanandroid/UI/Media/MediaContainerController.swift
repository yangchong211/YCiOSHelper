//
//  HomeContainerController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/4.
//

import UIKit
import SnapKit

//定义一个协议
protocol MediaContainerControllerDelegate : NSObjectProtocol {
    
    func homeContainerController(controller: MediaContainerController , viewControllerAtindexPath: IndexPath) -> UIViewController
    
    func numberOfViewControllers(in containerViewContrller: MediaContainerController) -> Int
    
    func homeContainerController(controller: MediaContainerController , didScroll scrollView: UIScrollView);
}

//容器控制器
class MediaContainerController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //weak关键字避免循环引用
    public weak var delegate: MediaContainerControllerDelegate?
    //声明view
    private var collectionView : UICollectionView!
    //声明layout
    private var collectionViewLayout: UICollectionViewFlowLayout!
    //?这意味着 optionalValue 可以存储一个整数值，或者存储 nil，表示值的不存在。
    private var optionalValue: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //需要使用 ? 来访问其中的值。这是因为可选类型可能为 nil
        var code = optionalValue?.hashValue
        //collection view layout
        //collectionVIewLayout = UICollectionViewLayout();
        collectionViewLayout = UICollectionViewFlowLayout();
        //滚动方法设置成水平方向
        collectionViewLayout.scrollDirection = .horizontal;
        collectionViewLayout.minimumLineSpacing = 0;
        //collectionViewLayout.delegate = self;
        
        //collection view
        collectionView = UICollectionView(frame: CGRect.zero,collectionViewLayout: collectionViewLayout);
        collectionView.contentInsetAdjustmentBehavior = .never;
        //设置代理和数据源
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //注册cell
        collectionView.register(MediaContainerCollectionViewCell.self, forCellWithReuseIdentifier: MediaContainerCollectionViewCell.reuseldentifier)
        //设置可以分页
        collectionView.isPagingEnabled = true;
        collectionView.showsHorizontalScrollIndicator = false;
        self.view.addSubview(collectionView);
        collectionView.snp.makeConstraints { make in
            //让它和父视图边距为0
            make.edges.equalTo(0);
        }
    }
    
    //通过这个方法，设置自己去管理生命周期
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false;
    }
    
    //设置滚动的方法
    public func setPageIndex(index: Int , animated: Bool) {
        print("按钮被点击了，开始滚动 \(index)")
        guard index < collectionView.numberOfItems(inSection:0) else {
            return;
        }
        let x = CGFloat(index) * collectionView.frame.width;
        print("按钮被点击了，已经滚动 \(x)")
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: animated)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll被调用了")
        //controller: self 传递的是当前控制器
        delegate?.homeContainerController(controller: self, didScroll: scrollView)
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout , sizeForItemAt indexPath : IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("将要显示HomeContainerCollectionViewCell");
        //将要显示cell
        guard let cell = cell as? MediaContainerCollectionViewCell else {
            return
        }
        cell.viewContrller?.beginAppearanceTransition(true, animated: false)
        cell.viewContrller?.endAppearanceTransition();
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //将要销毁cell
        print("将要销毁HomeContainerCollectionViewCell");
        guard let cell = cell as? MediaContainerCollectionViewCell else {
            return
        }
        cell.viewContrller?.beginAppearanceTransition(false, animated: false)
        cell.viewContrller?.endAppearanceTransition();
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfViewControllers(in: self) ?? 0
    }

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //初始化cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaContainerCollectionViewCell.reuseldentifier, for: indexPath) as! MediaContainerCollectionViewCell
        if let viewContrller = delegate?.homeContainerController(controller: self, viewControllerAtindexPath: indexPath) {
            //设置新的vc
            cell.config(with: viewContrller)
        }
        cell.backgroundColor = UIColor.randomYcColor
        return cell;
    }
}

class MediaContainerCollectionViewCell: UICollectionViewCell {
    
    //添加一个常量
    static let reuseldentifier = "HomeContainerCollectionViewCell";
    
    //管理一个控制器
    private(set) var viewContrller: UIViewController?
    
    public func config(with viewContrller : UIViewController) {
        //删除上一个
        self.viewContrller?.view.removeFromSuperview();
        //添加新的控制器
        self.viewContrller = viewContrller;
        if let view = self.viewContrller?.view {
            self.contentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalTo(0);
            }
        }
    }
}


