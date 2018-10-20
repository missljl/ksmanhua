//
//  AppDelegate.h
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "MyTabViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property(strong,nonatomic) MyTabViewController *tabvc;

@end

