//
//  HeaderCell.m
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "HeaderCell.h"
#import "LJL.h"
#import "Define.h"

@implementation HeaderCell
{
    
    LJL *_view;
 
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)configUI
{

}
-(void)fiel:(NSArray *)array
{
    if (_view) {
        [_view removeFromSuperview];
    }
   
     _view = [[LJL alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_WIDTH-100) WithArray:array];;
    _view.delegate = self;
   // _HeaderScr = [[ScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 150) imageArray:[array copy]];
    [self.contentView addSubview:_view];
}
-(void)ljlcomid:(NSString *)com_id
{

    [self.delegate headerCom_id:com_id];
}
@end
