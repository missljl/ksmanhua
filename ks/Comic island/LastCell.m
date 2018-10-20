//
//  LastCell.m
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "LastCell.h"
#import"LasetView.h"
#import "Define.h"
@implementation LastCell
{
    LasetView *_lastviews;
}
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //[self configUI];
        
    }
    return self;
}
//-(void)FielLastArray:(NSArray *)array
//{
//
//    _lastviews = [[LasetView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 150) withImageArray:array];
//    [self addSubview:_lastviews];
//    
//    
//}
@end
