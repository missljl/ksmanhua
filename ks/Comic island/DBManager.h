//
//  DBManager.h
//  FavoriteLimit
//
//  Created by 沈家林 on 15/10/9.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionModel.h"
#import "DetailModel.h"
@interface DBManager : NSObject


+(DBManager *)shareManager;
//判断是否包含
-(BOOL)hasItem:(DetailModel *)model;
//插入
-(void)insertItem:(DetailModel *)model;
//删除
-(void)deleteItem:(DetailModel *)model;
//读取
-(NSArray *)readAllData;
@end
