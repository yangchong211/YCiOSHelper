//
//  HasNavViewController.h
//  BotherSellerOC
//
//  Created by 杨充 on 2017/4/8.
//

#import <UIKit/UIKit.h>

static CGFloat kSpacing = 10;

@interface HasNavViewController : UIViewController<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
