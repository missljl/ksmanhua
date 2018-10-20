//
//  DBManager.m
//  FavoriteLimit
//
//  Created by 沈家林 on 15/10/9.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBManager
{
    FMDatabase *_database;
    NSLock *_lock;
}

+(DBManager *)shareManager{
    static DBManager *manager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!manager) {
            manager=[[DBManager alloc]init];
        }
    });
    
    return manager;
}

-(id)init{
    self=[super init];
    if (self) {
       
        NSString *path=[NSString stringWithFormat:@"%@/Documents/youyaoqiApp1.db",NSHomeDirectory()];
//        NSLog(@"######%@",path);
        _database=[[FMDatabase alloc]initWithPath:path];
        if ([_database open]) {
            NSString *sql=@"create table if not exists app(id integer primary key autoincrement,appid varchar(1024),appname varchar(1024),appurl varchar(2048))";
            BOOL isSuccess=[_database executeUpdate:sql];
            if (!isSuccess) {
//                NSLog(@"create:%@",_database.lastError);
            }
        }
        
    }
    return self;
}

//根据model中的appid查找
-(BOOL)hasItem:(DetailModel *)model{
   
    NSString *sql=@"select * from app where appid=?";
    FMResultSet *set=[_database executeQuery:sql,model.comic_id];
    return [set next];
}
//添加一条数据
-(void)insertItem:(DetailModel *)model{
    if ([self hasItem:model]) {
        return;
    }
   
    NSString *sql=@"insert into app (appid,appname,appurl) values (?,?,?)";
    BOOL isSuccess=[_database executeUpdate:sql,model.comic_id,model.name,model.cover];
    if (!isSuccess) {
//        NSLog(@"insert:%@",_database.lastError);
    }
   
}
//删除
-(void)deleteItem:(DetailModel *)model
{
    
    if ([self hasItem:model]) {
     
        //"delete * from userInfo where id=?"这个意思就是 根据id删除 表名叫 userInfo 的数据
        NSString *Sql =  @"delete from app where appid=?";
        BOOL isSuccess = [_database executeUpdate:Sql,model.comic_id];
        if (!isSuccess) {
//            NSLog(@"delete11:%@",[_database lastError]);
        }
      
    }
    
}
//同步到cell上
-(NSArray *)readAllData{
    [_lock lock];
    NSString *sql=@"select * from app";
    FMResultSet *set=[_database executeQuery:sql];
    NSMutableArray *array=[[NSMutableArray alloc]init];
    while ([set next]) {
        CollectionModel *model=[[CollectionModel alloc]init];
        model.comic_id=[set stringForColumn:@"appid"];
        model.name=[set stringForColumn:@"appname"];
        model.cover=[set stringForColumn:@"appurl"];
        [array addObject:model];
    }
//    if ([set next]) {
//        MycollectionModel *model=[[MycollectionModel alloc]init];
//                model.appId=[set stringForColumn:@"appid"];
//                model.appName=[set stringForColumn:@"appname"];
//                model.appUrl=[set stringForColumn:@"appurl"];
//                [array addObject:model];
//  }//else if (![set next]){
////        MycollectionModel *model=[[MycollectionModel alloc]init];
////        model.appId=[set stringForColumn:@"appid"];
////        model.appName=[set stringForColumn:@"appname"];
////        model.appUrl=[set stringForColumn:@"appurl"];
////        [array removeObject:model];
////    }
    [_lock unlock];
    return [array copy];
}

@end
