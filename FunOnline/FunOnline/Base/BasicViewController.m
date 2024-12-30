//
//  ViewController.m
//  BotherSellerOC
//
//  Created by 杨充 on 2017/4/6.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

#pragma mark - Lazy 懒加载控件

//给tableView赋值
- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat height = iPhoneX ? (SCREEN_HEIGHT-88) : (SCREEN_HEIGHT-64);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, height)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor viewBackGroundColor];
        _tableView.separatorColor = [UIColor colorBoardLineColor];
        //设置代理
        _tableView.delegate = self;
        //设置数据
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CustomeViewLayout *flowLayout = [[CustomeViewLayout alloc] init]; //瀑布流布局
        flowLayout.columnCount = maxColumn; //共多少列
        flowLayout.columnSpacing = spacing; //列间距
        flowLayout.rowSpacing = spacing; //行间距
        //设置collectionView整体的上下左右之间的间距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, spacing, spacing, spacing);
        flowLayout.delegate = self;
        CGFloat height = iPhoneX ? (SCREEN_HEIGHT - 83) : (SCREEN_HEIGHT - 49);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

//结束刷新
- (void)endRefreshing {
    [XDProgressHUD hideHUD]; // 移除菊花
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark - Life Cycle 控件生命周期

//用于返回视图控制器的首选状态栏样式（UIStatusBarStyle）。
- (UIStatusBarStyle)preferredStatusBarStyle {
    [super preferredStatusBarStyle];
    //UIStatusBarStyle 是一个枚举类型，用于指定状态栏的样式。
    //UIStatusBarStyleDefault：默认样式，状态栏文字为黑色。
    //UIStatusBarStyleLightContent：浅色内容样式，状态栏文字为白色。
    //UIStatusBarStyleDarkContent：深色内容样式，状态栏文字为黑色（仅适用于 iOS 13 及更高版本）。
    return UIStatusBarStyleDefault;
}

//视图控制器生命周期方法，在视图控制器的视图加载完成后被调用。
- (void)viewDidLoad {
    //调用了 super 的 viewDidLoad 方法，以确保父类的实现得到执行。
    [super viewDidLoad];
    
    //布尔属性，用于控制视图控制器是否自动调整滚动视图的内边距。
    //将 automaticallyAdjustsScrollViewInsets 属性设置为 NO。这样，滚动视图的内容区域将不会被自动调整，你可以自行处理滚动视图的内边距。
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor viewBackGroundColor];
    
    self.tableView.emptyDataSetSource   = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.collectionView.emptyDataSetSource   = self;
    self.collectionView.emptyDataSetDelegate = self;
    
    //发布通知：
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:nil];
    //订阅通知：
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"MyNotification" object:nil];
    [NC addObserver:self selector:@selector(recoverRefresh) name:NC_Reload_Home object:nil];
    [NC addObserver:self selector:@selector(recoverRefresh) name:NC_Reload_Music object:nil];
    //通知中心是一种强大的机制，可以在应用程序中实现模块之间的解耦和通信。但请确保适度使用，避免滥用通知，以保持代码的可读性和维护性。
}

//处理通知：
- (void)recoverRefresh {
    if (![self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header beginRefreshing];
    }
    if (![self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header beginRefreshing];
    }
}

//视图控制器生命周期方法，在视图控制器的视图已经从屏幕上消失后被调用。
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

//视图控制器生命周期方法，在应用程序收到内存警告时被调用。
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图控制器生命周期方法，在视图控制器的安全区域发生变化时被调用。
- (void)viewSafeAreaInsetsDidChange {
    // 补充：顶部的危险区域就是距离刘海10points(状态栏不隐藏)
    // 也可以不写，系统默认是UIEdgeInsetsMake(10, 0, 34, 0);
    [super viewSafeAreaInsetsDidChange];
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(10, 0, 34, 0);
}

//UIScrollViewDelegate 协议中的一个方法，用于监听滚动视图的滚动事件。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    // 获取滚动视图的滚动位置和偏移量
    //CGPoint contentOffset = scrollView.contentOffset;
    // 根据滚动位置执行相应的操作
    //[self updateUIWithContentOffset:contentOffset];
}

#pragma mark - <DZNEmptyDataSetSource>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"icon_loading_image"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *buttonTitle = @"请点击重试哟~";
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f],
        NSForegroundColorAttributeName: [UIColor colorThemeColor]
    };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}


#pragma mark - <CustomViewLayoutDelegate>
- (CGFloat)customFallLayout:(CustomeViewLayout *)customFallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = ((SCREEN_WIDTH - (maxColumn + 1) * spacing) / maxColumn) - 20;
    return arc4random() % 30 + width;
}

#pragma mark - <DZNEmptyDataSetDelegate>
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    WeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf customReload];
    });
}

- (void)customReload {
    if (![self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header beginRefreshing];
    }
    if (![self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return SCREEN_HEIGHT * 0.2;
}

#pragma mark -
#pragma mark - <UINavigationControllerDelegate iPhoneX适配处理>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![[[UIDevice currentDevice] model] isEqualToString: @"iPhone X"]) {
        return;
    }
    CGRect frame = self.tabBarController.tabBar.frame;
    if (frame.origin.y < ([UIScreen mainScreen].bounds.size.height - 83)) {
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - 83;
        self.tabBarController.tabBar.frame = frame;
    }
}

#pragma mark - dealloc

//是一个对象的析构方法，在对象被释放时被调用。
- (void)dealloc {
    //当一个对象不再被使用时，系统会自动释放该对象所占用的内存。在对象被释放之前，系统会调用对象的 dealloc 方法，你可以在这个方法中执行一些清理操作，如释放资源、取消订阅通知等。
    [NC removeObserver:self name:NC_Reload_Home object:nil];
    [NC removeObserver:self name:NC_Reload_Music object:nil];
}

@end
