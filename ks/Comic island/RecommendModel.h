
//  RecommendModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@protocol comicListItemsModel

@end

@interface comicListItemsModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*accredit;
@property (nonatomic ,copy)NSString <Optional>*comic_id;
@property (nonatomic ,copy)NSString <Optional>*cover;
@property (nonatomic ,copy)NSString <Optional>*description1;
@property (nonatomic ,copy)NSString <Optional>*is_dujia;
@property (nonatomic ,copy)NSString <Optional>*last_update_chapter_name;
@property (nonatomic ,copy)NSString <Optional>*last_update_time;
@property (nonatomic ,copy)NSString <Optional>*name;
@property (nonatomic ,copy)NSString <Optional>*nickname;
@property (nonatomic ,copy)NSString <Optional>*theme_ids;
@property (nonatomic ,copy)NSString <Optional>*user_id;
@end


@interface RecommendModel : JSONModel

@property (nonatomic ,copy)NSString <Optional>*argName;
@property (nonatomic ,copy)NSString <Optional>*argValue;

@property (nonatomic ,copy)NSString <Optional>*itemViewType;

@property (nonatomic ,copy)NSString <Optional>*title;
@property (nonatomic ,copy)NSString <Optional>*titleIconUrl;
@property (nonatomic ,copy)NSString<Optional>*titleWithIcon;

@property (nonatomic ,copy)NSArray <Optional,comicListItemsModel>*comicListItems;

@end
