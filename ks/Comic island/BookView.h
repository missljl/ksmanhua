//
//  BookView.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^Block)(NSInteger index);


@interface BookView : UIView

@property (nonatomic,strong)UILabel *bookname;
@property (nonatomic,strong)UIImageView *bookimageview;


-(instancetype)initWithFrame:(CGRect)frame wtihTag:(NSInteger)tag withBlock:(Block) block;

@property(nonatomic,copy)Block callBack;

@end
