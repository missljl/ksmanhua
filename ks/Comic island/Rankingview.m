//
//  Rankingview.m
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "Rankingview.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "ListCell.h"
#import "ListModel.h"
#import "Define.h"
#import "CacheManager.h"
@implementation Rankingview
{
    NSMutableArray *_dataArray;
    UITableView *_tableview;

}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _dataArray = [NSMutableArray array];
     
        [self configUI];
        [self NSNotiCache];
        [self loadData];

    }
    return self;
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
        [[CacheManager manager]removeItematPAth:URL_LIST];
    }
    
}



-(void)configUI
{
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self addSubview:_tableview];
    [_tableview registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    
}
-(void)preData
{
    if ([[CacheManager manager]isExists:URL_LIST]) {
        //如果没有就就下载
//        NSLog(@"我有缓存哦");
        NSData *data = [[CacheManager manager]getCache:URL_LIST];
        id res= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = res[@"data"];
            NSDictionary *dicreturnData=dataDic[@"returnData"];
            NSArray *array = dicreturnData[@"rankinglist"];
            for (NSDictionary *dic in array) {
                ListModel *listmodel = [[ListModel alloc]initWithDictionary:dic error:nil];
                [_dataArray addObject:listmodel];
            }
            [_tableview reloadData];
        }
    }else{
    
        [self loadData];
    }
}
-(void)loadData
{

    [[HttpManager shareManager]requestWithUrl:URL_LIST withDictionary:nil withSuccessBlock:^(id responseObject) {

       
        NSDictionary *dataDic = responseObject[@"data"];
        NSDictionary *dicreturnData=dataDic[@"returnData"];
        NSArray *array = dicreturnData[@"rankinglist"];
        for (NSDictionary *dic in array) {
            ListModel *listmodel = [[ListModel alloc]initWithDictionary:dic error:nil];
            [_dataArray addObject:listmodel];
        }
        [_tableview reloadData];
    } withFailureBlock:^(NSError *error) {
               
    }];



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.frame.size.width>375) {
        
        return 139;
    }else{
        
        return 100;
    }
    
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"listcell";
    ListCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    ListModel *listmodel = _dataArray[indexPath.row];
    [cell.listImageview sd_setImageWithURL:[NSURL URLWithString:listmodel.cover]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
    cell.listTitlelabel.text = listmodel.rankingName;
    cell.listDeltaillable.text=listmodel.rankingDescription1;
    cell.listlastlabel.text=listmodel.rankingDescription2;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate rankingBookargValue:[_dataArray[indexPath.row] argValue] andargName:[_dataArray[indexPath.row]argName] andTitle:[_dataArray[indexPath.row]rankingName]];
//argName
}

@end
