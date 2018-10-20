//
//  YDJlManager.h
//  Comic island
//
//  Created by 1111 on 2017/12/1.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
@interface YDJlManager : NSObject

+(id)ydjlManager;


//添加收藏
-(void)addModel:(DetailModel *)model;

-(void)deleteModel:(DetailModel *)model;

-(NSMutableArray *)allModels;

-(BOOL)isExists:(id)model;

@end
