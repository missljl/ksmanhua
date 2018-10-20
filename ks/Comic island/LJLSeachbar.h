//
//  LJLSeachbar.h
//  9.28爱限免1
//
//  Created by qianfeng on 15-9-29.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//
//这个是收索其实就是一view的封装
#import <UIKit/UIKit.h>

@protocol LJLSeachbarDelegate <NSObject>

-(void)searchWithKey:(NSString *)key;

@end



@interface LJLSeachbar : UIView<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>


-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id<LJLSeachbarDelegate>)delegate;


-(void)showInView;


@end
