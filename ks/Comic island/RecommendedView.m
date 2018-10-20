//
//  RecommendedView.m
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//


#define  BOOKWITDH ([UIScreen mainScreen].bounds.size.width-40)/3

#define CELLHEIGHT (BOOKWITDH*1.5)*2+50


#import "RecommendedView.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "HttpManager.h"
#import "RecommendHeaderModel.h"
#import "RecommendModel.h"
#import "RecommendModelLastModel.h"
//#import "HeaderCell.h"
#import "TableViewCell.h"
//#import "BooksCell.h"
#import "LastCell.h"
//#import "LasetView.h"
#import "CacheManager.h"
#import "MJRefresh.h"

@interface RecommendedView ()
@property(nonatomic,strong)LasetView *lastview;
@end
@implementation RecommendedView
{
    NSMutableArray *_headArray;
    NSMutableArray *_lastArray;
    TableViewCell *cell;
    NSMutableArray *_dataArray;
    
    UITableView *_tableview;
    
    NSString *strid;
    NSString *strName;
    NSString *title1;
    
    NSInteger _page;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        _headArray = [[NSMutableArray alloc]init];
        _lastArray = [[NSMutableArray alloc]init];
        _dataArray = [[NSMutableArray alloc]init];
        [self conifgUI];
      
       
        
    }
    return self;
}



-(void)loadData
{
    [[HttpManager shareManager]requestWithUrl:URL_RECOMM withDictionary:nil withSuccessBlock:^(id responseObject) {
     
        
        [_tableview.mj_header endRefreshing];

        if (_page==1) {
            [_dataArray removeAllObjects];
            [_headArray removeAllObjects];
            [_lastArray removeAllObjects];
        }
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dic1=dic[@"data"];
        NSDictionary *ReturnDatadic = dic1[@"returnData"];
        NSArray *dataListArray = ReturnDatadic[@"dataList"];
        
        for (NSDictionary *dic2 in dataListArray) {
            if (dic2==dataListArray.firstObject ) {
//                NSLog(@"我是第一个元素");
                NSBundle *bundle = [NSBundle mainBundle];
                NSString *path  = [bundle pathForResource:@"headerplist" ofType:@"plist"];
                
                NSArray *ar = [NSArray arrayWithContentsOfFile:path];
                for (NSDictionary *dic10 in ar) {
                    RecommendHeaderModel *headModel = [[RecommendHeaderModel alloc]initWithDictionary:dic10 error:nil];
                    [_headArray addObject:headModel];
                }

            }
            else  if (dic2==dataListArray.lastObject){
                NSBundle *bundle = [NSBundle mainBundle];
                NSString *path  = [bundle pathForResource:@"last" ofType:@"plist"];
                NSArray *lastarray = [NSArray arrayWithContentsOfFile:path];
                for (NSDictionary *lastdic in lastarray) {
                    RecommendModelLastModel *lastmodel = [[RecommendModelLastModel alloc]initWithDictionary:lastdic error:nil];
                    [_lastArray addObject:lastmodel];

                  _lastview = [[LasetView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,SCREEN_WIDTH-100) withImageArray:_lastArray];
                   
                     _tableview.tableFooterView = _lastview;
                     _lastview.delgate = self;
                    _tableview.tableFooterView.userInteractionEnabled = YES;
                    
                }

            }else{
                
                RecommendModel *centerModel = [[RecommendModel alloc] initWithDictionary:dic2 error:nil];
                [_dataArray addObject:centerModel];
            }
        }

        [_tableview reloadData];
    } withFailureBlock:^(NSError *error) {

            [_tableview.mj_header endRefreshing];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络死掉了？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [self addSubview:alert];
        [alert show];
    }];
    
    
    
}


#pragma mark---tableview
-(void)conifgUI
{ 
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;

    [self addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[HeaderCell class] forCellReuseIdentifier:@"headercell"];
    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"bookcell"];
   
    [self addRefreshHeader:YES andHaveFooter:NO];
    

}
#pragma mark - 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count+1;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        HeaderCell *cell1 = [_tableview  dequeueReusableCellWithIdentifier:@"headercell" forIndexPath:indexPath];
        [cell1 fiel:[_headArray copy]];
        cell1.delegate = self;
        return cell1;
    }
    if(indexPath.row>0){
        static NSString *cellId = @"bookcell";
        cell = [_tableview dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        
        RecommendModel *model = _dataArray[indexPath.row-1];
        cell.booklevelTitle.text = model.titleWithIcon;
        [cell.bookimageview sd_setImageWithURL:[NSURL URLWithString:model.titleIconUrl]];

        
        cell.BOOKView.booksArray = model.comicListItems;
        cell.BOOKView.delegate = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtn)];
        cell.booView.userInteractionEnabled = YES;
        [cell.booView addGestureRecognizer:tap];
        
        cell.genduobtn.tag = 1000+indexPath.row-1;
        [cell.genduobtn addTarget:self action:@selector(genduobtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        strName = [_dataArray[indexPath.row-1]argValue];
        strid = [_dataArray[indexPath.row-1]argName];
        title1 = [_dataArray[indexPath.row-1]titleWithIcon];
        
        return cell;
    }
    return nil;
    
}
//更多按钮点极事件
-(void)genduobtn:(UIButton *)btn{
    
    RecommendModel *model = _dataArray[btn.tag-1000];
    [self.delegate RecommendGenduobtnArgName:model.argName andArgValue:model.argValue andtitle:model.title];
    
}
//书的点击事件
-(void)tapBtn
{
 [self.delegate  RencommendedlastviewId:strName RenconmmendedargName:strid RencommendedTitle:@"更多漫画"];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row>0) {
       
        return CELLHEIGHT;
    }else{
        return SCREEN_WIDTH-100;
    }
}




//底部代理
-(void)sendLastid:(NSString *)bookId andargName:(NSString *)argName addTitle:(NSString *)title
{
    [self.delegate RencommendedlastviewId:bookId RenconmmendedargName:argName RencommendedTitle:title];

}

//数
-(void)booksId:(NSString *)bookid
{
    [self.delegate RecommendBooksName:nil recommendBooksId:bookid];

}
//头不
-(void)headerCom_id:(NSString *)comid
{
    [self.delegate RecommendBooksName:nil recommendBooksId:comid];

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

        
        
    }
    
}
-(void)reloadData
{
    [_tableview.mj_header endRefreshing];
    _page=1;
    [self loadData];
}


@end
