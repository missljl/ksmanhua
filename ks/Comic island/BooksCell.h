//
//  BooksCell.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookView.h"


@protocol booksCellDelegate <NSObject>

-(void)booksId:(NSString *)bookid;

@end




@interface BooksCell : UIView


@property (nonatomic,strong) BookView *bookview;


@property (nonatomic,weak)id<booksCellDelegate>delegate;

@property (nonatomic ,copy)NSArray *booksArray;

@end
