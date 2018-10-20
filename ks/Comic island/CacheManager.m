//
//  CacheManager.m
//  爱限免
//
//  Created by huangdl on 15/8/17.
//  Copyright (c) 2015年 黄驿. All rights reserved.
//

#import "CacheManager.h"
#import "NSString+MD5Addition.h"
@implementation CacheManager
{
    NSFileManager *_fileManager;
    NSString *_basePath;
}


+(id)manager
{
    static CacheManager *_m = nil;
    if (!_m) {
        _m = [[CacheManager alloc]init];
    }
    return _m;
}

//初始化方法,初始化环境
- (instancetype)init
{
    self = [super init];
    if (self) {
        //文件管理单例
        _fileManager = [NSFileManager defaultManager];
        //这个是路径
        _basePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"AiDongMan"];
//        NSLog(@"%@",_basePath);
        //如果文件不存在(判断路径是否存在)
        if(![_fileManager fileExistsAtPath:_basePath])
        {
            //创建
            [_fileManager createDirectoryAtPath:_basePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
    }
    return self;
}

//判断有没有缓存,
-(BOOL)isExists:(NSString *)cachename
{
    return [_fileManager fileExistsAtPath:[self urlWithCacheName:cachename]];
}
//从文件中取出数据
-(NSData *)getCache:(NSString *)cachename
{
     return [NSData dataWithContentsOfFile:[self urlWithCacheName:cachename]];
}
//将数据存入文件
-(void)saveCache:(NSData *)_data forName:_urlString
{
    NSString *path = [self urlWithCacheName:_urlString];
    [_data writeToFile:path atomically:NO];
}
//将数据存入文件(可以连续写入)
-(void)saveCache:(NSData *)_data forName:_urlString currentPage:(NSInteger)page
{
    if (page == 1) {
        [self saveCache:_data forName:_urlString];
        return;
    }
    //先取出之前的数据并解析
    NSData *oldData = [self getCache:_urlString];
    NSDictionary *oldDic = [NSJSONSerialization JSONObjectWithData:oldData options:NSJSONReadingMutableContainers error:nil];
    NSArray *oldArr = oldDic[@"applications"];
    
    //解析现在新的数据
    NSDictionary *newDic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    NSArray *newArr = newDic[@"applications"];
    
    //拼接两个数组
    NSMutableArray *arr = [[NSMutableArray alloc]initWithArray:oldArr];
    [arr addObjectsFromArray:newArr];
    
    //将数组按照之前的格式保存到本地
    NSDictionary *dic = @{@"applications":arr};
    NSData *d = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [self saveCache:d forName:_urlString];
    
    //保存当前的页数
    [[NSUserDefaults standardUserDefaults]setValue:@(page) forKey:_urlString];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//删除缓存
-(void)removeItematPAth:(NSString *)cachename
{
    NSString *path = [self urlWithCacheName:cachename];
    [_fileManager removeItemAtPath:path error:nil];
    
}
//这个是将网址转换成32字符
-(NSString *)urlWithCacheName:(NSString *)name
{
    NSString *urlmd5 = [name stringFromMD5];
//    NSLog(@"%@",urlmd5);
    return [_basePath stringByAppendingPathComponent:urlmd5];
}










@end
