//
//  HeaderCell.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJL.h"

@protocol headerDelegate <NSObject>

-(void)headerCom_id:(NSString *)comid;

@end

@interface HeaderCell : UITableViewCell<LJLDelegate>
@property (nonatomic,weak)id<headerDelegate>delegate;
-(void)fiel:(NSArray *)array;


@end
