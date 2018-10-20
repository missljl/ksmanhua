//
//  YDJlManager.m
//  Comic island
//
//  Created by 1111 on 2017/12/1.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "YDJlManager.h"
#import "FMDatabase.h"
@implementation YDJlManager
{
    FMDatabase *_fmdb;
    
}
+(id)ydjlManager
{
    static YDJlManager *_m = nil;
    if (!_m) {
        _m = [[YDJlManager alloc]init];
    }
    return _m;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //path:指数据库文件的位置
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"aidongmanYDjl.db"];
//        NSLog(@"path%@",path);
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        
        //打开数据库
        //如果这个数据库不存在,则先创建,再打开
        //如果已经存在,直接打开供后面使用
        BOOL success = [_fmdb open];
        if (success) {
            //如果打开成功,创建数据库表
            NSString *sql = @"create table if not exists app(applicationid varchar(32),name varchar(128),bookzhangjieid varchar(256),bookzhangname varchar(256))";
            if(![_fmdb executeUpdate:sql])
            {
//                NSLog(@"创建数据失败");
            }
        }
    }
    return self;
}



//添加收藏
-(void)addModel:(DetailModel *)model
{
    //    NSString *sql = [NSString stringWithFormat: @"insert into app (applicationid,name,iconurl) values ('%@','%@','%@')",model.applicationId,model.name,model.iconUrl];
    //    NSLog(@"%@",sql);
    
    NSString *sql = @"insert into app (applicationid,name,bookzhangjieid,bookzhangname) values (?,?,?,?)";
    BOOL success = [_fmdb executeUpdate:sql,model.comic_id,model.name,model.cover,model.author_name];
    if (success) {
//        NSLog(@"收藏成功");
    }
}

-(void)deleteModel:(DetailModel *)model
{
    NSString *sql = @"delete from app where applicationid=?";
    [_fmdb executeUpdate:sql,model.comic_id];
}

-(NSMutableArray *)allModels
{
    NSMutableArray *resArr = [[NSMutableArray alloc]init];
    
    NSString *sql = @"select * from app";
    FMResultSet *result = [_fmdb executeQuery:sql];
    while ([result next]) {
        NSString *appid = [result stringForColumn:@"applicationid"];
        NSString *name = [result stringForColumn:@"name"];
        NSString *bookzhangjieid = [result stringForColumn:@"bookzhangjieid"];
        NSString *bookzhangjiename = [result stringForColumn:@"bookzhangname"];
        DetailModel *model = [[DetailModel alloc]init];
        model.comic_id = appid;
        model.name = name;
        model.cover = bookzhangjieid;
        model.author_name = bookzhangjiename;
        [resArr addObject:model];
    }
    
    return resArr;
}

-(BOOL)isExists:(id)model
{
    NSString *appid;
    if ([model isKindOfClass:[DetailModel class]]) {
        appid = [(DetailModel *)model comic_id];
    }
    else
    {
        appid = model;
    }
    NSString *sql = @"select * from app where applicationid=?";
    FMResultSet *result = [_fmdb executeQuery:sql,appid];
    return [result next];
}@end
