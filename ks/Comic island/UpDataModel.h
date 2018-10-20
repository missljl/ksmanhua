//
//  UpDataModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@protocol tagsModel



@end
@interface tagsModel : JSONModel
@property (nonatomic ,copy)NSString <Optional>*tag1;

@end




@interface UpDataModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*accredit;
@property (nonatomic ,copy)NSString <Optional>*click_total;
@property (nonatomic ,copy)NSString <Optional>*comic_id;
@property (nonatomic ,copy)NSString <Optional>*cover;
@property (nonatomic ,copy)NSString <Optional>*description1;
@property (nonatomic ,copy)NSString <Optional>*extraValue;
@property (nonatomic ,copy)NSString <Optional>*is_dujia;
@property (nonatomic ,copy)NSString <Optional>*is_free;
@property (nonatomic ,copy)NSString <Optional>*last_update_chapter_name;
@property (nonatomic ,copy)NSString <Optional>*last_update_time;
@property (nonatomic ,copy)NSString <Optional>*name;
@property (nonatomic ,copy)NSString <Optional>*nickname;
@property (nonatomic ,copy)NSString <Optional>*series_status;
@property (nonatomic ,copy)NSString <Optional>*theme_ids;
@property (nonatomic ,copy)NSString <Optional>*user_id;
@property (nonatomic ,copy)NSArray <Optional,tagsModel>*tags;


@end
