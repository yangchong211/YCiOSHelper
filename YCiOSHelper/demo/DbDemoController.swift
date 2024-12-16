//
//  DbDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/3.
//

import UIKit
import SnapKit
import CoreData

class DbDemoController: UIViewController {
    
    
    private lazy var text1 : UITextView = {
        let textView = UITextView();
        textView.text = "1.存储简单的数据类型"
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.brown
        textView.textAlignment = .center
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tvClick1))
        textView.addGestureRecognizer(gesture)
        return textView
    }()
    
    private lazy var text2 : UITextView = {
        let textView = UITextView();
        textView.text = "2.存储属性列表plist"
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.brown
        textView.textAlignment = .center
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tvClick2))
        textView.addGestureRecognizer(gesture)
        return textView
    }()
    
    private lazy var text3 : UITextView = {
        let textView = UITextView();
        textView.text = "3.使用CoreData存储复杂持久数据"
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.brown
        textView.textAlignment = .center
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tvClick3))
        textView.addGestureRecognizer(gesture)
        return textView
    }()
    
    private lazy var text4 : UITextView = {
        let textView = UITextView();
        textView.text = "4.使用文件系统存储二进制或文本数据"
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.brown
        textView.textAlignment = .center
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tvClick4))
        textView.addGestureRecognizer(gesture)
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(text1)
        text1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(40)
            make.top.equalTo(self.view).offset(120)
        }
        
        self.view.addSubview(text2)
        text2.snp.makeConstraints { make in
            make.width.height.equalTo(text1)
            make.left.equalTo(text1)
            make.top.equalTo(text1.snp_bottomMargin).offset(10)
        }
        
        self.view.addSubview(text3)
        text3.snp.makeConstraints { make in
            make.width.height.equalTo(text2)
            make.left.equalTo(text2)
            make.top.equalTo(text2.snp_bottomMargin).offset(10)
        }
        
        self.view.addSubview(text4)
        text4.snp.makeConstraints { make in
            make.width.height.equalTo(text3)
            make.left.equalTo(text3)
            make.top.equalTo(text3.snp_bottomMargin).offset(10)
        }
        
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "username")
        let age = defaults.string(forKey: "age")
        let cardId = defaults.string(forKey: "cardId")
        print("存储简单的数据类型1 \(username) \n \(age) \n \(cardId)");
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = path.appendingPathComponent("data.plist")
        let readData = NSDictionary(contentsOfFile: filePath.path)
        print("存储属性列表plist 1 \(readData)");
        
    }
    
    @objc func tvClick1() {
        print("1.存储简单的数据类型");
        let defaults = UserDefaults.standard
        defaults.set("John Doe", forKey: "username")
        defaults.set(30, forKey: "age")
        defaults.set(421125199303111234, forKey: "cardId")
        let username = defaults.string(forKey: "username")
        let age = defaults.string(forKey: "age")
        let cardId = defaults.string(forKey: "cardId")
        print("存储简单的数据类型2 \(username) \n \(age) \n \(cardId)");
    }
    
    @objc func tvClick2() {
        
    }
    
    @objc func tvClick3() {
        print("3.使用CoreData存储复杂持久数据");
    }
    
    @objc func tvClick4() {
        print("4.使用文件系统存储二进制或文本数据");
        
        // 获取应用的文档目录路径
        let fileManager = FileManager.default
        if let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Documents Directory: \(path)")
            
            // 创建文件名
            let fileName = "example.txt"
            let filePath = path.appendingPathComponent(fileName)
            
            // 要写入的数据
            let dataToWrite = "Hello, Swift file storage!"
            do {
                // 将数据写入文件
                try dataToWrite.write(to: filePath, atomically: true, encoding: .utf8)
                print("数据成功写入到文件：\(filePath)")
            } catch {
                print("写入文件时发生错误：\(error)")
            }
            
            do {
                // 从文件中读取数据
                let readData = try String(contentsOf: filePath, encoding: .utf8)
                print("读取的数据是：\(readData)")
            } catch {
                print("读取文件时发生错误：\(error)")
            }
        }
        
       
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = path.appendingPathComponent("data.plist")
        let data = ["username": "John Doe", "email": "john@example.com"] as NSDictionary
        //写数据
        data.write(toFile: filePath.path, atomically: true)
        //读数据
        let readData = NSDictionary(contentsOfFile: filePath.path)
    }
    
}
