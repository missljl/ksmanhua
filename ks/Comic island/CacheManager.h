//
//  CacheManager.h
//  爱限免
//
//  Created by huangdl on 15/8/17.
//  Copyright (c) 2015年 黄驿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
//初始化
+(id)manager;
//判断文件目录是否存在
-(BOOL)isExists:(NSString *)cachename;
//
-(NSData *)getCache:(NSString *)cachename;

-(void)saveCache:_data forName:_urlString;

-(void)saveCache:_data forName:_urlString currentPage:(NSInteger)page;

-(NSString *)urlWithCacheName:(NSString *)name;

-(void)removeItematPAth:(NSString *)cachename;

@end





