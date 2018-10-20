//
//  SearModel.m
//  Comic island
//
//  Created by qianfeng on 15-11-6.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "SearModel.h"

@implementation SearModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"tag":@"tag1"}];
}
@end
