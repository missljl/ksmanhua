//
//  CollectionModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface CollectionModel : JSONModel

@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *cover;
@property (nonatomic ,copy)NSString *comic_id;
@property(nonatomic,copy) NSString *isdetebtnhieden;
@end
