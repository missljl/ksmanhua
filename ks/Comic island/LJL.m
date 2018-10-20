//
//  LJL.m
//  9.16作业(结合)
//
//  Created by qianfeng on 15-9-16.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//

#import "LJL.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
#define WITDH self.frame.size.width
#define HTGHT self.frame.size.height
#import "RecommendHeaderModel.h"
#import "Define.h"
@implementation LJL
{
    UIImageView *_leftView;
    UIImageView *_centerView;
   UIImageView *_rigView;
    NSArray *_DataArray;
    UIScrollView *_scrView;
    NSInteger _contindex;
    NSTimer *_timer;
    UIPageControl *_pageC;
    UILabel *_label;
    RecommendHeaderModel *model;
    NSArray *_ImageArray;

}
-(id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _DataArray =[array copy];
         [self configUI];
    }
    return self;
}
-(void)configUI
{
    _scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WITDH, HTGHT)];
    _scrView.showsHorizontalScrollIndicator =NO;
    _scrView.showsVerticalScrollIndicator = NO;
    _scrView.pagingEnabled = YES;
    _scrView.delegate =self;
    _scrView.bounces =NO;
    [self addSubview:_scrView];
    //
    if (_DataArray.count>1) {
      
             _contindex=0;
        _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WITDH, HTGHT)];
            model = [_DataArray lastObject];
        
           _leftView.tag=100;
            [_leftView sd_setImageWithURL:[NSURL URLWithString:model.imagename]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];

        [_scrView addSubview:_leftView];
     
        _centerView = [[UIImageView alloc]initWithFrame:CGRectMake(WITDH, 0, WITDH, HTGHT)];
        _centerView.userInteractionEnabled = YES;
      _centerView.tag=101;
            model=[_DataArray firstObject];
        [_centerView sd_setImageWithURL:[NSURL URLWithString:model.imagename]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick:)];
        [_centerView addGestureRecognizer:tap];
        [_scrView addSubview:_centerView];
        _centerView.userInteractionEnabled = YES;
       
        
        //
        _rigView = [[UIImageView alloc] initWithFrame:CGRectMake(WITDH*2, 0, WITDH, HTGHT)];
        _rigView.tag=102;
            model=_DataArray[(_contindex+1)%_DataArray.count];
        _rigView.userInteractionEnabled = YES;
            [_rigView sd_setImageWithURL:[NSURL URLWithString:model.imagename]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
      
       
        [_scrView addSubview:_rigView];
        
        _scrView.contentOffset =CGPointMake(WITDH, 0);
        _scrView.contentSize =CGSizeMake(3*WITDH, HTGHT);
        
        _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(100, HTGHT-30,WITDH , 30)];
        _pageC.numberOfPages = _DataArray.count;
        _pageC.currentPage = _contindex;
        [self addSubview:_pageC];
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeOn) userInfo:nil repeats:NO];
    }
    
}
-(void)btnClick:(UITapGestureRecognizer *)tap
{
    RecommendHeaderModel *model = _DataArray[_contindex];
    [self.delegate ljlcomid:model.comid];
    
    
    
      
    
    
  

}
-(void)timeOn
{
    [UIView animateWithDuration:0.5 animations:^{
        _scrView.contentOffset =CGPointMake(_scrView.contentOffset.x+WITDH, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:_scrView];
    }];
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //如果认为的停止动画,或者认为的停止的动画,就要在调用一下动画的方法
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeOn) userInfo:nil repeats:NO];
    
   
    if (scrollView.contentOffset.x==2*WITDH) {
        scrollView.contentOffset =CGPointMake(WITDH, 0);
        _contindex= (_contindex+1)%_DataArray.count;
        model = _DataArray[(_contindex-1+_DataArray.count)%_DataArray.count];
        [_leftView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];

        model=_DataArray[_contindex];
        [_centerView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];

        
        model = _DataArray[(_contindex+1)%_DataArray.count];
        [_rigView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];

    }else if (scrollView.contentOffset.x==0){
        scrollView.contentOffset = CGPointMake(WITDH, 0);
        
        _contindex =(_contindex-1+_DataArray.count)%_DataArray.count;
        
        model=_DataArray[(_contindex-1+_DataArray.count)%_DataArray.count];
        [_leftView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];

        model = _DataArray[_contindex];
        [_centerView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];
        
        model =_DataArray[(_contindex+1)%_DataArray.count];
        [_rigView sd_setImageWithURL:[NSURL URLWithString:model.imagename]];
    }
    
  

      _pageC.currentPage = _contindex;

    
}

@end
