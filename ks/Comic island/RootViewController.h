//
//  RootViewController.h
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "HttpManager.h"
#import "UIImage+WebP.h"
//<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   // UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    NSInteger _currentPage;
    NSInteger _totalPage;
    UITableView *_tableView;
}
-(void)configUI;
-(void)loadData;
//UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter;
//下拉刷新
-(void)reloadData;
//加载跟多
-(void)loadMore;

-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger) position;
-(void)leftClick;
-(void)rightClick;

-(void)addleftandrightbtn;
@end
