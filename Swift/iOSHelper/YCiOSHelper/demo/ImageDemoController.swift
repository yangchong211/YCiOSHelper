//
//  ImageDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/29.
//

import UIKit
import SnapKit

class ImageDemoController: UIViewController ,UIActionSheetDelegate{
    
    private var imageView = UIImageView();
    private var imageChangeView = UIImageView();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建imageView从本地，文件中，网络获取
        self.createUI();
        self.changeImage();
    }
    
    
    private func createUI() {
        imageView = UIImageView();
        //imageView = UIImageView(image:UIImage(named:"1.png"));  //初始化时可以设置图片
        //imageView = UIImageView(image: UIImage(named:"1.png"), highlightedImage:UIImage(named:"2.png")) //初始化时可以设置普通的图片和高亮的图片
        //imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200);  //设置它的位置
        //由于UIImage不能单独的拿出来展示，它必须依赖于某个一个继承于UIView的一个View，比如UIImageView或者UIButton, 这些都是可以的.
        imageView.image = UIImage(named: "icon_home_add.png")   //设置UIImage的图片名, 以及展示的样式
        imageView.isUserInteractionEnabled = true;
        imageView.contentMode = UIView.ContentMode.scaleAspectFit;  //设置图片显示的样式
        //添加事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped));
        imageView.addGestureRecognizer(tapGesture)
        self.view.addSubview(imageView);
        
        //修改图片
        imageView.image = UIImage(named:"2.png")
        
        //目录中获取图片
        //let path = Bundle.main.path(forResource:"3",ofType:"png")
        //imageView.image = UIImage(contentsOfFile:path!)
        
        //网络下载图片
        //        let url = URL(string: "http://hangge.com/blog/images/logo.png")
        //        let  data  = try! Data (contentsOf:url!)//网上获取数据流
        //        let newImage = UIImage (data:data)
        //        imageView.image = newImage
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.equalTo(self.view.snp_leftMargin).offset(20)
            make.top.equalTo(self.view.snp_topMargin).offset(20)
        }
    }
    
    
    private func changeImage() {
        //imageChangeView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        imageChangeView.backgroundColor = UIColor.blue
        
        //设置动画
        imageChangeView.animationImages = [UIImage(named:"ic_close")!,
                                           UIImage (named:"ic_close")!,
                                           UIImage (named:"ic_close")!,
                                           UIImage (named:"ic_close")!]
        
        //设置每间隔1秒 循环一次
        imageChangeView.animationDuration = 4
        //保持图片比例\默认 UIImageView 会拉伸图片使其占满整个 UIImageView，如果不想让图片变形，可以将 ContentMode 设置为 ToFill充满iamgeview、 AspectFit imageView内原比例。 AspectFill显示原来比例，不足的imageview扩大
        imageChangeView.contentMode = .scaleToFill
        self.view.addSubview(imageChangeView)
        //开始动画
        imageChangeView.startAnimating()
        imageChangeView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(self.imageView.snp_bottomMargin).offset(20)
            make.left.equalTo(self.imageView.snp_left)
        }
    }
    
    @objc func imageTapped() {
        //处理图像被触摸的事件
        print("Image tapped");
        myUIActionSheet();
    }
    
    //学习UIActionSheet弹窗提示
    private func myUIActionSheet() {
        // 1.自定义 UIActionSheet, 并且设置标题, 代理对象, 以及按钮的标题
        var actionSheet = UIActionSheet(title: "UIActionSheet", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "按钮一");
        // 2.设置 UIActionSheet 的样式
        actionSheet.actionSheetStyle = UIActionSheetStyle.default;
        // 3.设置取消按钮的索引
        actionSheet.cancelButtonIndex = 1;
        // 4.设置destructive的索引值
        actionSheet.destructiveButtonIndex = 0
        // 5.添加其他按钮的标题
        actionSheet.addButton(withTitle: "按钮二")
        // 6.设置按钮标题的索引
        actionSheet.buttonTitle(at: 1);
        // 7.显示到 self.view 上
        actionSheet.show(in: self.view)
    }
    
    // 1.该方法是在 UIActionSheet 上的按钮被点击时调用的
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print("被点击了")
    }

    // 2.该方法是在 UIActionSheet 上的点击了取消按钮时调用的
    func actionSheetCancel(_ actionSheet: UIActionSheet){
        print("点击了取消按钮")
    }

    // 3.该方法是在 UIActionSheet 完全即将显示的时候调用的
    func willPresent(_ actionSheet: UIActionSheet) {
        print("UIActionSheet即将显示")
    }

    // 4.该方法是在 UIActionSheet 完全显示的时候调用的
    func didPresent(_ actionSheet: UIActionSheet){
        print("UIActionSheet完全显示")
    }

    // 5.该方法是在 UIActionSheet 完全即将消失的时候调用的
    func actionSheet(_ actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int){
        print("UIActionSheet即将消失")
    }

    // 6.该方法是在 UIActionSheet 完全消失的时候调用的
    func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        print("UIActionSheet完全消失")
    }

}
