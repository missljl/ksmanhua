//
//  ReadModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface ReadModel : JSONModel
@property (nonatomic ,copy)NSString <Optional>*height;
@property (nonatomic ,copy)NSString <Optional>*image_id;
@property (nonatomic ,copy)NSString <Optional>*img05;
@property (nonatomic ,copy)NSString <Optional>*img50;
@property (nonatomic ,copy)NSString <Optional>*location;
@property (nonatomic ,copy)NSString <Optional>*svol;
@property (nonatomic ,copy)NSString <Optional>*total_tucao;
@property (nonatomic ,copy)NSString <Optional>*webp;
@property (nonatomic ,copy)NSString <Optional>*width;
@end
