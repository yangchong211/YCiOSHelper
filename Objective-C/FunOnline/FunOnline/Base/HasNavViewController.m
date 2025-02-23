//
//  HasNavViewController.m
//  BotherSellerOC
//
//  Created by 杨充 on 2017/4/8.
//

#import "HasNavViewController.h"

@interface HasNavViewController ()

@end

//有nav控制器
@implementation HasNavViewController

#pragma mark - Lazys

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = kSpacing;
        layout.minimumInteritemSpacing = kSpacing;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

#pragma mark - Life Cycle

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 显示导航栏
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

/**
 设置状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    //UIStatusBarStyle 是一个枚举类型，用于指定状态栏的样式。
    //UIStatusBarStyleDefault：默认样式，状态栏文字为黑色。
    //UIStatusBarStyleLightContent：浅色内容样式，状态栏文字为白色。
    //UIStatusBarStyleDarkContent：深色内容样式，状态栏文字为黑色（仅适用于 iOS 13 及更高版本）。
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
