//
//  BookcaseViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-2.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//书架界面
#import "BookcaseViewController.h"
#import "LJLControl.h"

#import "DetailsViewController.h"


#import "CollectionModel.h"
#import "DBManager.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#import "FavoriteManager.h"
#import"Masonry.h"

#import "ShoucangViewCell.h"
#import "DetailModel.h"

#import "FenLeiViewController.h"

#import "ReadviewController.h"

#import "YDJlManager.h"


#import "DengLuViewController.h"
#import <BmobSDK/Bmob.h>

@interface BookcaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
        UICollectionViewFlowLayout *flowlayout;
    
        NSMutableArray *_dataArray;
        UICollectionView *collectionview;
    //提示view
        UIView *tiview;
        UIButton *righttopbtn;
    //继续阅读view
    UIView *jiyueduview;
    UILabel *bookname;
    UILabel *bookzhang;
    NSString *bookid;
    NSString *bookzhangjieid;
    NSMutableArray *jixuyueArray;
    
    //是否登入显示不同的字
    UILabel *labeltext;
    UIButton *btnstr;
    
    
}
@end

@implementation BookcaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    jixuyueArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
      self.automaticallyAdjustsScrollViewInsets = NO;
    //tishiview无数据时
   
//    //数据
//    [self prepareData];
    //初始化collectionview
    [self uiConfig];
    //初始化编辑按钮
    [self uiConfigrightBaritem];
    
    [self configTiview];
    
    //数据
    [self prepareData];
    //继续阅读空间初始化
    [self jixuyueview];
    //继续阅读空间数据赋值
    [self jixuyueduData];
//    [self uiConfigrightBaritem];
    //舒适化控件collectionview
  

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction1) name:@"changed" object:nil];
}
-(void)notAction1{
    [self prepareData];
  
}
-(void)prepareData
{

    _dataArray = [[FavoriteManager manager]allModels];
    if (_dataArray.count==0) {
        tiview.hidden = NO;
        collectionview.hidden = YES;
        righttopbtn.hidden = YES;
    }else{
        tiview.hidden = YES;
        collectionview.hidden = NO;
           righttopbtn.hidden = NO;
    for ( DetailModel *model in _dataArray) {
          model.isbtnheid = @"1";
    }
    [collectionview reloadData];
    }
}
#pragma mark右边编辑按钮初始化
-(void)uiConfigrightBaritem{
    
    righttopbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    righttopbtn.frame = CGRectMake(0, 0, 44, 44);
  
        [righttopbtn setTitle:@"编辑" forState:UIControlStateNormal];
        [righttopbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [righttopbtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        righttopbtn.titleLabel.font = [UIFont systemFontOfSize:16];
  
      UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:righttopbtn];
    
    [righttopbtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = BarItme;


    
}
#pragma mark--collectionview初始化
-(void)uiConfig
{
    
    flowlayout=[[UICollectionViewFlowLayout alloc] init];
    
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;//这2个都是流
    flowlayout.minimumLineSpacing =5;
    collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-98) collectionViewLayout:flowlayout];
    
    collectionview.dataSource = self;
    collectionview.delegate = self;
    collectionview.showsVerticalScrollIndicator = NO;
    collectionview.showsHorizontalScrollIndicator = NO;
    collectionview.backgroundColor = [UIColor whiteColor];
   [collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([ShoucangViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"shoucangcell"];
    [self.view addSubview:collectionview];

    
    
}
#pragma mark collectionview代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoucangViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shoucangcell" forIndexPath:indexPath];

    DetailModel *model =_dataArray[indexPath.row];
    [cell.bookimageview sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    cell.booklabel.text =model.name;
    
    if ([model.isbtnheid isEqual:@"1"]) {
       cell.deletabtn.hidden = YES;
    }else{
        cell.deletabtn.hidden = NO;

    }
    cell.deletabtn.tag = 100+indexPath.row;
    [cell.deletabtn addTarget:self action:@selector(deletabtn:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    return cell;
   
}

#pragma mark ----  点击item的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detalvc = [[DetailsViewController alloc]init];
    DetailModel *model = _dataArray[indexPath.row];
    detalvc.com_id1 =model.comic_id;
    detalvc.title = model.name;
    [self.navigationController pushViewController:detalvc animated:YES];
 
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
#pragma mark cell删除按钮点击事件
-(void)deletabtn:(UIButton *)btn{
    
   
    NSInteger index = btn.tag - 100;
      DetailModel *model =_dataArray[index];
    [[FavoriteManager manager]deleteModel:model];
    [_dataArray removeObject:model];


   [collectionview deselectItemAtIndexPath:[NSIndexPath indexPathWithIndex:index] animated:YES];
  
    [collectionview reloadData];
    
    NSInteger mangercount = [[FavoriteManager manager]allModels].count;
    if (mangercount ==0) {
            tiview.hidden = NO;
            collectionview.hidden = YES;
            righttopbtn.hidden = YES;
    }else{
        
        tiview.hidden = YES;
        collectionview.hidden = NO;
        righttopbtn.hidden = NO;
    }
    
}
#pragma mark编辑按钮点击事件
-(void)rightClick:(UIButton *)rightbtn{
    
   
    if (rightbtn.selected==YES) {
       
    for (DetailModel *model in _dataArray) {
        model.isbtnheid = @"1";
        }
        [rightbtn setTitle:@"编辑" forState:UIControlStateNormal];
        rightbtn.selected = NO;
       
       
    }else{
        [rightbtn setTitle:@"完成" forState:UIControlStateNormal];
        rightbtn.selected = YES;
        for (DetailModel *model in _dataArray) {
            model.isbtnheid = @"0";
        }
    }
    [collectionview reloadData];
}
#pragma mark当数据库没有数据时_dataarray的个数为0时的提示view
-(void)configTiview{
  
    
    tiview = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height/2-25, self.view.frame.size.width,50)];
   
    labeltext= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
//   labeltext.text  = labeltext;
     labeltext.textColor = [UIColor lightGrayColor];
    labeltext.font = [UIFont systemFontOfSize:16];
   labeltext.textAlignment = NSTextAlignmentCenter;
    [tiview addSubview: labeltext];
    btnstr = [[UIButton alloc]initWithFrame:CGRectMake(tiview.frame.size.width/2-40,25, 80, 25)];
    [btnstr setTitle:@"" forState:UIControlStateNormal];
   btnstr.layer.borderColor = [UIColor orangeColor].CGColor;
   btnstr.layer.borderWidth = 1.5;
   btnstr.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnstr setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btnstr.layer.cornerRadius=3.0;
   btnstr.layer.masksToBounds = YES;
    [btnstr addTarget:self action:@selector(fenbtn) forControlEvents:UIControlEventTouchUpInside];
    [tiview addSubview:btnstr];
    [self.view addSubview:tiview];
    
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        labeltext.text = @"不毛之地(｡•ˇ‸ˇ•｡),快去排行看看吧~~";
          [btnstr setTitle:@"->去排行" forState:UIControlStateNormal];
    }else{
       [btnstr setTitle:@"->去登录" forState:UIControlStateNormal];
        labeltext.text = @"还没登录呢(｡•ˇ‸ˇ•｡),快去登录吧~~~";
    }
    
    
    
}
//去排行榜界面
-(void)fenbtn{
       BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        FenLeiViewController *fen = [[FenLeiViewController alloc]init];
        fen.bookId = @"23";
        fen.argName = @"sort";
        fen.title = @"月票排行榜";
        [self.navigationController pushViewController:fen animated:YES];
    }else{
        DengLuViewController *dvc = [[DengLuViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
        dvc.modalTransitionStyle =0;
        [self presentViewController:nav animated:YES completion:nil];
    }
  
   
    
}
#pragma mark继续阅读空间初始化
-(void)jixuyueview{
    
    jiyueduview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-98, self.view.frame.size.width, 49)];
//    jiyueduview.backgroundColor = [UIColor redColor];
    [self.view addSubview:jiyueduview];
    jiyueduview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    jiyueduview.layer.borderWidth = 1.0f;
    
    bookname = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, jiyueduview.frame.size.width/3-10, 49)];
    bookname.text = @"";
    bookname.textColor = [UIColor orangeColor];
    bookname.font = [UIFont systemFontOfSize:16];
    [jiyueduview addSubview:bookname];
    bookzhang = [[UILabel alloc]initWithFrame:CGRectMake(bookname.frame.size.width, 0, jiyueduview.frame.size.width/3, 49)];
    bookzhang.text = @"";
    bookzhang.textColor = [UIColor lightGrayColor];
    bookzhang.font = [UIFont systemFontOfSize:14];
    bookzhang.textAlignment =NSTextAlignmentCenter;
    [jiyueduview addSubview:bookzhang];
    
    UIButton *jibtn = [[UIButton alloc]initWithFrame:CGRectMake(jiyueduview.frame.size.width-72,12, 60, 25)];
    [jibtn setTitle:@"继续阅读" forState:UIControlStateNormal];
    [jibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jibtn setBackgroundImage:[UIImage imageNamed:@"changeUserNameSelect@2x"] forState:UIControlStateNormal];
    jibtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [jibtn addTarget:self action:@selector(yuebtnonclick) forControlEvents:UIControlEventTouchUpInside];
    [jiyueduview addSubview:jibtn];
    
}
//填充数据
-(void)jixuyueduData{
    

    
    jixuyueArray = [[YDJlManager ydjlManager]allModels];
    if (jixuyueArray.count==0) {
        
        jiyueduview.hidden = YES;
        
    }else{
    DetailModel *model = jixuyueArray.lastObject;
    bookname.text = [NSString stringWithFormat:@"<%@>",model.name];
    bookzhang.text = model.author_name;
    bookid = model.comic_id;
        bookzhangjieid = model.cover;
        
        
    }
    
}

#pragma mark继续阅读按钮点击事件
-(void)yuebtnonclick{
  

    DetailsViewController *detalvc = [[DetailsViewController alloc]init];

    detalvc.com_id1 =bookid;
    detalvc.title = bookname.text;
    [self.navigationController pushViewController:detalvc animated:YES];

    
}

//收听登入完成通知来显示不同的字
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction) name:@"mydengru" object:nil];
}
-(void)notAction{
    
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        labeltext.text = @"不毛之地(｡•ˇ‸ˇ•｡),快去排行看看吧~~";
        [btnstr setTitle:@"->去排行" forState:UIControlStateNormal];
    }else{
        [btnstr setTitle:@"->去登录" forState:UIControlStateNormal];
        labeltext.text = @"还没登录呢(｡•ˇ‸ˇ•｡),快去登录吧~~~";
    }
    
}




@end
