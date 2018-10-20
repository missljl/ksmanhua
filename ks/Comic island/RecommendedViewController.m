//
//  RecommendedViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-2.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//



//首页主界面

#import "RecommendedViewController.h"

#import "RecommendedView.h"
#import "Rankingview.h"
#import "ScorllviewBtn1.h"
#import "UpdateView.h"

#import "FenLeiViewController.h"
#import "DetailsViewController.h"
#import "SearchTwoViewController.h"
@interface RecommendedViewController ()<RecommendedDelegate,UpDataDelegate,RankingDelegate>
{

    UIView *_yeview;
   CGFloat iswithd;
    
}
@property(nonatomic,strong)RecommendedView *RecommView;
@property(nonatomic,strong)UpdateView *UpdataView;
@property(nonatomic,strong)Rankingview *RankingView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *NavBtnsview;
@end

@implementation RecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
  
    if (kDevice_Is_iPhoneX){
        iswithd=64;
        
    }else{
        iswithd=49;
        
    }
    

    
    [self inits];
    
    
    //导航左右按钮
    [self addleftandrightbtn];
    
   
    

}
-(void)inits
{
      self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"推荐";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = self.NavBtnsview;
    
    [self.view addSubview:self.scrollView];
  
}
#pragma navitems
-(UIView*)NavBtnsview{
   NSArray *ar = @[@"精品",@"排行",@"更新"];
    
    if (!_NavBtnsview) {
        _NavBtnsview = [[ScorllviewBtn alloc]congigNavgationBtnTitleNarray:ar Wtihframe:
                 CGRectMake(0, 0,self.view.frame.size.width-130, 44) target:self action:@selector(navigatitems:) tag:100];
        CGFloat bwitdh = _NavBtnsview.frame.size.width/3;
        _yeview = [[UILabel alloc]initWithFrame:CGRectMake(bwitdh/3,41,bwitdh/3,2)];
        _yeview.backgroundColor = TITLE_COLOR;
        [_NavBtnsview addSubview:_yeview];
        
    }
    
    return _NavBtnsview;
}

#pragma mark--sc
-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
       _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-iswithd)];
        _scrollView.tag =700;
       _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-64-iswithd);
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces =NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator =YES;
        _scrollView.showsHorizontalScrollIndicator=YES;
        
        //层级
        [_scrollView addSubview:self.RecommView];
        [_scrollView addSubview:self.RankingView];
        [_scrollView addSubview:self.UpdataView];
       
    }
    return _scrollView;
    
}

-(RecommendedView *)RecommView{
    
    if (!_RecommView) {
        _RecommView =[[RecommendedView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.scrollView.frame.size.height-iswithd)];
        _RecommView.delegate = self;

    }
    return _RecommView;
}
-(Rankingview *)RankingView{
    
    if (!_RankingView) {
        _RankingView =[[Rankingview alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width,self.scrollView.frame.size.height-iswithd)];
        _RankingView.delegate = self;
     
    }
    return _RankingView;
}
-(UpdateView *)UpdataView{
    if (!_UpdataView) {
        _UpdataView =[[UpdateView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width,self.scrollView.frame.size.height-iswithd)];
        _UpdataView.delegate = self;
       
    }
    return _UpdataView;
    
}



#pragma mark-----导航栏上面3个按钮点击事件
-(void)navigatitems:(UIButton *)btn
{
  
        
   

    [UIView animateWithDuration:0.25 animations:^{
        
        _yeview.center =CGPointMake(btn.center.x, _yeview.center.y);
        self.scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(btn.tag-100), 0);
        [self btnFontSelectedbtn:btn];
    }];
    
    
    
    
    
}
#pragma mark-----scrollviewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    NSInteger index = scrollView.contentOffset.x/self.view.frame.size.width;
    UIButton *btn;
  
   
    btn = (UIButton *)[self.NavBtnsview viewWithTag:index+100];
   
    [UIView animateWithDuration:0.18 animations:^{

        _yeview.center =CGPointMake(btn.center.x, _yeview.center.y);
      [self btnFontSelectedbtn:btn];
    }];
   
  

    
}
#pragma mark----公共私有方法
-(void)btnFontSelectedbtn:(UIButton *)btn{
    
    for (UIButton *NOselectbtn in self.NavBtnsview.subviews) {
        if ([NOselectbtn isKindOfClass:[UIButton class]]) {
            NOselectbtn.selected = NO;
            NOselectbtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        }
      
    }
 
     btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
      btn.selected=YES;
}

#pragma mark-----------------Delegate精品和排行还有更新回调
//首页代理(最后几张图代理)
-(void)RencommendedlastviewId:(NSString *)bookId RenconmmendedargName:(NSString *)argName RencommendedTitle:(NSString *)title
{
    FenLeiViewController *fen = [[FenLeiViewController alloc]init];
    fen.bookId = bookId;
    fen.argName = title;
    fen.title = argName;
    [self.navigationController pushViewController:fen animated:YES];
}
//漫画书代理
-(void)RecommendBooksName:(NSString *)name recommendBooksId:(NSString *)nameId
{
    DetailsViewController *detali = [[DetailsViewController alloc]init];
    detali.title = @"漫画介绍";
    detali.com_id1=nameId;
    [self.navigationController pushViewController:detali animated:YES];
}
//跟多按妞代理
-(void)RecommendGenduobtnArgName:(NSString *)argname andArgValue:(NSString *)argvalue andtitle:(NSString *)fenlietitle{
    
    FenLeiViewController *fenVC = [[FenLeiViewController alloc]init];
    fenVC.title =fenlietitle;
    fenVC.bookId = argvalue;
    fenVC.argName = argname;
    [self.navigationController pushViewController:fenVC animated:YES];
    
    
}

//跟新代理
-(void)updataBookid:(NSString *)bookid
{
    DetailsViewController *delti = [[DetailsViewController alloc]init];
    delti.com_id1 =bookid;
    delti.title = @"漫画介绍";
    [self.navigationController pushViewController:delti animated:YES];
}
//排行
-(void)rankingBookargValue:(NSString *)value andargName:(NSString *)name andTitle:(NSString *)title
{
    

    FenLeiViewController *fen = [[FenLeiViewController alloc]init];
    fen.bookId = value;
    fen.argName = name;
    fen.title = title;
    [self.navigationController pushViewController:fen animated:YES];
}

@end
