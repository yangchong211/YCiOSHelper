//
//  TextDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/28.
//

import UIKit


//学习文本控件
class TextDemoController: UIViewController,UITextFieldDelegate ,UIAlertViewDelegate{
    
    private var text : UITextView = UITextView();
    private var switchUI : UISwitch = UISwitch();
    private var button : UIButton = UIButton();
    private var label: UILabel = UILabel();
    private var textField : UITextField = UITextField();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("学习文本控件");
        textView();
        switchView();
        buttonView();
        labelView();
        textFieldView();
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //添加swith位置
        //CGRect表示一个矩形，用于指定坐标，以及控件宽高
        //横向为X周
        switchUI.frame = CGRect(x: 100, y: view.safeAreaInsets.top + 400, width: 40, height: 40);
    }
    
    //文本控件
    func textView() {
        text = UITextView(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 200, width: 200, height: 100))
        text.text = "这个是一个文本控件";
        //text.backgroundColor = UIColor.red;
        text.font = UIFont.systemFont(ofSize: 16)   //设置文本字体
        text.textColor = UIColor.black
        text.textAlignment = .center
        text.isEditable = false // 设置为true可编辑，false不可编辑
        text.isScrollEnabled = true // 设置为true可滚动，false不可滚动
        text.layer.borderWidth = 1.0
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = 5.0
        self.view.addSubview(text)
    }
    
    func switchView() {
        //添加一个switch
        self.view.addSubview(switchUI);
    }
    
    //按钮控件
    func buttonView() {
        button = UIButton(type: .system) // 创建一个system类型的UIButton
        button.setTitle("Click Me", for: .normal) // 设置按钮的标题
        button.setTitleColor(UIColor.black, for: .normal)
        button.frame = CGRect(x: 100, y: 120, width: 100, height: 50) // 设置按钮的位置和大小
        button.backgroundColor = UIColor.white // 设置按钮的背景颜色为蓝色
        button.setTitleColor(.white, for: .normal) // 设置按钮标题的颜色为白色
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside) // 添加按钮点击事件处理
        self.view.addSubview(button) // 将按钮添加到当前视图中
    }
    
    @objc func buttonClicked() {
        print("Button clicked!")
        //移除按钮点击事件
        //button.removeTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        myAlertView();
    }
    
    func labelView() {
        //学习标签
        label.frame = CGRect(x: 120, y: 320, width: 200, height: 30)
        label.text = "这个是一个普通标签";   //添加UILabel的text文字
        label.textColor = UIColor.black;    //设置UILabel的text文字颜色
        label.backgroundColor = UIColor.brown;  //设置UILabel的背景颜色
        label.numberOfLines = 0;    //设置UILabel的text文字的行数, 如果是0就会自动换行
        label.adjustsFontSizeToFitWidth = true; //设置UILabel的text是否根据UILabel的宽高自适应, true就是自适应, false就不是
        label.font = UIFont.systemFont(ofSize: 20)//设置UILabel的字体大小, 如果adjustsFontSizeToFitWidth为true时, 该属性无效
        label.isHighlighted = true;   //设置UILabel的高亮状态为true, 默认是false
        label.lineBreakMode = NSLineBreakMode.byWordWrapping;   //设置UIlabel的显示样式
        self.view.addSubview(label);
    }
    
    
    private func textFieldView() {
        textField.frame = CGRect(x: 100, y: 600, width: 200, height: 100);
        textField.backgroundColor = UIColor.green;
        textField.keyboardType = UIKeyboardType.asciiCapable;//设置UITextField的键盘样式
        textField.keyboardAppearance = UIKeyboardAppearance.dark    //设置UITextField的键盘外观颜色
        textField.placeholder = "请输入您的名字"   //设置UITextField的提示文字
        textField.returnKeyType = UIReturnKeyType.default;  //设置UITextField的return样式
        textField.delegate = self;  //设置UITextField的代理对象
        textField.borderStyle = UITextField.BorderStyle.roundedRect;//设置UITextField的显示样式
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top;//设置UITextField内容的垂直对齐方式, 默认是center
        textField.clearsOnBeginEditing = true;//再次编辑时对旧内容进行自动清除, 默认是false
        textField.adjustsFontSizeToFitWidth = false;//根据TextField的大小自动缩放字体大小, 默认是false
        self.view.addSubview(textField);
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 取消第一响应者
        textField.resignFirstResponder()
        print("输入文本代理方法调用了");
        // 返回true
        return true
    }
    
    
    private func myAlertView() {
        var alertView = UIAlertView(title: "我是一个alert弹窗", message: "message消息", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认");
        alertView.addButton(withTitle: "添加");//继续添加 UIAlertView 的 ButtonTitle
        alertView.alertViewStyle = UIAlertViewStyle.plainTextInput;//设置 UIAlertView 的样式
        alertView.cancelButtonIndex = 0;//设置 UIAlertView 的取消按钮索引
        alertView.dismiss(withClickedButtonIndex: 0, animated: true);//设置 UIAlerView 手动消失的按钮索引, 以及是否使用动画
        alertView.textField(at: 0);//设置 UIAlerView 的输入文本框的索引路径
        alertView.buttonTitle(at: 0)//设置 UIAlertView 的按钮标题索引
        alertView.show();//显示 UIAlertView
    }
    
    // 1.该方法是在 UIAlertView 上的按钮被点击时调用的
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        print("点击了AlertView")
    }
    
    // 2.该方法是在 UIAlertView 即将显示的时候调用的
    func willPresentAlertView(alertView: UIAlertView) {
        print("AlertView即将显示")
    }
    
    // 3.该方法是在 UIAlertView 完全显示的时候调用的
    func didPresentAlertView(alertView: UIAlertView) {
        print("AlertView已经完全显示")
    }
    
    // 4.该方法是在 UIAlertView 完全消失的时候调用的
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        print("AlertView消失了")
    }
    
    // 5.该方法是在 UIAlertView 即将消失的时候调用的
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        print("AlertView即将消失")
    }
    
    // 6.该方法是在 UIAlertView 将要被取消时调用
    func alertViewCancel(alertView: UIAlertView) {
        print("点击了取消按钮")
    }
    
    // 7.该方法是在 UIAlertView 在任何一个编辑样式编辑时调用
    func alertViewShouldEnableFirstOtherButton(alertView: UIAlertView) -> Bool {
        return true
    }
}
