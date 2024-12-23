//
//  PalmViewController.swift
//  PalmDaSdk
//
//  Created by 杨充 on 2024/12/9.
//

import UIKit
import Foundation

open class PalmViewController: UIViewController {
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        //初始化方法，用于创建视图控制器的实例。
        print("init sdk 初始化方法，用于创建视图控制器的实例。");
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("init sdk 方法允许开发者指定一个nib文件名（如果有的话），并创建视图控制器");
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print("sdk viewDidLoad 视图控制器的视图加载完成后的初始化工作");
        
        view.backgroundColor = .white
        navigationItem.title = "GPKit"
        
        let label = UILabel(frame: CGRect(x: 30, y: 100, width: 100, height: 20))
        label.text = "我是GPKit里面的控制器"
        label.textColor = .red
        view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 30, y: 140, width: 50, height: 50))
        button.setTitle("返回", for: .normal)
        button.setImage(UIImage(named: "icon_share"), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside);
        view.addSubview(button)
        
        //Bundle.allBundles 是一个数组，包含了应用程序中加载的所有 bundle 对象。
        //Bundle 是一个表示应用程序或框架的资源和代码的容器。
        var bundle = Bundle.allBundles
        print("获取了bundle的路径 \(bundle)")
        
        //获取到自定义bundle的路径
        if let bundlePath1 = Bundle.main.path(forResource: "icon_share", ofType: "png"){
            print("首先获取了主 bundle 的路径1 \(bundlePath1)")
        } else {
            print("没有找到bundle资源文件1")
        }
        if let customBundleURL = Bundle.main.url(forResource: "easysdk", withExtension: "bundle"){
           print("首先获取了主 bundle 的路径2 \(customBundleURL)")
        } else {
            print("Failed to load custom bundle2.")
        }
        if let bundlePath2 = Bundle.main.path(forResource: "easysdk", ofType: "bundle"){
            print("首先获取了主 bundle 的路径3 \(bundlePath2)")
        } else {
            print("没有找到bundle资源文件3")
        }
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 210, width: 30, height: 30));
        //imageView.image = UIImage(named: "icon_share.png")   //设置UIImage的图片名, 以及展示的样式
        imageView.isUserInteractionEnabled = true;
        imageView.contentMode = UIView.ContentMode.scaleAspectFit;
        //获取应用程序的主 bundle
        //首先获取了主 bundle 的路径
        if let bundlePath = Bundle.main.path(forResource: "icon_share", ofType: "png") {
            print("首先获取了主 bundle 的路径 \(bundlePath)")
            //使用 path(forResource:ofType:) 方法获取 bundle 文件的路径。
            if let bundle = Bundle(path: bundlePath) {
                print("首先获取了主 bundle  \(bundle)")
                //使用获取到的 bundle 路径和资源图片的文件名，获取资源图片的完整路径
                if let imagePath = bundle.path(forResource: "icon_share", ofType: "png") {
                    print("首先获取了主 bundle imagePath \(imagePath)")
                    let image = UIImage(contentsOfFile: imagePath)
                    // 使用获取到的 image 进行后续操作
                    imageView.image = image
                }
            }
        } else {
            print("没有找到bundle资源文件")
        }
        self.view.addSubview(imageView);
        
        
        let imageViewLogo = UIImageView(frame: CGRect(x: 30, y: 250, width: 30, height: 30));
        imageViewLogo.contentMode = UIView.ContentMode.scaleAspectFit;
        if let customBundleURL = Bundle.main.url(forResource: "easysdk", withExtension: "bundle"),
           let customBundle = Bundle(url: customBundleURL) {
            // 加载图片
            if let imagePath = customBundle.path(forResource: "icon_share", ofType: "png"),
                let image = UIImage(contentsOfFile: imagePath) {
                imageViewLogo.image = image;
                print("Successfully loaded image: \(image)")
            } else {
                print("Failed to load image.")
            }
        } else {
            print("Failed to load custom bundle.")
        }
        self.view.addSubview(imageViewLogo);
        
        let imageViewLogo2 = UIImageView(frame: CGRect(x: 30, y: 300, width: 30, height: 30));
        imageViewLogo2.contentMode = UIView.ContentMode.scaleAspectFit;
        if let customBundleURL = Bundle.main.url(forResource: "easyres", withExtension: "bundle"),
           let customBundle = Bundle(url: customBundleURL) {
            // 加载图片
            if let imagePath = customBundle.path(forResource: "ic_collect", ofType: "png"),
                let image = UIImage(contentsOfFile: imagePath) {
                imageViewLogo2.image = image;
                print("Successfully loaded image2: \(image)")
            } else {
                print("Failed to load image2.")
            }
        } else {
            print("Failed to load custom bundle2.")
        }
        self.view.addSubview(imageViewLogo2);
    }
    
    @objc private func clickButton() {
        //推出当前控制器
        navigationController?.popViewController(animated: true)
    }
    
    //在处理自定义 Bundle 的资源时，可以遵循以下最佳实践：
    //模块化设计：将相关资源放在同一 Bundle 中，以便于管理和使用。
    //版本控制：使用不同的 Bundle 名称或版本号来区分不同版本的资源。
    //资源命名：为资源文件使用清晰、有意义的命名，以便能够快速找到所需的文件。
}
