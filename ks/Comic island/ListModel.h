//
//  ListModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface ListModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*argCon;
@property (nonatomic ,copy)NSString <Optional>*argName;
@property (nonatomic ,copy)NSString <Optional>*argValue;
@property (nonatomic ,copy)NSString <Optional>*cover;
@property (nonatomic ,copy)NSString <Optional>*explainUrl;
@property (nonatomic ,copy)NSString <Optional>*rankingDescription1;
@property (nonatomic ,copy)NSString <Optional>*rankingDescription2;
@property (nonatomic ,copy)NSString <Optional>*rankingName;

@end
