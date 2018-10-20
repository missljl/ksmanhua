//
//  ReadviewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//阅读界面
#import "ReadviewController.h"
#import "ReadModel.h"
#import "ReadCell.h"
#import "DetailTwoModel.h"
#import "DetailModel.h"
#import "DetailsViewController.h"

#import "YDJlManager.h"


#import "JSHAREService.h"

#import "ShareView.h"

//#import <UShareUI/UShareUI.h>
@interface ReadviewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSString *_cupage;
      NSInteger inz;
    float lastContntoffset;
    UIView *view;
    ReadCell *cell;
    //backbtn
    UIButton *Btn;
    //booktitle
    UILabel *label;
//    ShareView *shaerView;
}
@property (nonatomic, strong) ShareView * shareView;
@end

@implementation ReadviewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    _dataArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor blackColor];
//    _cupage = _chid;
    [self configUI];
//    [self loadData];
    self.automaticallyAdjustsScrollViewInsets= NO;
}
//单一控制器状态栏白色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    
//    return UIStatusBarStyleLightContent;
//    
//}


-(void)configUI
{
    CGFloat iswithd;
   
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=20;
       
    }else{
        iswithd=0;
      
    }
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-iswithd)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"ReadCell" bundle:nil] forCellReuseIdentifier:@"readcell"];
    [self addRefreshHeader:YES andHaveFooter:YES];
    
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 64)];
    view.tag=3000;
    view.backgroundColor = [UIColor blackColor];
    view.alpha=0.6;
    [self.view addSubview:view];
    Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(10, 20, 44, 44);
    
    [Btn setImage:[UIImage imageNamed:@"btn_back@2x"] forState:UIControlStateNormal];
//    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [Btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [Btn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Btn];
    
    
    UIButton *sharbtn  = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-54, 20, 44, 44)];
    [sharbtn setImage:[UIImage imageNamed:@"actionbar_share"] forState:UIControlStateNormal];
    [sharbtn addTarget:self action:@selector(sharbtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sharbtn];
    
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(60, 20,view.frame.size.width-120,44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
   label.text = _BookTitle;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    
    
    
}
-(void)loadData
{
    NSString *str1 = @"%205";
    NSString *str = [NSString stringWithFormat:@"http://app.u17.com/v3/app/ios/phone/comic/chapter?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%@s&time=1446987465&imgtype=1&chapter_id=%@&",str1,_cupage];
    
[[HttpManager shareManager]requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
//    NSLog(@"%@",responseObject);

    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];

    if (inz==0) {
        [_dataArray removeAllObjects];
    }

    NSDictionary *dic1 = responseObject[@"data"];
    NSArray *ar = dic1[@"returnData"];
    for (NSDictionary *dic3 in ar) {
        ReadModel *model = [[ReadModel alloc]initWithDictionary:dic3 error:nil];
        [_dataArray addObject:model];
//        NSLog(@"%@",model);
    }
    [_tableView reloadData];
} withFailureBlock:^(NSError *error) {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}];

    

}
#pragma mark----tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return self.view.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellId = @"readcell";
    cell = [_tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    ReadModel *model = _dataArray[indexPath.row];
    cell.backgroundColor = [UIColor blackColor];
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(PingGerture:)];
    [cell addGestureRecognizer:pin];
    [cell.readImageivew sd_setImageWithURL:[NSURL URLWithString:model.location]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
    return cell;
    
}
#pragma mark---cell的放大缩小
-(void)PingGerture:(UIPinchGestureRecognizer *)pin
{
    static CGFloat sc=1;
    CGAffineTransform transform = CGAffineTransformMakeScale(sc*pin.scale, sc*pin.scale);
    pin.view.transform =transform;
 
}
#pragma mark---
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
#pragma mark---刷新
-(void)reloadData
{
    [_tableView.mj_header endRefreshing];
    _cupage=_chid;
    [self loadData];
  
}
//加载跟多
#pragma mark----加载更多
-(void)loadMore
{
    
    
    [_tableView.mj_footer endRefreshing];

    
    for (NSInteger i=0; i<_cutaArray.count; i++) {
        if (_cupage ==[_cutaArray[i]chapter_id]) {
            inz = i;
         
        }
      
        
    }
    
    
    if (_cupage == [[_cutaArray lastObject]chapter_id]) {
        
        NSLog(@"已经到低了了");
    }else{
          inz++;
        _cupage=[_cutaArray[inz]chapter_id];
      
        [self loadData];
        
    }
    
}

#pragma mark-----scrollview delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollView=_tableView;
    lastContntoffset = scrollView.contentOffset.y;
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
   
    
    if (lastContntoffset < scrollView.contentOffset.y) {
//        NSLog(@"向上滚动");
       
        view.hidden = YES;
    }else{
        view.hidden = NO;
         label.text =[_cutaArray[inz]name1];
//        NSLog(@"向下滚动");

        
    }
}
//返回按钮
#pragma mark---返回按钮点击事件
-(void)add:(UIButton *)Btn
{

   
    [self dismissViewControllerAnimated:YES completion:^{
        YDJlManager *manager = [YDJlManager ydjlManager];
        DetailModel *model = [[DetailModel alloc]init];
        model.name = self.bookname;
        model.comic_id = self.bookid;
        model.cover = _cupage;
        model.author_name = label.text;
        BOOL isyoufu = [manager isExists:model];
        if (isyoufu) {
            [manager deleteModel:model];
            [manager addModel:model];
         
        }else{
            [manager addModel:model];
          
        }
        
    }];
}

#pragma mark----第三方分享点击事件
-(void)sharbtn:(UIButton *)btn{
    
    
//    NSLog(@"书名:%@,书id:%@,书简介:%@,书图片链接%@",_bookname,_bookid,_book_jianjie,_book_imagename);
     [self.shareView showWithContentType:1];

    
    
    
    
    
    
    

    
}

- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
             [self shareLinkWithPlatform:platform];
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
        JSHAREMessage *message = [JSHAREMessage message];
        message.mediaType = JSHARELink;
        message.url = [NSString stringWithFormat:@"http://m.u17.com/c/%@.html?from=singlemessage&isappinstalled=0",_bookid];
        message.text = _book_jianjie;
        message.title = _bookname;
        message.platform = platform;
        NSString *imageURL = _book_imagename;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
        message.image = imageData;
        [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
    
            NSLog(@"分享回调");
    
        }];
}


@end
