//
//  ZuCeViewController.h
//  Comic island
//
//  Created by 1111 on 2017/12/8.
//  Copyright © 2017年 李金龙. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol ZuCeDelegate <NSObject>

-(void)zuceDelegate:(NSString *)ismiss;

@end

@interface ZuCeViewController : UIViewController

@property(nonatomic,assign)BOOL iszeceOrdengru;
@property(nonatomic,weak)id<ZuCeDelegate>delegate;



@end
