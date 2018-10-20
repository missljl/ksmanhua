//
//  SearchTwoViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-7.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//搜索界面
#import "SearchTwoViewController.h"
#import "Define.h"
#import "UpDataModel.h"
#import "UpDataCellTableViewCell.h"
#import "HttpManager.h"
#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "DetailsViewController.h"
@interface SearchTwoViewController ()<LJLSeachbarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    LJLSeachbar *_search;

    UITableView *_tableview;
    NSMutableArray *_dataArray;
   
}
@end

@implementation SearchTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    
    
    
    [self popbtn];
    [self congfigSearCh];
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    if (_Str1.length>0) {
        NSString *encodeString = [_Str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _str=encodeString;
        [self loadData];
        [self configUI];
    }
    
    
}
-(void)configUI
{
    CGFloat iswithd;
    CGFloat isheght;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=140;
        isheght=64;
    }else{
        iswithd=120;
        isheght=49;
    }
    
    
_tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, iswithd, self.view.frame.size.width , self.view.frame.size.height-isheght-iswithd) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource= self;
    
    [self.view addSubview:_tableview];
    
[_tableview registerNib:[UINib nibWithNibName:@"UpDataCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"updatacell"];
    
}
-(void)loadData
{
    
    NSString *str =@"%205";
    NSString *Str = [NSString stringWithFormat:@"http://app.u17.com/v3/app/ios/phone/search/rslist?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%@s&time=1446786979&q=%@&page=1&",str,_str];
    
    [[HttpManager shareManager]requestWithUrl:Str withDictionary:nil withSuccessBlock:^(id responseObject) {
     
       NSDictionary *dic1 = responseObject[@"data"];
        NSDictionary *dic2 = dic1[@"returnData"];
      NSArray *dataArray =dic2[@"comicList"];
        for (NSDictionary *dic3 in dataArray) {
            
            UpDataModel *model = [[UpDataModel alloc]initWithDictionary:dic3 error:nil];
            [_dataArray addObject:model];

        }
        [_tableview reloadData];
    } withFailureBlock:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
    [_dataArray removeAllObjects];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"updatacell";
    UpDataCellTableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
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
    
      cell.updatagenxindaoLable.text = updatamodel.last_update_chapter_name;
    return cell;
}
-(void)congfigSearCh
{
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=88;
        
    }else{
        iswithd=64;
        
    }
    
    
    
   _search = [[LJLSeachbar alloc]initWithFrame:CGRectMake(0, iswithd, SCREEN_WIDTH, 544) placeholder:@"100万部小说收索看" delegate:self];
//    [_search showInView:self.view];
    [self.view addSubview:_search];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detail = [[DetailsViewController alloc]init];
    detail.com_id1 = [_dataArray[indexPath.row] comic_id];
    detail.title = @"漫画介绍";
    [self.navigationController pushViewController:detail animated:YES];
}
//代理
-(void)searchWithKey:(NSString *)key
{
//    NSLog(@"%@",key);
 
  NSString *encodeString = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      _str=encodeString;
    [self configUI];
    [self loadData];
   
}
-(void)popbtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
  
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:btn];

        [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =BarItme;
    
}
-(void)leftClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
