//
//  BookView.m
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "BookView.h"
#import "Define.h"
@implementation BookView

-(instancetype)initWithFrame:(CGRect)frame wtihTag:(NSInteger)tag withBlock:(Block) block
{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled =YES;
        self.tag =tag;
        _callBack = block;
        [self configUI];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super initWithCoder:aDecoder]) {
        self.userInteractionEnabled = YES;
        [self configUI];
    }
    return self;
}



-(void)configUI
{
    UIImageView *view = [[UIImageView alloc]init];
    view.contentMode = UIViewContentModeScaleAspectFill;
   // view.layer.cornerRadius = 5;
  //  view.layer.masksToBounds = YES;
    self.bookimageview =view;
    [self addSubview:view];
    
    
    UILabel *lab = [[UILabel alloc]init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = [UIColor grayColor];
    self.bookname = lab;
    [self addSubview:lab];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewButtonAction:)];
    [self addGestureRecognizer:tap];
    


}
-(void)viewButtonAction:(UITapGestureRecognizer *)tap
{
    
    NSInteger index =tap.view.tag;
    if (_callBack) {
        _callBack(index);
    }
    
}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.bookimageview.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.7);
    
    self.bookname.frame =CGRectMake(0, self.frame.size.height * 0.69, self.frame.size.width, self.frame.size.height * 0.3);
    
    
}
@end
