//
//  HttpDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/3.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit

class HttpDemoController: UIViewController {
    
    private var text1 : UITextView = UITextView();
    private var text2 : UITextView = UITextView();
    private var text3 : UITextView = UITextView();
    private var text4 : UITextView = UITextView();
    private var text5 : UITextView = UITextView();
    private var text6 : UITextView = UITextView();
    private var text7 : UITextView = UITextView();
    private var text8 : UITextView = UITextView();
    private var text9 : UITextView = UITextView();
    private var textView : UITextView = UITextView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text1 = UITextView()
        text1.text = "普通get请求";
        text1.sizeToFit();  //设置内容包裹
        text1.backgroundColor = UIColor.yellow;
        text1.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text1.textColor = UIColor.black
        text1.textAlignment = .center
        text1.layer.borderWidth = 1.0
        text1.layer.borderColor = UIColor.gray.cgColor
        text1.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped1))
        text1.addGestureRecognizer(tapGesture1)
        self.view.addSubview(text1)
        text1.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.leftMargin.equalTo(self.view).offset(10)
            make.top.equalTo(self.view).offset(100)
        }
        
        
        text2 = UITextView()
        text2.text = "普通post请求";
        text2.sizeToFit();  //设置内容包裹
        text2.backgroundColor = UIColor.yellow;
        text2.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text2.textColor = UIColor.black
        text2.textAlignment = .center
        text2.layer.borderWidth = 1.0
        text2.layer.borderColor = UIColor.gray.cgColor
        text2.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped2))
        text2.addGestureRecognizer(tapGesture2)
        self.view.addSubview(text2)
        text2.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.left.equalTo(self.text1.snp_rightMargin).offset(20)
            make.top.equalTo(self.text1.snp_top)
            //make.top.equalTo(self.text1.snp_topMargin)
        }
        
        text3 = UITextView()
        text3.text = "Alamofire get请求";
        //text3.sizeToFit();  //设置内容包裹
        text3.backgroundColor = UIColor.yellow;
        text3.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text3.textColor = UIColor.black
        text3.textAlignment = .center
        text3.refreshControl?.contentHorizontalAlignment = .center
        text3.layer.borderWidth = 1.0
        text3.layer.borderColor = UIColor.gray.cgColor
        text3.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped3))
        text3.addGestureRecognizer(tapGesture3)
        self.view.addSubview(text3)
        text3.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(self.text1.snp_left)
            make.top.equalTo(self.text1.snp_bottomMargin).offset(20)
        }
        
        
        text4 = UITextView()
        text4.text = "Alamofire post请求";
        //text4.sizeToFit();  //设置内容包裹
        text4.backgroundColor = UIColor.yellow;
        text4.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text4.textColor = UIColor.black
        text4.textAlignment = .center
        text4.refreshControl?.contentHorizontalAlignment = .center
        text4.layer.borderWidth = 1.0
        text4.layer.borderColor = UIColor.gray.cgColor
        text4.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped4))
        text4.addGestureRecognizer(tapGesture4)
        self.view.addSubview(text4)
        text4.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(self.text3.snp_rightMargin).offset(20)
            make.top.equalTo(self.text3.snp_top)
        }
        
        text5 = UITextView()
        text5.text = "Json解析1";
        text5.sizeToFit();  //设置内容包裹
        text5.textContainer.lineBreakMode = .byWordWrapping;
        text5.backgroundColor = UIColor.lightGray;
        text5.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text5.textColor = UIColor.black
        text5.textAlignment = .center
        text5.layer.borderWidth = 1.0
        text5.layer.borderColor = UIColor.gray.cgColor
        text5.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped5))
        text5.addGestureRecognizer(tapGesture5)
        self.view.addSubview(text5)
        text5.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.left.equalTo(self.text3.snp_left)
            make.top.equalTo(self.text3.snp_bottomMargin).offset(20)
        }
        
        
        text6 = UITextView()
        text6.text = "Json解析2";
        text6.sizeToFit();  //设置内容包裹
        text6.backgroundColor = UIColor.green;
        text6.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text6.textColor = UIColor.black
        text6.textAlignment = .center
        text6.layer.borderWidth = 1.0
        text6.layer.borderColor = UIColor.gray.cgColor
        text6.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture6 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped6))
        text6.addGestureRecognizer(tapGesture6)
        self.view.addSubview(text6)
        text6.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.left.equalTo(self.text5.snp_rightMargin).offset(20)
            make.top.equalTo(self.text5.snp_top)
        }
        
        text7 = UITextView()
        text7.text = "线程基础使用";
        text7.sizeToFit();  //设置内容包裹
        text7.backgroundColor = UIColor.green;
        text7.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text7.textColor = UIColor.black
        text7.textAlignment = .center
        text7.layer.borderWidth = 1.0
        text7.layer.borderColor = UIColor.gray.cgColor
        text7.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture7 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped7))
        text7.addGestureRecognizer(tapGesture7)
        self.view.addSubview(text7)
        text7.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.left.equalTo(self.text5.snp_left)
            make.top.equalTo(self.text5.snp_bottomMargin).offset(20)
        }
        
        text8 = UITextView()
        text8.text = "线程属性和方法";
        text8.sizeToFit();  //设置内容包裹
        text8.backgroundColor = UIColor.green;
        text8.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text8.textColor = UIColor.black
        text8.textAlignment = .center
        text8.layer.borderWidth = 1.0
        text8.layer.borderColor = UIColor.gray.cgColor
        text8.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture8 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped8))
        text8.addGestureRecognizer(tapGesture8)
        self.view.addSubview(text8)
        text8.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(30)
            make.left.equalTo(self.text7.snp_rightMargin).offset(20)
            make.top.equalTo(self.text7.snp_top)
        }
        
        text9 = UITextView()
        text9.text = "多线程通信切换";
        text9.sizeToFit();  //设置内容包裹
        text9.backgroundColor = UIColor.green;
        text9.font = UIFont.systemFont(ofSize: 12)   //设置文本字体
        text9.textColor = UIColor.black
        text9.textAlignment = .center
        text9.layer.borderWidth = 1.0
        text9.layer.borderColor = UIColor.gray.cgColor
        text9.layer.cornerRadius = 5.0
        // 添加点击手势识别器
        let tapGesture9 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped9))
        text9.addGestureRecognizer(tapGesture9)
        self.view.addSubview(text9)
        text9.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.height.equalTo(30)
            make.left.equalTo(self.text8.snp_rightMargin).offset(20)
            make.top.equalTo(self.text8.snp_top)
        }
        
        textView = UITextView(frame: CGRect(x: 20, y: view.safeAreaInsets.top + 260, width: self.view.frame.width, height: 100))
        textView.contentInset = UIEdgeInsets.zero //内容填充满UITextView的边界，可以将其contentInset属性设置为零
        textView.isScrollEnabled = true;//UITextView默认情况下是可以滚动的，只要内容超过了视图的可见区域
        self.view.addSubview(textView)
    }
    
    @objc func textViewTapped1() {
        print("UITextView1被点击了")
        testNSDictionary();
        netTest1();
    }
    
    
    @objc func textViewTapped2() {
        print("UITextView2被点击了")
        netTest2();
    }
    
    @objc func textViewTapped3() {
        print("UITextView3被点击了")
        netTest3();
    }
    
    
    @objc func textViewTapped4() {
        print("UITextView4被点击了")
        netTest4();
    }
    
    
    @objc func textViewTapped5() {
        print("UITextView5被点击了")
        jsonTest1();
    }
    
    @objc func textViewTapped6() {
        print("UITextView6被点击了")
        jsonTest2();
    }
    
    @objc func textViewTapped7() {
        print("UITextView7被点击了")
        thread1();
    }
    
    @objc func textViewTapped8() {
        print("UITextView8被点击了")
        thread2();
    }
    
    @objc func textViewTapped9() {
        print("UITextView9被点击了")
        thread3();
    }
    
    
    //字典的使用
    func testNSDictionary() {
        //创建NSDictionary对象：
        let dictionary: NSDictionary = ["key1": "value1", "key2": "value2"]
        //获取字典数据
        if let value = dictionary["key1"] as? String {
            print(value) // 输出: value1
        }
        //修改值
        //dictionary.setValue("new value", forKey: "key1")
        //遍历字典
        for (key, value) in dictionary {
            print("\(key): \(value)")
        }
        //判断字典是否包含某个键
        if dictionary.contains(where: { $0.key as? String == "key1" }) {
            print("字典包含key1")
        }
        //获取字典的大小
        let count = dictionary.count
    }
    
    //将json字符串解析成字典
    //NSDictionary是一种用于存储键值对的不可变字典类。
    //它是Foundation框架中的一部分，用于处理和操作集合数据。
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
    
    //将字典转化为字符串
    func nSDictionaryToString(dictionary : NSDictionary) {
        // 将NSDictionary转换为String
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            textView.text = jsonString;
        } else {
            print("转换失败")
        }
    }
    
    //普通get网络同步请求
    private func netTest1() {
        self.textView.text = "普通get网络同步请求，进行中"
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
            print("网络请求数据：\(dict)")
            //会报错：Main Thread Checker: UI API called on a background thread: -[UITextView setText:]
            //self.textView.text = dataString;
            //textView.text = dataString;
            DispatchQueue.main.async {
                self.textView.text = dataString;
            }
        }
        //启动任务
        task.resume()
    }
    
    //普通post网络同步请求
    private func netTest2() {
        self.textView.text = "普通post网络同步请求，进行中"
        // 这里直接使用 jsonString 转成字典，然后转成 Data
        // 将 流 放到 request的 httpBody中， 模拟发送一个http请求
        let jsonString = "{\"username\":\"yangchong\",\"password\":\"yc123456\"}"
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
        // 必须指定是post请求方式
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
            //第一种
            //            OperationQueue.main.addOperation {
            //                self.textView.text = dataString;
            //            }
            let operationQueue = OperationQueue.main;
            // 最多同时执行2个操作
            operationQueue.maxConcurrentOperationCount = 2;
            operationQueue.addOperation {
                self.textView.text = dataString;
            }
            //            let operationQueue = OperationQueue()
            //            operationQueue.addOperation {
            //                self.textView.text = dataString;
            //            }
        }
        task.resume()
    }
    
    //Alamofire库get请求
    private func netTest3() {
        DispatchQueue.global(qos: .background).async {
            // 在后台线程上执行任务
        }
        let operationQueue = OperationQueue.main;
        let operation1 = BlockOperation {
            print("操作1的代码")
        }
        
        let operation2 = BlockOperation {
            print("操作2的代码")
        }
        operation2.addDependency(operation1) // 操作2依赖于操作1
        operationQueue.addOperations([operation1,operation2], waitUntilFinished: false)
        
        self.textView.text = "Alamofire库get请求，进行中"
        //使用网络库Alamofire做get请求
        let url: URL = URL(string: "https://www.wanandroid.com/article/list/0/json")!
        //Alamofire支持4种返回响应处理方式：Data、String、 JSON、自定义类型。
        //request请求接口方法，源码中参数含义
        //参数一： convertible（可变化）一个可变化的参数。其实就是请求的url地址。
        //参数二：method 请求方式。就是我们常说的GET，POST。
        //参数三：parameters 请求参数。业务数据的参数部分，如登录模块的userName，Password等之类的业务数据。
        //参数四：encoding 编码方式。
        //Data示例
        AF.request(url).responseData { response in
            switch response.result {
            case let .success(data):
                print("data1:\(String(describing: data))")
            case let .failure(error):
                print(error)
            }
        }
        
        //String示例
        AF.request(url).responseString { response in
            switch response.result {
            case let .success(data):
                print("data2:\(String(describing: data))")
                DispatchQueue.main.async {
                    self.textView.text = "data2:\(String(describing: data))"
                }
            case let .failure(error):
                print(error)
            }
        }
        
        //JSON示例
        AF.request(url).responseJSON { response in
            switch response.result {
            case let .success(data):
                print("data3:\(String(describing: data))")
            case let .failure(error):
                print(error)
            }
        }
        
        //自定义格式示例
        //        struct PersonResponse: Decodable { var name: String,  var nickName : String, var age : Int }
        //        AF.request(url).responseDecodable(of: PersonResponse.self) { response in
        //            switch response.result {
        //            case let .success(data):
        //                print("data:\(String(describing: data))")
        //            case let .failure(error):
        //                print(error)
        //            }
        //        }
    }
    
    //Alamofire库post请求
    private func netTest4() {
        self.textView.text = "Alamofire库post请求，进行中"
        let url:URL = URL(string: "https://www.wanandroid.com/user/login")!
        let params: [String: Any] = [
            "username": "yangchong",
            "password": "yc123456"
        ]
        AF.request(url,method: .post,parameters: params).responseString { response in
            switch response.result {
            case let .success(data):
                print("data2:\(String(describing: data))")
                DispatchQueue.main.async {
                    self.textView.text = "data2:\(String(describing: data))"
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    //json解析
    private func jsonTest1() {
        let jsonString = """
        {
          "name": "John Doe",
          "age": 30,
          "email": "johndoe@example.com",
          "address": {
            "street": "123 Main St",
            "city": "New York",
            "state": "NY"
          },
          "hobbies": ["reading", "running", "cooking"]
        }
        """
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let json = try JSON.init(data: jsonData)
                
                let name = json["name"].stringValue
                let age = json["age"].intValue
                let email = json["email"].stringValue
                
                let street = json["address"]["street"].stringValue
                let city = json["address"]["city"].stringValue
                let state = json["address"]["state"].stringValue
                
                let hobbies = json["hobbies"].arrayValue.map { $0.stringValue }
                
                print("Name: \(name)")
                print("Age: \(age)")
                print("Email: \(email)")
                print("Street: \(street)")
                print("City: \(city)")
                print("State: \(state)")
                print("Hobbies: \(hobbies)")
                
                DispatchQueue.main.async {
                    self.textView.text = "解析json数据成功"
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    private func jsonTest2() {
        let jsonString = """
        {
          "name": "打工充",
          "age": 30,
          "email": "yangchong211@163.com"
        }
        """
        
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let json = try JSON(data: jsonData)
                let person = Person(json: json)
                print("Name: \(person.name)")
                print("Age: \(person.age)")
                print("Email: \(person.email)")
                
                DispatchQueue.main.async {
                    self.textView.text = person.description
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
    private func thread1() {
        let thread1 = Thread(target: self, selector: #selector(threadMethod1), object: nil)
        let thread2 = Thread {
            print("thread2 \(Thread.current)")
        }
        thread1.start()
        thread2.start()
        
        //通过类方法开辟的两个子线程，不返回Thread对象，创建后即就绪状态，无需start()方法。
        Thread.detachNewThreadSelector(#selector(threadMethod3), toTarget: self, with: nil)
        Thread.detachNewThread {
            print("thread4 \(Thread.current)")
        }
    }
    
    @objc func threadMethod1() {
        print("thread1 \(Thread.current)")
    }
    @objc func threadMethod3() {
        print("thread3 \(Thread.current)")
    }
    
    private var myThread: Thread?
    
    private func thread2() {
        // 创建子线程
        myThread = Thread(target: self, selector: #selector(myThreadMethod), object: nil)
        // 设置子线程名称
        myThread?.name = "MyThread"
        // 设置子线程优先级
        myThread?.threadPriority = 1.0
        // 开启子线程
        myThread?.start()
        // 主线程阻塞3秒
        Thread.sleep(forTimeInterval: 3)
        // 打印子线程运行状态
        if let thread = myThread {
            print("3 seconds later, myThread is executing :  \(thread.isExecuting)")
            print("3 seconds later, myThread is finished :  \(thread.isFinished)")
        }
    }
    
    // 子线程方法
    @objc func myThreadMethod() {
        // 打印主线程
        print("Main thread is :  \(Thread.main)")
        // 打印当前线程
        print("Current thread is :  \(Thread.current)")
        // 判断当前线程是否是主线程
        print("Current thread is main thread :  \(Thread.isMainThread)")
        
        if let thread = myThread {
            // 打印子线程名称
            print("myThread name is :  \(String(describing: thread.name))")
            // 打印子线程优先级
            print("myThread priority is :  \(thread.threadPriority)")
            // 打印子线程是否是主线程
            print("myThread is main thread :  \(thread.isMainThread)")
            // 子线程是否正在执行
            print("myThread is executing :  \(thread.isExecuting)")
            // 子线程是否标记取消
            print("myThread is cancelled :  \(thread.isCancelled)")
            // 子线程是否已经结束。
            print("myThread is finished :  \(thread.isFinished)")
        }
        /*
         // 在子线程中添加一个定时器
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
         print("Timer is running")
         }
         // 默认子线程的runloop是不开启的，如果不开启，timer无法执行，所以这里需要手动开启。
         RunLoop.current.run()
         */
    }
    
    private func thread3() {
        
    }
}

struct Person {
    let name: String
    let age: Int
    let email: String
    
    init(json: JSON) {
        name = json["name"].stringValue
        age = json["age"].intValue
        email = json["email"].stringValue
    }
}

//可以使用Mirror来快速生成结构体的toString()方法。
//Mirror是一个用于反射类型信息的Swift标准库类型。以下是一个示例：
//过扩展Person结构体并遵循CustomStringConvertible协议来添加自定义的description属性。
extension Person: CustomStringConvertible {
    var description: String {
        let mirror = Mirror(reflecting: self)
        var description = "\(mirror.subjectType) - "
        for (label, value) in mirror.children {
            if let label = label {
                description += "\(label): \(value), "
            }
        }
        // 去除最后一个逗号和空格
        if description.hasSuffix(", ") {
            description = String(description.dropLast(2))
        }
        return description
    }
}
