//
//  ReadviewController.h
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//漫画阅读界面
#import "RootViewController.h"

@protocol ReadViewDelegate <NSObject>

-(void)readViewcuiierid:(NSString *)cuid;

@end



@interface ReadviewController : RootViewController
@property (nonatomic ,copy)NSString *chid;

@property (nonatomic,strong)NSArray *cutaArray;


@property (nonatomic ,copy)NSString *BookTitle;
@property (nonatomic,copy)NSString *bookid;
@property (nonatomic,copy)NSString *bookname;
@property (nonatomic,weak)id<ReadViewDelegate>delegate;




//分享用到的数据 书名，书图片，书简介 书id
@property(nonatomic,copy)NSString *book_imagename;
@property(nonatomic,copy)NSString *book_jianjie;



@end
