//
//  ViewController.swift
//  YCiOSHelper
//
//  Created by 杨充 on 2024/11/27.
//

import UIKit

class ViewController: UIViewController {
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(#function);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function);
    }
    
    override func loadView() {
        super.loadView()
        print(#function);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function);
    }
    
    deinit {
        print(#function);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let text = UITextView();
        text.text = "这个是标题"
        self.view.addSubview(text);
    }
    

}
            
