//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic ,strong) UITableView *tableView;

@end


//UITableView 是 iOS 开发中用于显示可滚动列表的控件。它是 UIScrollView 的子类，可以用于展示大量数据，并支持自定义的单元格。
@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

- (void) setTableView {
    //创建了一个 UITableView 对象，并设置了其位置、大小和样式。
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    //还将视图控制器设置为 UITableView 的代理和数据源。
    //你需要实现 UITableViewDelegate 和 UITableViewDataSource 中的代理方法来提供表格的行数、单元格内容和处理选中事件等。
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置顶部view
    _tableView.tableHeaderView = [self defaultHeader];
    //设置底部view
    _tableView.tableFooterView = [self defaultFooter];
    [self.view addSubview:_tableView];
    //当数据源发生变化时，你可以调用 reloadData 方法来刷新表格的数据。
    [_tableView reloadData];
}

//设置默认的底部view
- (UIView *)defaultHeader {
    //view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44*2)];
    view.backgroundColor = [UIColor whiteColor];
    //创建按钮
    UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
    //设置title
    [button setTitle:@"这个是头部View" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //添加view
    [view addSubview: button];
    return view;
}


//设置默认的底部view
- (UIView *)defaultFooter {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    //创建按钮
    UIButton *button = [[UIButton alloc] initWithFrame:view.bounds];
    //设置title
    [button setTitle:@"这个是底部View" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //添加view
    [view addSubview: button];
    return view;
}

#pragma mark - 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 返回表格的行数
    return 10;
}

//在 cellForRowAtIndexPath: 方法中，你可以自定义单元格的外观和内容。可以使用不同的 UITableViewCellStyle 来创建不同样式的单元格，并根据需要设置单元格的文本、图像等。
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 返回指定位置的单元格
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // 配置单元格的内容
    cell.textLabel.text = @"Cell Text ";
    return cell;
}

//点击item后会调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 处理选中某行的事件
    NSInteger row = indexPath.row;  //列数
}


@end
