//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UIKitViewController.h"

typedef void (^ParameterBlock)(NSString *name, NSInteger age);


@interface UIKitViewController ()

// 声明 block 类型的属性
@property (nonatomic, copy) ParameterBlock completionBlock;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageViewUser;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UISwitch *swith;
@property (nonatomic, strong) UITextField *textField;


@property (nonatomic, weak) id<UIKitControllerDelegate> delegate;

@end

@implementation UIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextView];
    [self setLableView];
    [self setImageView];
    [self setButtonView];
    [self setSwitchView];
    [self setTextFieldView];
    ParameterBlock block = ^(NSString *name, NSInteger age) {
        NSLog(@"Name: %@, Age: %ld", name, (long)age);
    };
}

- (void) setTextView{
    _textView = [[UITextView alloc] init];
    _textView.text = @"UITextView 普通文本控件";
    //设置字体大小
    _textView.font = [UIFont systemFontOfSize:12];
    //设置字体颜色
    _textView.textColor = [UIColor blackColor];
    //设置边框
    _textView.layer.borderWidth = 1.0;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.cornerRadius = 5.0;
    _textView.textAlignment = NSTextAlignmentCenter;
    //设置代理
    _textView.delegate = self;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    // 处理文本变化的逻辑
}

- (void) setLableView {
    _lable = [[UILabel alloc] init];
    _lable.text = @"UILabel 标签控件：Hello, World!";
    //设置字体和颜色
    _lable.font = [UIFont systemFontOfSize:12];
    _lable.textColor = [UIColor blackColor];
    //设置边框
    _lable.layer.borderWidth = 1.0;
    _lable.layer.borderColor = [UIColor grayColor].CGColor;
    _lable.layer.cornerRadius = 5.0;
    //设置对齐方式
    _lable.textAlignment = NSTextAlignmentCenter;
    //设置多行文本
    //如果需要显示多行文本，你可以将 numberOfLines 属性设置为 0，并将 lineBreakMode 属性设置为适当的换行模式，如 NSLineBreakByWordWrapping
    //_lable.numberOfLines = 0;
    //_lable.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:_lable];
    [_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
}

- (void) setImageView {
    _imageView = [[UIImageView alloc] init];
    //可以通过 UIImage 的类方法 imageNamed: 来加载本地图像
    _imageView.image = [UIImage imageNamed:@"mine_star"];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    //确保用户交互已启用
    _imageView.userInteractionEnabled = YES;
    //添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    [_imageView addGestureRecognizer:tapGesture];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    _imageViewUser = [[UIImageView alloc] init];
    //使用 initWithData: 方法加载远程图像。
    //_imageViewUser.image = [UIImage imageWithData:<#(nonnull NSData *)#>];
    _imageViewUser.image = [UIImage imageNamed:@"mine_store"];
    _imageViewUser.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageViewUser];
    [_imageViewUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable.mas_bottom).offset(10);
        make.left.equalTo(self.imageView.mas_right).offset(20);
        //make.left.equalTo(self.imageView.mas_rightMargin).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
}

// 点击事件处理方法
- (void)imageViewTapped:(UITapGestureRecognizer *)gesture {
    // 在这里执行你想要的操作
    NSLog(@"ImageView tapped!");
    

//    self.completionBlock(@"John", 25); // 调用block
}

- (void) setButtonView {
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    //_button.frame = CGRectMake(20, 50, 200, 40);
    //使用 setTitle:forState: 方法来设置按钮的标题
    [_button setTitle:@"Click Me" forState:UIControlStateNormal];
    //使用 setTitleColor:forState: 方法来设置标题颜色
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor blueColor];
    //使用 titleLabel 属性来设置标题的字体、对齐方式等。
    _button.titleLabel.font = [UIFont systemFontOfSize:16];
    _button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //自定义按钮外观
    //[button setBackgroundImage:[UIImage imageNamed:@"button_bg.png"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"button_icon.png"] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
}

- (void)buttonTapped:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    NSLog(@"按钮被点击了");
}

- (void) setSwitchView {
    _swith = [[UISwitch alloc] initWithFrame:CGRectMake(20, 50, 0, 0)];
    //获取和设置开关状态
    _swith.on = YES;
    //自定义外观
    //使用 onTintColor 属性来设置开启状态下的颜色
    _swith.onTintColor = [UIColor greenColor];
    //使用 thumbTintColor 属性来设置滑块的颜色。
    _swith.thumbTintColor = [UIColor whiteColor];
    //监听值变化事件
    [_swith addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_swith];
    [_swith mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
}

- (void)switchValueChanged:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    NSLog(@"switch开关被点击了");
    if (_swith.isOn) {
        [self.delegate sendPalmBack:0 data:@"成功"];
    } else {
        [self.delegate sendPalmBack:-1 data:@"失败"];
    }
}

-(void) setTextFieldView {
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"Enter text";
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    //使用 keyboardType 属性来设置键盘类型，如默认键盘、数字键盘、邮箱键盘等。使用 secureTextEntry 属性来设置是否以密码形式显示输入的文本。
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.secureTextEntry = YES;
    [self.view addSubview:_textField];
//    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swith.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@80);
    }];
}


@end
