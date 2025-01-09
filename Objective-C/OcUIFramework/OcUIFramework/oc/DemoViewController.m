//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "DemoViewController.h"
#import "UIKitViewController.h"
#import "TableViewController.h"
#import "CollectionViewController.h"
#import "WebViewController.h"
#import "Masonry.h"


@interface DemoViewController ()

@property (nonatomic, strong) UITextView *textView1;
@property (nonatomic, strong) UITextView *textView2;
@property (nonatomic, strong) UITextView *textView3;
@property (nonatomic, strong) UITextView *textView4;
@property (nonatomic, strong) UITextView *textView5;
@property (nonatomic, strong) UITextView *textView6;
@property (nonatomic, strong) UITextView *textView7;
@property (nonatomic, strong) UITextView *textView8;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView1 = [[UITextView alloc] init];
    _textView1.text = @"1.普通控件，文本/图片/输入框/按钮";
    _textView1.font = [UIFont systemFontOfSize:12];
    _textView1.textColor = [UIColor blackColor];
    _textView1.layer.borderWidth = 1.0;
    _textView1.layer.borderColor = [UIColor grayColor].CGColor;
    _textView1.layer.cornerRadius = 5.0;
    _textView1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView1];
    [_textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@300);
        make.height.equalTo(@40);
    }];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText1:)];
    [_textView1 addGestureRecognizer: tapGesture1];
    
    _textView2 = [[UITextView alloc] init];
    _textView2.text = @"2.TableView控件案例";
    _textView2.font = [UIFont systemFontOfSize:12];
    _textView2.textColor = [UIColor blackColor];
    _textView2.layer.borderWidth = 1.0;
    _textView2.layer.borderColor = [UIColor grayColor].CGColor;
    _textView2.layer.cornerRadius = 5.0;
    _textView2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView2];
    [_textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView1.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText2:)];
    [_textView2 addGestureRecognizer: tapGesture2];
    
    
    _textView3 = [[UITextView alloc] init];
    _textView3.text = @"3.CollectionView控件案例";
    _textView3.font = [UIFont systemFontOfSize:12];
    _textView3.textColor = [UIColor blackColor];
    _textView3.layer.borderWidth = 1.0;
    _textView3.layer.borderColor = [UIColor grayColor].CGColor;
    _textView3.layer.cornerRadius = 5.0;
    _textView3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView3];
    [_textView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView2.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.width.equalTo(self.textView2);
        make.height.equalTo(self.textView2.mas_height);
    }];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText3:)];
    [_textView3 addGestureRecognizer: tapGesture3];
    
    _textView4 = [[UITextView alloc] init];
    _textView4.text = @"4.ScrollView控件案例";
    _textView4.font = [UIFont systemFontOfSize:12];
    _textView4.textColor = [UIColor blackColor];
    _textView4.layer.borderWidth = 1.0;
    _textView4.layer.borderColor = [UIColor grayColor].CGColor;
    _textView4.layer.cornerRadius = 5.0;
    _textView4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView4];
    [_textView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView3.mas_bottom).offset(20);
        make.width.equalTo(self.textView3.mas_width);
        make.height.equalTo(self.textView3.mas_height);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText4:)];
    [_textView4 addGestureRecognizer: tapGesture4];
    
    _textView5 = [[UITextView alloc] init];
    _textView5.text = @"5.WebView综合案例展示";
    _textView5.font = [UIFont systemFontOfSize:12];
    _textView5.textColor = [UIColor blackColor];
    _textView5.layer.borderWidth = 1.0;
    _textView5.layer.borderColor = [UIColor grayColor].CGColor;
    _textView5.layer.cornerRadius = 5.0;
    _textView5.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView5];
    [_textView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView4.mas_bottom).offset(20);
        make.width.equalTo(self.textView4.mas_width);
        make.height.equalTo(self.textView4.mas_height);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickText5:)];
    [_textView5 addGestureRecognizer: tapGesture5];
}

- (void)clickText1:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    UIKitViewController *vc = [[UIKitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText2:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText3:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickText4:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑

}

- (void)clickText5:(UITapGestureRecognizer *)gesture {
    // 处理点击事件的逻辑
    WebViewController *vc = [[WebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
