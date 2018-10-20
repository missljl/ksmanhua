//
//  ListeModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-6.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface ListeModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*argCon;
@property (nonatomic ,copy)NSString <Optional>*argName;
@property (nonatomic ,copy)NSString <Optional>*argValue;
@property (nonatomic ,copy)NSString <Optional>*cover;
@property (nonatomic ,copy)NSString <Optional>*icon;
@property (nonatomic ,copy)NSString <Optional>*iconSortName;
@property (nonatomic ,copy)NSString <Optional>*sortId;
@property (nonatomic ,copy)NSString <Optional>*sortName;


@end
