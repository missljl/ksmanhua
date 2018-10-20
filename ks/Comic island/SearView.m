//
//  SearView.m
//  Comic island
//
//  Created by qianfeng on 15-11-7.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "SearView.h"

@implementation SearView

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self configUI];
    }
    return self;
}
-(void)configUI
{
    
//    UIImageView *leftVc = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    leftVc.image = [UIImage imageNamed:@""];
//    [self addSubview:leftVc];
    
    
    UIView *centVC= [[UIView alloc]initWithFrame:CGRectMake(12, 0, self.frame.size.width-90, 30)];
    centVC.layer.borderWidth = 0.5;
    centVC.layer.borderColor = [UIColor grayColor].CGColor;
    centVC.layer.cornerRadius = 2;
    centVC.layer.masksToBounds = YES;
    [self addSubview:centVC];

    
    UIImageView *rigVC = [[UIImageView alloc]initWithFrame:CGRectMake(centVC.frame.origin.x+centVC.frame.size.width+10, 0, 60, 30)];
    rigVC.image = [UIImage imageNamed:@"searchVCsearchBtn"];
    [self addSubview:rigVC];
    

}
@end
