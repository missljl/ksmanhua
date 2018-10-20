//
//  Rankingview.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RankingDelegate <NSObject>

-(void)rankingBookargValue:(NSString *)value andargName:(NSString *)name andTitle:(NSString *)title;

@end


@interface Rankingview : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)id<RankingDelegate>delegate;
@end
