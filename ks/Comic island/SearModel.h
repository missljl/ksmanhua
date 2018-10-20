//
//  SearModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-6.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface SearModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*bgColor;
@property (nonatomic ,copy)NSString <Optional>*search_num;
@property (nonatomic ,copy)NSString <Optional>*tag1;

@end
