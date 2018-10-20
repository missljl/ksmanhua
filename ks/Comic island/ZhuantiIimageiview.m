//
//  ZhuantiIimageiview.m
//  Comic island
//
//  Created by 1111 on 2017/12/4.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "ZhuantiIimageiview.h"

@implementation ZhuantiIimageiview

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super initWithCoder:aDecoder]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
//    UIRectCornerTopLeft     = 1 << 0,
//    UIRectCornerTopRight    = 1 << 1,
//    UIRectCornerBottomLeft  = 1 << 2,
//    UIRectCornerBottomRight = 1 << 3,
    
//    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
//    
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    //设置大小
//    maskLayer.frame = self.bounds;
//    //设置图形样子
//    maskLayer.path = maskPath1.CGPath;
//
// 
//    self.layer.mask = maskLayer;
  
    
}
@end
