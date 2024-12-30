//
//  NewsViewController.h
//  FunOnline
//
//  Created by 杨充 on 2018/4/4.
//

#import "BasicViewController.h"
#import "PagingScrollMenu.h"

//新闻
@interface NewsViewController : BasicViewController

@property (nonatomic, strong) PagingScrollMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray *newsObjects;
@property (nonatomic, strong) NSArray *titleObjects;
@property (nonatomic, strong) NSArray *idsObjects;

@property (nonatomic, strong) NewsModel *selectModel;
@property (nonatomic, strong) UIButton  *reachButton;
@property (nonatomic, strong) NSString  *categoryId;

@property (nonatomic, assign) NSInteger scrollIndex;
@property (nonatomic, assign) NSInteger count;


@end
