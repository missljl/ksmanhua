//
//  LJLControl.m
//  9.28爱限免1
//
//  Created by qianfeng on 15-9-29.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//

#import "LJLControl.h"
#import "Define.h"
@implementation LJLControl

+(UIButton *)creatrButtonTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag target:(id)target action:(SEL)action frame:(CGRect)frame
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
   // button.backgroundColor = [UIColor whiteColor];
   [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
  [button setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
//    [button setTitleColor:[UIColor colorWithRed:0.33f green:0.56f blue:0.84f alpha:1.00f] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
   
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    return button;
}
+(UILabel *)creatrLabelText:(NSString *)text font:(UIFont *)font frame:(CGRect)frame
{
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.text = text;
    lab.font = font;
    lab.textColor = [UIColor blackColor];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    return lab;
    
}
+(UIImageView *)createImageViewimage:(NSString *)imageName frame:(CGRect)frame
{

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:frame];
    if (imageName.length>0) {
        imageview.image = [UIImage imageNamed:imageName];
    }
    
    return imageview;
}
@end
