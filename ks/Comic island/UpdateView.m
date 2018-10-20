//
//  UpdateView.m
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "UpdateView.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "Define.h"
#import "UpDataModel.h"
#import "UpDataCellTableViewCell.h"
#import "MJRefresh.h"
#import "CacheManager.h"
@implementation UpdateView
{

    NSMutableArray *_dataArray;
    UITableView *_tableview;
    NSInteger _page;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];

        [self configUI];
    }
    return self;
}

-(void)loadData
{
    
    NSString *StrUrl = [NSString stringWithFormat:URL_UPDATA,(long)_page];
    
   [[HttpManager shareManager]requestWithUrl:StrUrl withDictionary:nil withSuccessBlock:^(id responseObject) {
   
       [_tableview.mj_header endRefreshing];
       [_tableview.mj_footer endRefreshing];
       
       if (_page==1) {
           [_dataArray removeAllObjects];
       }
       NSDictionary *dic1 = responseObject[@"data"];
       NSArray *dataArray =dic1[@"returnData"];
       for (NSDictionary *dic2 in dataArray) {
           UpDataModel *model = [[UpDataModel alloc]initWithDictionary:dic2 error:nil];
           [_dataArray addObject:model];
           
       }
       [_tableview reloadData];
    } withFailureBlock:^(NSError *error) {
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];
      
    }];
    
    
}
-(void)configUI
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerNib:[UINib nibWithNibName:@"UpDataCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"updatacell"];
    
    [self addRefreshHeader:YES andHaveFooter:YES];
    
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
    UpDataCellTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    UpDataModel *updatamodel = _dataArray[indexPath.row];
    [cell.updataImageview sd_setImageWithURL:[NSURL URLWithString:updatamodel.cover]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
    cell.updataTitleLabel.text = updatamodel.name;
    cell.updatazuozheLable.text = updatamodel.nickname;
    cell.updataxiazaiLable.text = updatamodel.click_total;
    if ([updatamodel.is_dujia isEqualToString:@"0"]) {
        cell.updataDujiaImageview.hidden  = YES;
    }else{
        cell.updataDujiaImageview.hidden = NO;
    
    }
    

    cell.updatagenxindaoLable.text = updatamodel.last_update_chapter_name;
    
    //时间错转时间方法
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"HH:mm:ss";
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    dateFormatter.timeZone=timeZone;
    NSTimeInterval a=[updatamodel.last_update_time doubleValue];
    NSDate *currentDate=[NSDate dateWithTimeIntervalSince1970:a];
    NSString *dateStr=[dateFormatter stringFromDate:currentDate];
    cell.updatagenxinshijianLable.text=dateStr;
    

    return cell;

}
-(void)addRefreshHeader:(BOOL)ishavHeader andHaveFooter:(BOOL) havFooter
{
    //风格要一致,要么用block,要么用第一个
    if (ishavHeader) {
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        //这个是开始加载数据
        [_tableview.mj_header beginRefreshing];
    }
    if(havFooter){
        KWS(ws);
        _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上啦加载更多
            [ws loadMore];
        }];
        
    }

}
//下拉刷新
-(void)reloadData
{
    [_tableview.mj_header endRefreshing];
    _page=1;
    [self loadData];
}
//加载跟多
-(void)loadMore
{
    [_tableview.mj_footer endRefreshing];
    _page++;
    [self loadData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate updataBookid:[_dataArray[indexPath.row]comic_id]];
    
}
@end
