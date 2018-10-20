//
//  LasetView.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LsatDelegate <NSObject>

-(void)sendLastid:(NSString *)bookId andargName:(NSString*)argName addTitle:(NSString *)title;

@end



@interface LasetView : UIView

@property (nonatomic,strong)UIImageView *lastimageview;
@property(nonatomic,weak)id<LsatDelegate>delgate;
-(instancetype)initWithFrame:(CGRect)frame  withImageArray:(NSArray *)imageviewArray;

@end
