//
//  FenLeiViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-7.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//分类界面跳转的界面里面是某一类漫画
#import "FenLeiViewController.h"
#import "UpDataCellTableViewCell.h"
#import "UpDataModel.h"
#import "DetailsViewController.h"
#import "MJRefresh.h"
@interface FenLeiViewController ()

@end

@implementation FenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _dataArray =[[NSMutableArray alloc]init];
    [self configUI];
//    [self loadData];
    
    [self addBarBtnItemWithTitle:@"返回" withImageName:@"" withPosition:LEFT_BARITEM];
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)configUI
{
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES){
        iswithd=64;
        
    }else{
        iswithd=49;
        
    }
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-iswithd-64) style:UITableViewStylePlain];
   _tableView.delegate = self;
   _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"UpDataCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"updatacell"];
    [self addRefreshHeader:YES andHaveFooter:YES];
}
-(void)loadData
{
    
    NSString *str1 =@"%205";
    NSString *str = [NSString stringWithFormat:URL_FENLEI,str1,(long)_currentPage,_argName,_bookId];
//   NSLog(@"-0-------%@",str);
    [[HttpManager shareManager]requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
               [_tableView.mj_header endRefreshing];
                [_tableView.mj_footer endRefreshing];
        
                if (_currentPage==1) {
                    [_dataArray removeAllObjects];
                }
        
               NSDictionary *dic1 = responseObject[@"data"];
   
      
                NSArray *dataArray =dic1[@"returnData"];
        if ([dataArray isKindOfClass:[NSNull class]]) {
   
             //提示用户已经全部加载完毕
              _tableView.mj_footer.state = MJRefreshStateNoMoreData;

        }else{

        
                    for (NSDictionary *dic2 in dataArray) {
        
                        UpDataModel *model = [[UpDataModel alloc]initWithDictionary:dic2 error:nil];
                        [_dataArray addObject:model];
                    }
    
        }
        [_tableView reloadData];
            
    } withFailureBlock:^(NSError *error) {
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
    }];

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"updatacell";
    UpDataCellTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    UpDataModel *updatamodel = _dataArray[indexPath.row];
    [cell.updataImageview sd_setImageWithURL:[NSURL URLWithString:updatamodel.cover]];
    cell.updataTitleLabel.text = updatamodel.name;
    cell.updatazuozheLable.text = updatamodel.nickname;
    cell.updataxiazaiLable.text = updatamodel.click_total;
    if ([updatamodel.is_dujia isEqualToString:@"0"]) {
        cell.updataDujiaImageview.hidden  = YES;
    }else{
        cell.updataDujiaImageview.hidden = NO;
        
    }
    cell.updataGenxindao.text=@"介绍:";
  //把这个变成介绍,然后把跟新到拉进来
    cell.updatagenxindaoLable.text = updatamodel.description1;
    cell.updatagenxindaoLable.frame=CGRectMake(0, 0, 220, 45);
    cell.updatagenxindaoLable.numberOfLines=2;
    cell.updatagenxindaoLable.lineBreakMode=NSLineBreakByTruncatingTail;
    
    //时间错转时间方法
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"HH:mm:ss";
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    dateFormatter.timeZone=timeZone;
    NSTimeInterval a=[updatamodel.last_update_time doubleValue];
    NSDate *currentDate=[NSDate dateWithTimeIntervalSince1970:a];
    NSString *dateStr=[dateFormatter stringFromDate:currentDate];
    cell.updatagenxinshijianLable.text=dateStr;
    
    
    //    cell.updatagenxinshijianLable.text =
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *deat = [[DetailsViewController alloc]init];
    deat.com_id1 = [_dataArray[indexPath.row]comic_id];
    deat.title = @"漫画详情";
    [self.navigationController pushViewController:deat animated:YES];
//    NSLog(@"我要跳详情");
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
   [_tableView.mj_header endRefreshing];
    _currentPage=1;
    [self loadData];
}
//加载跟多
-(void)loadMore
{
[_tableView.mj_footer endRefreshing];
    _currentPage++;
    [self loadData];
    
}

@end
