//
//  ProjectViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-2.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//壁纸界面
#import "ProjectViewController.h"
#import "ProjectCell.h"
#import "ProjectModel.h"
#import "FenLeiViewController.h"
#import "ZhuantiViewController.h"
#import "CacheManager.h"

#import "ZhuanTiCollertionCell.h"
#import "MyTabViewController.h"


#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTBridgeModule.h>
#import "AppDelegate.h"
@interface ProjectViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RCTBridgeModule>
{
    UIImageView *_footview;
    UICollectionView *collectionview;
    UICollectionViewFlowLayout *flowlayout;
}
@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    _dataArray = [[NSMutableArray alloc]init];
   // [self initRN];
    
  
   [self addleftandrightbtn];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configUI];
    [self preData];
   [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRefreshHeader:YES andHaveFooter:YES];
}
-(void)initRN{
 
    
    NSURL *jsCodeLocation;
    
   //本地生产jsbundle文件不许要连网
  jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"index.ios" withExtension:@"jsbundle"];
    
   //jsCodeLocation = [NSURL URLWithString:@"http://192.168.1.6:8081/index.ios.bundle?platform=ios&dev=true"];
   
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNHighScores"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    self.view = rootView;
   
    
}
//zhuanti.imagearray = _dataArray;
//zhuanti.collectionitemid =indexPath.row;
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(doSomething:(NSInteger)rowIndex andArray:(NSArray*)imagesArray){
  
    NSArray *ar = [NSArray arrayWithArray:imagesArray];
 
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        //rn端触发跳转到原生界面
        [self PushTwoVc:rowIndex andArray:ar];
        
    });
    
    
    
}
-(void)PushTwoVc:(NSInteger)rowindex andArray:(NSArray *)array{
   
    
  
    //ios中的rn界面点击rn按钮跳转到原生界面
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ZhuantiViewController *zhuanti = [[ZhuantiViewController alloc]init];
    zhuanti.collectionitemid =rowindex;
    zhuanti.imagearray = array;
  
    zhuanti.modalTransitionStyle =0;
    [app.LeftSlideVC presentViewController:zhuanti animated:YES completion:nil];
   //[app.window.rootViewController presentViewController:zhuanti animated:YES completion:nil];
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self name:_CH object:nil];

}
-(void)NSNotiCache
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:_CH object:nil];

}
//通知
-(void)remove:(NSNotification *)not
{

    NSInteger index = [not.userInfo[@"tag1"]integerValue];
    if (index==1) {
        [[CacheManager manager]removeItematPAth:URL_SEARCH];
    }
}


-(void)configUI
{

    
    flowlayout=[[UICollectionViewFlowLayout alloc] init];

    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;//这2个都是流
     flowlayout.minimumLineSpacing =8;
    collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) collectionViewLayout:flowlayout];
   
    collectionview.dataSource = self;
    collectionview.delegate = self;
    collectionview.showsVerticalScrollIndicator = NO;
    collectionview.showsHorizontalScrollIndicator = NO;
    collectionview.backgroundColor = [UIColor whiteColor];
    [collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([ZhuanTiCollertionCell class]) bundle:nil] forCellWithReuseIdentifier:@"zhuanticell"];
    [self.view addSubview:collectionview];
    
  
    
  
}
-(void)reloadData{
    
    [collectionview.mj_header endRefreshing];
    [collectionview.mj_footer endRefreshing];
    _currentPage=0;
    [self loadData];
    
}
-(void)loadMore{
    
    [collectionview.mj_header endRefreshing];
    [collectionview.mj_footer endRefreshing];
    _currentPage+=63;
    [self loadData];
}

-(void)preData
{

}
-(void)loadData
{

    NSString *str = [NSString stringWithFormat:URL_SEARCH,_currentPage];
[[HttpManager shareManager]requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
    [collectionview.mj_header endRefreshing];
    [collectionview.mj_footer endRefreshing];
    if (_currentPage==0) {
        
        [_dataArray removeAllObjects];
    }
    
  
    NSDictionary *dic = responseObject[@"res"];
//    NSDictionary *dic1 = dic[@"returnData"];
    NSArray *dataArray = dic[@"data"];
    for (NSDictionary *dic2 in dataArray) {
        ProjectModel *model = [[ProjectModel alloc]initWithDictionary:dic2 error:nil];
        [_dataArray addObject:model];
        
    }
    [collectionview reloadData];
} withFailureBlock:^(NSError *error) {
    [collectionview.mj_header endRefreshing];
    [collectionview.mj_footer endRefreshing];
}];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhuanTiCollertionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zhuanticell" forIndexPath:indexPath];
                                   
    ProjectModel *model =_dataArray[indexPath.row];
   [cell.zhuantiimageivew sd_setImageWithURL:[NSURL URLWithString:model.thumb]];

    return cell;
}
#pragma mark ----  点击item的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"%ld",_dataArray.count);
//
   ZhuantiViewController *zhuanti = [[ZhuantiViewController alloc]init];
  zhuanti.imagearray = _dataArray;
   zhuanti.collectionitemid =indexPath.row;
    zhuanti.modalTransitionStyle =0;
   [self presentViewController:zhuanti animated:YES completion:nil];
    
    
    
    
    
    //隐藏标签栏
//    self.tabBarController.tabBar.hidden = YES;
//
//   [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
//    [self.navigationController pushViewController:zhuanti animated:YES];
//
    //    [self.dataArr removeObjectAtIndex:indexPath.item];
    //TODO:  这个方法 特别注意 删除item的方法
    //    [self.myCollectionView deleteItemsAtIndexPaths:@[indexPath]];
}
//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = self.view.frame.size.width;
    
    if (width==320) {
        return CGSizeMake(100, 100*1.5);
    }if (width==375) {
        
        return CGSizeMake(118.3, 118*1.5);
    }else {
        return CGSizeMake(131, 131*1.5);
    }
    
    return CGSizeMake(0, 0);
    
    
}
-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter
{
    //风格要一致,要么用block,要么用第一个
    if (ishavHeader) {
        collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //这个是开始加载数据
        [collectionview.mj_header beginRefreshing];
    }
    if(havFooter){
        KWS(ws);
        collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上啦加载更多
            [ws loadMore];
        }];

    }
}
@end
