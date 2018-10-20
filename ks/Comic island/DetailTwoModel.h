//
//  DetailTwoModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface DetailTwoModel : JSONModel

@property (nonatomic ,copy)NSString *buyed;

@property (nonatomic ,copy)NSString <Optional>*chapter_id;
@property (nonatomic ,copy)NSString <Optional>*image_total;
@property (nonatomic ,copy)NSString <Optional>*is_free;
@property (nonatomic ,copy)NSString <Optional>*is_view;
@property (nonatomic ,copy)NSString <Optional>*name1;
@property (nonatomic ,copy)NSString <Optional>*pass_time;
@property (nonatomic ,copy)NSString <Optional>*price;
@property (nonatomic ,copy)NSString <Optional>*read_state;
@property (nonatomic ,copy)NSString <Optional>*release_time;
@property (nonatomic ,copy)NSString <Optional>*size;
@property (nonatomic ,copy)NSString <Optional>*type;
@end
