//
//  CollectionDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/29.
//

import UIKit


class MyViewCell : UICollectionViewCell {
    static let reuseIden = "MyViewCell";
}

class CollectionDemoController: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource{
    

    private var collectionView : UICollectionView!;
    private var collectionLayoutView : UICollectionViewFlowLayout!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //layout
        collectionLayoutView = UICollectionViewFlowLayout();
        collectionLayoutView.scrollDirection = .vertical;
        collectionLayoutView.minimumLineSpacing = 10;
        
        //collection view
        collectionView = UICollectionView(frame : .zero, collectionViewLayout: collectionLayoutView)
        collectionView.backgroundColor = UIColor.white;
        collectionView.delegate = self;
        collectionView.dataSource = self;

        collectionView.register(MyViewCell.self, forCellWithReuseIdentifier: MyViewCell.reuseIden)
        view.addSubview(collectionView);
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        var frame = view.bounds;
        frame.origin.y = view.safeAreaInsets.top;
        frame.size.height -= frame.origin.y;
        collectionView.frame = frame;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyViewCell.reuseIden, for: indexPath)
        cell.backgroundColor = UIColor.randomColor;
        return cell;
    }
}

//拓展类
extension UIColor {
    class var randomColor : UIColor {
        get{
            let red = CGFloat(arc4random()%256)/255.0;
            let green = CGFloat(arc4random()%256)/255.0;
            let blue = CGFloat(arc4random()%256)/255.0;
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}


extension Int {
    var add: Int {
        return self + 100;
    }
}


