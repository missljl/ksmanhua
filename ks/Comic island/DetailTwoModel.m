//
//  DetailTwoModel.m
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "DetailTwoModel.h"

@implementation DetailTwoModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"name":@"name1"}];
}
@end
