//
//  WallpaperViewController.m
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCellItem.h"

@interface CollectionViewController ()

@property (nonatomic , strong) UICollectionView *uICollectionView;

@end


//UICollectionView 是 iOS 开发中用于展示可滚动的网格或自定义布局的控件。它是 UIScrollView 的子类，可以用于展示多个项目，并支持自定义的单元格。
//UICollectionView在使用的时候比UITableView更严格，特别是侧重于UICollectionViewCell的重用，在创建诸多对象的时候，一定要使用重用机制，否则就会报相应 的错误
@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollectionView];
}

- (void) setCollectionView {
    //创建了一个 UICollectionView 对象，并设置了其位置、大小和布局。
    //UICollectionViewFlowLayout 是 iOS 开发中用于在 UICollectionView 中实现基本布局的内置布局类。它提供了一些属性和方法，可以方便地设置单元格的大小、间距和对齐方式等。
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10; // 设置单元格之间的水平间距
    layout.minimumLineSpacing = 10; // 设置单元格之间的垂直间距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 设置每个 section 的边距
    //使用 scrollDirection 属性来设置滚动方向，如水平滚动或垂直滚动。
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置水平滚动
    //sectionInsetReference 属性来设置边距参考的方式，如安全区域或内容区域
    layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromSafeArea; // 设置边距参考安全区域
    //使用 alignment 属性来设置单元格的对齐方式，如居中对齐、左对齐或右对齐。
    //layout.alignment = UICollectionViewFlowLayoutAlignmentCenter; // 设置对齐方式为居中对齐
    //使用 estimatedItemSize 属性来设置估计的单元格大小，以便在布局之前进行预估。
    layout.estimatedItemSize = CGSizeMake(100, 100); // 设置估计的单元格大小
    //使用 itemSize 属性设置为 UICollectionViewFlowLayoutAutomaticSize 可以让布局自动调整单元格的大小，根据内容自适应。
    layout.itemSize = UICollectionViewFlowLayoutAutomaticSize; // 自动调整单元格大小
    _uICollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    //将视图控制器设置为 UICollectionView 的代理和数据源。
    //需要实现 UICollectionViewDelegate 和 UICollectionViewDataSource 中的代理方法来提供集合视图的项目数、单元格内容和处理选中事件等。
    _uICollectionView.delegate = self;
    _uICollectionView.dataSource = self;
    [self.view addSubview:_uICollectionView];
    
    //刷新集合视图数据，当数据源发生变化时，你可以调用 reloadData 方法来刷新集合视图的数据。
    //[_collectionView reloadData];
    
    [_uICollectionView registerClass:[CollectionViewCellItem class] forCellWithReuseIdentifier:@"Cell"];
}

// ...

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 返回集合视图的项目数
    return 10;
}

//在 cellForItemAtIndexPath: 方法中，你可以自定义单元格的外观和内容。可以使用自定义的 UICollectionViewCell 子类，或者使用内置的 UICollectionViewCell 并设置其属性来自定义单元格的样式。
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 返回指定位置的单元格
//    static NSString *cellIdentifier = @"Cell";
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    // 配置单元格的内容
//    cell.backgroundColor = [UIColor blueColor];
    
    CollectionViewCellItem *cell = (CollectionViewCellItem *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    // 配置自定义单元格的内容
    //cell.imageView.image = [UIImage imageNamed:@"image.png"];
    //cell.titleLabel.text = @"Title";
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 处理选中某个单元格的事件
}

@end
