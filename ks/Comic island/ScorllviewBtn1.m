//
//  ScorllviewBtn.m
//  AutoHome
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ScorllviewBtn1.h"
#import "Define.h"
#import "LJLControl.h"
@implementation ScorllviewBtn
{
    
    UIScrollView *_scrollview;
    NSArray *_titleArray;
    UIButton *_btn;
    NSInteger _surrentIndex;
    NSArray *_imageArray;
    id _target;
    SEL _action;
    NSInteger _tag1;
    UIView *_diview;

}
-(id)initWithFrame:(CGRect)frame ScbgColor:(UIColor *)sccolor WithTitleArray:(NSArray *)titleNameArray WithimageName:(NSArray *)imageNameArray  target:(id)target action:(SEL)action tag:(NSInteger)tag
{

    if (self =[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _tag1=tag;
        _action = action;
        _target= target;
        _titleArray =[titleNameArray copy];
        _imageArray = [imageNameArray copy];
        [self configUI];
        
    }

    return self;

}
-(void)loadData
{
   _titleArray = @[@"汽车",@"卡车",@"面包车",@"地铁",@"火车",@"飞机",@"坦克",@"大炮",@"原子弹"];
    
}
-(void)configUI
{
    _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    _scrollview.pagingEnabled = NO;
    _scrollview.userInteractionEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.bounces = NO;
    _scrollview.backgroundColor = [UIColor whiteColor];
       _scrollview.delegate = self;
    _scrollview.tag=500;
    [self addSubview:_scrollview];
    
    
    
    
    for (NSInteger i=0; i<_titleArray.count; i++) {

      _btn = [LJLControl creatrButtonTitle:_titleArray[i] imageName:_imageArray[i]tag:_tag1+i target:_target action:_action frame:CGRectMake(0+i, 0, 0, 29)
              ];
        [_scrollview addSubview:_btn];
        if (i==0) {
            _btn.selected =YES;
           
        }
    }
    
    
    _diview  = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
    _diview.backgroundColor = [UIColor colorWithRed:0.88f green:0.88f blue:0.88f alpha:1.00f];
    [self addSubview:_diview];
    _scrollview.contentSize = CGSizeMake(87*_titleArray.count, 0);
    
   
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    _surrentIndex = _scrollview.contentOffset.y/120;
//    NSLog(@"%ld",_surrentIndex);
}
-(UIView *)congigNavgationBtnTitleNarray:(NSArray *)titleArray Wtihframe:(CGRect)frame target:(id)target action:(SEL)action tag:(NSInteger)tag
{
   
    UIView *view =[[UIView alloc]initWithFrame:frame];
  CGFloat bwitdh = frame.size.width/3;
    for (NSInteger i=0; i<titleArray.count; i++) {
        _btn = [LJLControl creatrButtonTitle:titleArray[i] imageName:@"" tag:100+i target:target action:action frame:CGRectMake((i*bwitdh), 0, bwitdh,41)];
        _btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        if (i==0) {
            _btn.selected=YES;
            _btn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        }
       
        
//        if (i==3) {
//            _btn.frame = CGRectMake(frame.size.width-65, 0, 45, 42);
//            [_btn setImage:[UIImage imageNamed:@"bar_btn_icon_search@2x"] forState:UIControlStateNormal];
//        }
        
       
        [view addSubview:_btn];
    }
//     _label = [[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height-43,bwitdh,3)];
//    _label.backgroundColor = TITLE_COLOR;
//    [view addSubview:_label];
    return view;

}
@end
