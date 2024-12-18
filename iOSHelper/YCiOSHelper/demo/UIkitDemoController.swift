//
//  UIkitDemoController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/11/29.
//

import UIKit
import SnapKit
//使用snapkit布局哭

class UIkitDemoController: UIViewController {
    
    private var text1 : UITextView = UITextView();
    private var text2 : UITextView = UITextView();
    private var text3 : UITextView = UITextView();
    private var text4 : UITextView = UITextView();
    private var text5 : UITextView = UITextView();
    private var text6 : UITextView = UITextView();
    private var text7 : UITextView = UITextView();
    private var text8 : UITextView = UITextView();
    private var text9 : UITextView = UITextView();
    private var text10 : UITextView = UITextView();
    private var text11 : UITextView = UITextView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(text1)
        text1.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(150)
            make.centerX.equalTo(self.view)
        }
        

        text1.text = "1.设置宽高属性"
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped1))
        text1.layer.borderWidth = 1.0
        text1.layer.borderColor = UIColor.gray.cgColor
        text1.layer.cornerRadius = 5.0
        text1.textAlignment = .center
        text1.addGestureRecognizer(tapGesture1)
        
        self.view.addSubview(text2)
        text2.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text1.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text2.text = "2.相对约束设置1"
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped2))
        text2.layer.borderWidth = 1.0
        text2.layer.borderColor = UIColor.gray.cgColor
        text2.layer.cornerRadius = 5.0
        text2.textAlignment = .center
        text2.addGestureRecognizer(tapGesture2)
        
        self.view.addSubview(text3)
        text3.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text2.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text3.text = "2.相对约束设置2"
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped3))
        text3.layer.borderWidth = 1.0
        text3.layer.borderColor = UIColor.gray.cgColor
        text3.layer.cornerRadius = 5.0
        text3.textAlignment = .center
        text3.addGestureRecognizer(tapGesture3)
        
        self.view.addSubview(text4)
        text4.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text3.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text4.text = "3.1设置约束边界最大值"
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped4))
        text4.layer.borderWidth = 1.0
        text4.layer.borderColor = UIColor.gray.cgColor
        text4.layer.cornerRadius = 5.0
        text4.textAlignment = .center
        text4.addGestureRecognizer(tapGesture4)
        
        self.view.addSubview(text5)
        text5.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text4.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text5.text = "3.2设置约束边界最小值"
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped5))
        text5.layer.borderWidth = 1.0
        text5.layer.borderColor = UIColor.gray.cgColor
        text5.layer.cornerRadius = 5.0
        text5.textAlignment = .center
        text5.addGestureRecognizer(tapGesture5)
        
        self.view.addSubview(text10)
        text10.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text5.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text10.text = "登陆UI案例"
        let tapGesture10 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped10))
        text10.layer.borderWidth = 1.0
        text10.layer.borderColor = UIColor.gray.cgColor
        text10.layer.cornerRadius = 5.0
        text10.textAlignment = .center
        text10.addGestureRecognizer(tapGesture10)
        
        self.view.addSubview(text11)
        text11.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(text10.snp_bottomMargin).offset(20)
            make.centerX.equalTo(self.view)
        }
        text11.text = "键盘综合案例"
        let tapGesture11 = UITapGestureRecognizer(target: self, action: #selector(textViewTapped11))
        text11.layer.borderWidth = 1.0
        text11.layer.borderColor = UIColor.gray.cgColor
        text11.layer.cornerRadius = 5.0
        text11.textAlignment = .center
        text11.addGestureRecognizer(tapGesture11)
    }
    
    @objc func textViewTapped1() {
        let normalContoller = NormalContoller1()
        navigationController?.pushViewController(normalContoller, animated: true)
    }
    
    @objc func textViewTapped2() {
        let normalContoller = NormalContoller2()
        navigationController?.pushViewController(normalContoller, animated: true)
    }
    
    @objc func textViewTapped3() {
        let normalContoller = NormalContoller3()
        navigationController?.pushViewController(normalContoller, animated: true)
    }
    
    @objc func textViewTapped4() {
        let normalContoller = NormalContoller4()
        navigationController?.pushViewController(normalContoller, animated: true)
    }
    
    @objc func textViewTapped5() {
        let normalContoller = NormalContoller5()
        navigationController?.pushViewController(normalContoller, animated: true)
    }
    
    
    @objc func textViewTapped10() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc func textViewTapped11() {
        let keyboradController = keyboradController()
        navigationController?.pushViewController(keyboradController, animated: true)
    }
}


class NormalContoller1: UIViewController {
    
    private var text : UITextView = UITextView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置宽高属性"
        self.view.backgroundColor = UIColor.white;
        
        self.view.addSubview(text)
        text.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalTo(self.view).offset(200)
            make.left.equalToSuperview().offset(30)
        }
        text.text = "设置宽高属性"
        text.layer.borderWidth = 1.0
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = 5.0
        text.textAlignment = .center
    }
    
    
}


class NormalContoller2: UIViewController {
    
    //外部方块
    lazy  var  boxOutter =  UIView ()
    //内部方块
    lazy  var  boxInner =  UIView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "相对约束设置1"
        self.view.backgroundColor = UIColor.white;
        
        boxOutter.backgroundColor =  UIColor.orange
        self.view.addSubview(boxOutter)
        boxInner.backgroundColor =  UIColor.green
        //将boxInner添加到boxOutter容器中
        boxOutter.addSubview(boxInner)
        
        //设置boxOutter控件宽，高分别是200。然后位置是在根容器的中间
        boxOutter.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(self.view)
        }
        //设置boxInner控件宽，高分别是100。然后位置在父容器的右下角位置
        boxInner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
}

class NormalContoller3: UIViewController {
    
    //方块1
    lazy  var  box1 =  UIView ()
    //方块2
    lazy  var  box2 =  UIView ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "相对约束设置2"
        self.view.backgroundColor = UIColor.white;
        
        box1.backgroundColor =  UIColor.orange
        self.view.addSubview(box1)
        box2.backgroundColor =  UIColor.green
        self.view.addSubview(box2)
        
        box1.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(150)
        }
        
        box2.snp.makeConstraints { make in
            //设置宽和高，跟控件box1一样
            make.width.height.equalTo(box1)
            //make.edges.equalTo(box1)
            //设置该控件左边和box1对齐
            make.left.equalTo(box1)
            //设置该控件顶部跟box1控件底部对齐，并且设置间距为10
            make.top.equalTo(box1.snp_bottomMargin).offset(10)
        }
    }
}

class NormalContoller4: UIViewController {
    
    //方块1
    lazy  var  box1 =  UIView ()
    //方块2
    lazy  var  box2 =  UIView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置约束边界最大值"
        self.view.backgroundColor = UIColor.white;
    
        box1.backgroundColor =  UIColor.orange
        self.view.addSubview(box1)
        box2.backgroundColor =  UIColor.green
        self.view.addSubview(box2)
        
        box1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(100)
        }
        box2.snp.makeConstraints { (make) in
            make.top.equalTo(box1.snp.bottom).offset(20)
            make.width.height.equalTo(100)
            //lessThanOrEqualTo: <= 约束边界的最大值
            make.centerX.lessThanOrEqualTo(box1.snp.left)
        }
    }
}

class NormalContoller5: UIViewController {
    
    //方块1
    lazy  var  box1 =  UIView ()
    //方块2
    lazy  var  box2 =  UIView ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置约束边界最小值"
        self.view.backgroundColor = UIColor.white;
        
        box1.backgroundColor =  UIColor.orange
        self.view.addSubview(box1)
        box2.backgroundColor =  UIColor.green
        self.view.addSubview(box2)
        
        box1.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(100)
        }
        box2.snp.makeConstraints { (make) in
            make.top.equalTo(box1.snp.bottom).offset(20)
            make.width.height.equalTo(100)
            make.left.greaterThanOrEqualTo(box1.snp.left)
        }
    }
}

class NormalContoller6: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置宽高属性"
        self.view.backgroundColor = UIColor.white;
    }
    
    
}

class NormalContoller7: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置宽高属性"
        self.view.backgroundColor = UIColor.white;
    }
    
    
}

class NormalContoller8: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置宽高属性"
        self.view.backgroundColor = UIColor.white;
    }
    
    
}

class NormalContoller9: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置宽高属性"
        self.view.backgroundColor = UIColor.white;
    }
    
    
}

//登陆UI案例
class LoginController :UIViewController ,UITextFieldDelegate{
    
    var  txtUser:  UITextField!  //用户名输入框
    var  txtPwd:  UITextField!  //密码输入款
    var  formView:  UIView!  //登陆框视图
    var  horizontalLine:  UIView!  //分隔线
    var  confirmButton: UIButton!  //登录按钮
    var  titleLabel:  UILabel!  //标题标签
    var  topConstraint:  Constraint?  //登录框距顶部距离约束
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登陆UI案例"
        self.view.backgroundColor = UIColor.white;
        
        //背景色
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255, alpha: 1);
        
        //登陆框高度
        let formViewHeight = 90;
        //登陆框背景
        self.formView = UIView();
        self.formView.layer.borderWidth = 0.5;
        self.formView.layer.borderColor =  UIColor.lightGray.cgColor
        self.formView.backgroundColor =  UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        self.formView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        //分割线
        self.horizontalLine = UIView();
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(horizontalLine)
        self.horizontalLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView)
        }
        
        //密码图
        let imgLock1 = UIImageView(frame: CGRectMake (11, 11, 22, 22))
        imgLock1.image = UIImage(named: "iconfont-user.png")
        
        //密码图
        let imgLock2 =  UIImageView(frame: CGRectMake (11, 11, 22, 22))
        imgLock2.image =  UIImage (named: "iconfont-password.png" )
        
        //用户名输入框
        txtUser = UITextField();
        txtUser.delegate = self;
        txtUser.placeholder = "用户名"
        txtUser.tag = 100;
        txtUser.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        txtUser.leftViewMode = UITextField.ViewMode.always;
        txtUser.returnKeyType = UIReturnKeyType.next;
        txtUser.leftView?.addSubview(imgLock1)
        self.formView.addSubview(txtUser)
        txtUser.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(formView).offset(-formViewHeight/4)
        }
        
        
        txtPwd = UITextField();
        txtPwd.delegate = self;
        txtPwd.placeholder = "密码"
        txtPwd.tag = 101;
        txtPwd.leftView = UIView(frame: CGRectMake(0, 0, 44, 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always;
        txtPwd.returnKeyType = UIReturnKeyType.next;
        txtPwd.leftView?.addSubview(imgLock2)
        formView.addSubview(txtPwd)
        txtPwd.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(formView).offset(formViewHeight/4)
        }
        
        confirmButton = UIButton();
        confirmButton.setTitle("登陆", for: .normal)
        confirmButton.setTitleColor(UIColor.black, for: .normal)
        confirmButton.layer.cornerRadius = 5;
        confirmButton.backgroundColor = UIColor(_colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5)
        self.view.addSubview(confirmButton)
        confirmButton.addTarget(self, action: #selector(loginConfrim), for: .touchUpInside)
        confirmButton.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.formView.snp_bottom).offset(20)
            make.height.equalTo(44)
        }
        
        titleLabel = UILabel();
        titleLabel.text = "登录即表示你同意《用户协议》和《隐私政策》";
        titleLabel.font = UIFont.systemFont(ofSize: 12);
        titleLabel.textColor = .white;
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40);
            make.centerX.equalTo(self.view)
        }
    }
    
    //登陆按钮点击
    @objc func loginConfrim() {
        //收起键盘
        self.view.endEditing(true);
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded();
        }
        
        let textUser = txtUser.text;
        if (((textUser?.isEmpty) != nil) && textUser?.count == 0) {
            showToast(message: "用户名输入不能为空")
            return
        }
        let textPwd = txtPwd.text;
        if (((textPwd?.isEmpty) != nil) && textPwd?.count == 0) {
            showToast(message: "密码输入不能为空")
            return
        }
        showToast(message: "开始登陆")
    }
    
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded();
        }
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let  tag = textField.tag
        switch tag {
        case  100:
            self.txtPwd.becomeFirstResponder();
        case  101:
            loginConfrim();
        default :
            print(textField.text)
        }
        return  true
    }
}


class keyboradController : UIViewController {
    
}
