//
//  LJL.h
//  9.16作业(结合)
//
//  Created by qianfeng on 15-9-16.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJLDelegate <NSObject>

-(void)ljlcomid:(NSString *)com_id;

@end



@interface LJL : UIView <UIScrollViewDelegate>
//这个是暴露在外面的借口用来接受数据的..接受的是secll中的数据也就是就收的是root中的imageview的数据
-(id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array;

@property(nonatomic,weak)id<LJLDelegate>delegate;

@end
