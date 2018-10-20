//
//  RecommendHeaderModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface RecommendHeaderModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*argName;
@property (nonatomic ,copy)NSString <Optional>*argValue;
@property (nonatomic ,copy)NSString <Optional>*bannerType;
@property (nonatomic ,copy)NSString <Optional>*bigImageUrl;
@property (nonatomic ,copy)NSString <Optional>*comicId;
@property (nonatomic ,copy)NSString <Optional>*content;
@property (nonatomic ,copy)NSString <Optional>*defaultImageUrl;
@property (nonatomic ,copy)NSString <Optional>*linkType;
@property (nonatomic ,copy)NSString <Optional>*smallImageUrl;
@property (nonatomic ,copy)NSString <Optional>*specialTitle;
@property (nonatomic ,copy)NSString <Optional>*specialTopicId;
@property (nonatomic ,copy)NSString <Optional>*wapUrl;

@property (nonatomic ,copy)NSString <Optional>*imagename;
@property (nonatomic ,copy)NSString <Optional>*comid;
@end
