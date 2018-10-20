//
//  LJLControl.h
//  9.28爱限免1
//
//  Created by qianfeng on 15-9-29.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//
//这个是(小)控件封装3个方法分别是label,imageview,button..类方法调用
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LJLControl : NSObject


+(UIButton *)creatrButtonTitle:(NSString *)title imageName:(NSString *)imageName tag:(NSInteger)tag target:(id)target action:(SEL)action frame:(CGRect)frame;


+(UILabel *)creatrLabelText:(NSString *)text font:(UIFont *)font frame:(CGRect)frame;

+(UIImageView *)createImageViewimage:(NSString *)imageName frame:(CGRect)frame;


@end
