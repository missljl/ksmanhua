//
//  MyUser.h
//  Comic island
//
//  Created by 1111 on 2017/12/11.
//  Copyright © 2017年 李金龙. All rights reserved.
//

//#import <BmobSDK/BmobSDK.h>
#import <BmobSDK/Bmob.h>
@interface MyUser : BmobUser

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *imagenae;

@end
