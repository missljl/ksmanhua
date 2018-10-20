//
//  RootViewController.m
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "RootViewController.h"
#import "SearchTwoViewController.h"

#import "AppDelegate.h"

#import <BmobSDK/Bmob.h>

@interface RootViewController ()
{
    UIImageView *LeftUeserImageView;
    UIButton *LeftUserImageBtn;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
//    [self loadData];
}
-(void)configUI
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*RATE, SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];

}
-(void)loadData
{
//    NSLog(@"子类要重写");
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;

}

-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter
{
    //风格要一致,要么用block,要么用第一个
    if (ishavHeader) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //这个是开始加载数据
        [_tableView.mj_header beginRefreshing];
    }
    if(havFooter){
        KWS(ws);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上啦加载更多
            [ws loadMore];
        }];
        
    }
}
//下拉刷新
-(void)reloadData
{
//    NSLog(@"子类要重写");
}
//加载跟多
-(void)loadMore
{
//    NSLog(@"子类要重写");

}
-(void)addBarBtnItemWithTitle:(NSString *)title withImageName:(NSString *)imageName withPosition:(NSInteger)position
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    if (title.length>0) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
       
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];
        
        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =BarItme;
    }
    if (imageName.length>0) {
        if (position==LEFT_BARITEM) {
           
            [self leftBtnWithimageName:imageName oRImage:nil];
            
                
            
        }else{
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
             UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];
            [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = BarItme;
        }
      }
    }
}


-(void)leftClick
{
    //跳转到登入
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempAppDelegate.LeftSlideVC.closed) {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }else{
        
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
    
}
-(void)rightClick
{
  //跳转到首艘
    SearchTwoViewController *srar = [[SearchTwoViewController alloc]init];
    srar.title = @"搜索";
    [self.navigationController pushViewController:srar animated:YES];
}
-(void)addleftandrightbtn{
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        //需要切个图片换下
        NSString *imagename = [user objectForKey:@"userimagename"];
        UIImage *imagea = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagename]]];
        [self leftBtnWithimageName:@"" oRImage:[self imageResize:imagea andResizeTo:CGSizeMake(38, 38)]];
       
        
    }else{
        [self addBarBtnItemWithTitle:@" " withImageName:@"yonghu" withPosition:LEFT_BARITEM];
        
    }
   
    [self addBarBtnItemWithTitle:@"" withImageName:@"sou" withPosition:RIGHT_BARITEM];
    
}
-(void)leftBtnWithimageName:(NSString *)imagename oRImage:(UIImage *)image{
    LeftUserImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LeftUserImageBtn.frame = CGRectMake(0, 0, 38, 38);
    if (imagename.length>0) {
         [LeftUserImageBtn setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    }else{
         [LeftUserImageBtn setImage:image forState:UIControlStateNormal];
    }
    
    LeftUserImageBtn.layer.cornerRadius = 18.f;//2.0是圆角的弧度，根据需求自己更改
    LeftUserImageBtn.layer.borderColor = [UIColor orangeColor].CGColor;//设置边框颜色
    LeftUserImageBtn.layer.borderWidth = 1.0f;//设置边框颜色
    LeftUserImageBtn.layer.masksToBounds = YES;
    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:LeftUserImageBtn];
    
    [LeftUserImageBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =BarItme;
}
//修改image尺寸
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//登入成功时接受通知
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction) name:@"mydengru" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction) name:@"mydengruTuiChu" object:nil];
}
-(void)notAction{
    [self addleftandrightbtn];
}
@end
