//
//  DetailModel.h
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "JSONModel.h"

@interface DetailModel : JSONModel
@property (nonatomic ,copy)NSString <Optional>*author_name;
@property (nonatomic ,copy)NSString <Optional>*avatar;
@property (nonatomic ,copy)NSString <Optional>*cate_id;
@property (nonatomic ,copy)NSString <Optional>*click_total;
@property (nonatomic ,copy)NSString <Optional>*comic_id;
@property (nonatomic ,copy)NSString <Optional>*comment_total;
@property (nonatomic ,copy)NSString <Optional>*cover;
@property (nonatomic ,copy)NSString <Optional>*description1;
@property (nonatomic ,copy)NSString <Optional>*first_letter;
@property (nonatomic ,copy)NSString <Optional>*image_all;
@property (nonatomic ,copy)NSString <Optional>*is_auto_buy;
@property (nonatomic ,copy)NSString <Optional>*is_dub;
@property (nonatomic ,copy)NSString <Optional>*is_free;
@property (nonatomic ,copy)NSString <Optional>*is_vip;
@property (nonatomic ,copy)NSString <Optional>*last_update_chapter_id;
@property (nonatomic ,copy)NSString <Optional>*last_update_chapter_name;
@property (nonatomic ,copy)NSString <Optional>*last_update_time;

@property (nonatomic ,copy)NSString <Optional>*month_ticket;
@property (nonatomic ,copy)NSString <Optional>*name;
@property (nonatomic ,copy)NSString <Optional>*ori;
@property (nonatomic ,copy)NSString <Optional>*read_order;
@property (nonatomic ,copy)NSString <Optional>*series_status;
@property (nonatomic ,copy)NSString <Optional>*server_time;
@property (nonatomic ,copy)NSString <Optional>*theme_ids;
@property (nonatomic ,copy)NSDictionary <Optional>*thread;
@property (nonatomic ,copy)NSString <Optional>*total_hot;
@property (nonatomic ,copy)NSString <Optional>*total_ticket;
@property (nonatomic ,copy)NSString <Optional>*total_tucao;
@property (nonatomic ,copy)NSString <Optional>*user_id;
@property (nonatomic ,copy)NSString <Optional>*type;

@property(nonatomic,copy)NSString <Optional>*isbtnheid;


@end
