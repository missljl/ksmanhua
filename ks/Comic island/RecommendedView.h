//
//  RecommendedView.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LasetView.h"
#import "BooksCell.h"
#import "HeaderCell.h"
@protocol RecommendedDelegate <NSObject>

-(void)RencommendedlastviewId:(NSString *)bookId RenconmmendedargName:(NSString *)argName RencommendedTitle:(NSString *)title;


-(void)RecommendBooksName:(NSString *)name recommendBooksId:(NSString *)nameId;


-(void)RecommendGenduobtnArgName:(NSString*)argname andArgValue:(NSString*)argvalue andtitle:(NSString*)fenlietitle;


@end




@interface RecommendedView : UIView<UITableViewDataSource,UITableViewDelegate,LsatDelegate,booksCellDelegate,headerDelegate>
@property (nonatomic,weak)id<RecommendedDelegate>delegate;

@end
