//
//  FavoriteManager.h
//  爱限免
//
//  Created by huangdl on 15/8/18.
//  Copyright (c) 2015年 黄驿. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AppModel.h"
#import "DetailModel.h"
#import "CollectionModel.h"
@interface FavoriteManager : NSObject

//收藏,访问详情的url,appName,图片的url,applicationid

+(id)manager;

//添加收藏
-(void)addModel:(DetailModel *)model;

-(void)deleteModel:(DetailModel *)model;

-(NSMutableArray *)allModels;

-(BOOL)isExists:(id)model;


//事务:一组数据库的操作
- (void)beginTransaction;

//当开启事务以后,遇到回滚,那么开启事务之后所做的所有操作全部撤销
- (void)rollback;

//提交,开启事务之后所有操作真实生效
- (void)commit;



@end






