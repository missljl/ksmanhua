//
//  DetailModel.m
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"description1"}];
}




@end
