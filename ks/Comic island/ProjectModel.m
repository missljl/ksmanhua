//
//  ProjectModel.m
//  Comic island
//
//  Created by qianfeng on 15-11-6.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"id1",@"tag":@"tag1",@"title":@"title1"}];
}




@end
