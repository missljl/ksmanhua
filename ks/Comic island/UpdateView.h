//
//  UpdateView.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpDataDelegate <NSObject>

-(void)updataBookid:(NSString *)bookid;

@end



@interface UpdateView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak)id<UpDataDelegate>delegate;
@end
