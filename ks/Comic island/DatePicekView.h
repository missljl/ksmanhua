//
//  DatePicekView.h
//  Comic island
//
//  Created by 1111 on 2017/12/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePicekView : UIView
@property (nonatomic, copy) void(^GetSelectDate)(NSString *dateStr);
@property (nonatomic, strong) NSString * selectDate;
-(void)show;
@end
