//
//  HttpDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/3.
//

import UIKit

class HttpDemoController: UIViewController {
    
    private var text1 : UITextView = UITextView();
    private var text2 : UITextView = UITextView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text1 = UITextView(frame: CGRect(x: 20, y: view.safeAreaInsets.top + 120, width: 200, height: 100))
        text1.text = "普通get请求";
        text1.sizeToFit();  //设置内容包裹
        text1.backgroundColor = UIColor.yellow;
        text1.font = UIFont.systemFont(ofSize: 16)   //设置文本字体
        text1.textColor = UIColor.black
        text1.textAlignment = .center
        text1.layer.borderWidth = 1.0
        text1.layer.borderColor = UIColor.gray.cgColor
        text1.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped1))
        text1.addGestureRecognizer(tapGesture1)
        self.view.addSubview(text1)
        
        
        
        text2 = UITextView(frame: CGRect(x: 100, y: view.safeAreaInsets.top + 120, width: 200, height: 100))
        text2.text = "普通post请求";
        text2.sizeToFit();  //设置内容包裹
        text2.backgroundColor = UIColor.yellow;
        text2.font = UIFont.systemFont(ofSize: 16)   //设置文本字体
        text2.textColor = UIColor.black
        text2.textAlignment = .center
        text2.layer.borderWidth = 1.0
        text2.layer.borderColor = UIColor.gray.cgColor
        text2.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped2))
        text2.addGestureRecognizer(tapGesture2)
        self.view.addSubview(text2)
    }
    
    @objc func textViewTapped1() {
        print("UITextView1被点击了")
        netTest1();
    }
    
    
    @objc func textViewTapped2() {
        print("UITextView2被点击了")
        netTest2();
    }
    
    //json解析
    private func jsonTest() {
        
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        // 将传入的 JSON 字符串 jsonString 使用 data(using:) 方法转换为 Data 类型
        let jsonData:Data = jsonString.data(using: .utf8)!
        // 通过 JSONSerialization.jsonObject(with:options:) 方法将 jsonData 进行 JSON 解析，并将解析结果存储在 dict 变量中。这里使用的选项是 .mutableContainers，表示可以修改容器对象
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        // 使用条件语句判断 dict 是否为 nil。如果不为 nil，表示 JSON 解析成功，将 dict 强制转换为 NSDictionary 类型，并返回。
        if dict != nil {
            return dict as! NSDictionary
        }
        //   如果 dict 为 nil，表示 JSON 解析失败，返回一个空的 NSDictionary 对象。
        return NSDictionary()
    }
    
    //普通网络同步请求
    private func netTest1() {
        // 构建URL
        let url:URL = URL(string: "https://www.wanandroid.com/article/list/0/json")!
        // 发送HTTP请求的的session对象
        let session = URLSession.shared
        // 构建请求request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // 发一个get请求
        let task = session.dataTask(with: request as URLRequest) {(
            data, response, error) in
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            let dict = self.getDictionaryFromJSONString(jsonString: dataString!)
            print("网络请求数据：")
            print(dict);
        }
        task.resume()
    }
    
    //网络异步请求
    private func netTest2() {
        // 这里直接使用 jsonString 转成字典，然后转成 Data
        // 将 流 放到 request的 httpBody中， 模拟发送一个http请求
        let jsonString = "{\"username\":\"yangchong\",\"password\":\"yc123456\"}"
        //        let jsonString = "{
        //            "username": "yangchong",
        //            "password": "yc123456"
        //        }"
        let dict = self.getDictionaryFromJSONString(jsonString: jsonString)
        print(dict)
        var  jsonData = NSData()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) as NSData
        } catch {
            print(error.localizedDescription)
        }
        // 构建URL
        let url:URL = URL(string: "https://www.wanandroid.com/user/login")!
        // session
        let session = URLSession.shared
        // request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 设置Content-Length，非必须
        request.setValue("\(jsonData.length)", forHTTPHeaderField: "Content-Length")
        // 设置 Content-Type 为 json 类型
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // POST    请求将 数据 放置到 请求体中
        request.httpBody = jsonData as Data
        // 发送请求
        let task = session.dataTask(with: request as URLRequest) {(
            data, response, error) in
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            // 返回值 utf8 转码
            let dataString =  String(data: data, encoding: String.Encoding.utf8)
            // 将 jsonString 转成字典
            let dict = self.getDictionaryFromJSONString(jsonString: dataString!)
            print(dict)
        }
        task.resume()
    }
    
    //网络同步请求
    private func netTest3() {
        
    }
    
    //网络异步请求
    private func netTest4() {
        
    }
    
}
