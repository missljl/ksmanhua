//
//  BooksCell.m
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#define BOOKS_WIDTH (SCREEN_WIDTH-40)/3
#define BOOKS_HEIGHT BOOK_WIDTH*1.5


#import "BooksCell.h"
#import "Define.h"
#import "RecommendModel.h"
#import "UIImageView+WebCache.h"

@implementation BooksCell

-(void)setBooksArray:(NSArray *)booksArray
{
    _booksArray=booksArray;
    [self configUI];
    [self configUI1];
}
-(id)initWithFrame:(CGRect)frame withArray:(NSArray *)array
{
    if (self=[super initWithFrame:frame]) {
          }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder witgArray:(NSArray *)array
{
    
    if (self=[super initWithCoder:aDecoder]) {
    }
    return self;
}

-(void)configUI
{
    //由于是for的所以指向的是统一内存空间,所以才会出现这种情况
    //指向了统一内存
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[BookView class]]) {
            [view removeFromSuperview];
        }
    }
    KWS(ws);

    CGFloat width = ([UIScreen mainScreen].bounds.size.width-40)/3;
  
    CGFloat height = width*1.5;
    
   
  
    
    CGFloat heighty = (width*1.5)*2+50;
    
    
    CGFloat spaceY = (heighty-50-height*2)/2.0;//y间隔
    for (NSInteger i=0; i<6; i++) {
               comicListItemsModel *model1 =_booksArray[i];
       _bookview.bookname.text = model1.name;
       [_bookview.bookimageview sd_setImageWithURL:[NSURL URLWithString:model1.cover]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
     _bookview = [[BookView alloc]initWithFrame:CGRectMake(10+(width+10)*(i%3),14+(height+spaceY)*(i/3), width, height) wtihTag:200+i withBlock:^(NSInteger index) {
            [ws pusBook:index];
     }];
        
        
   [self addSubview:_bookview];
        }
    
    
}
-(void)configUI1
{
    
    

    for (NSInteger i=0; i<_booksArray.count; i++) {
    if (i==0) {
        comicListItemsModel *model1 =_booksArray[i];
//        NSLog(@"$$$$$$$$$%@",_booksArray[i]);
        _bookview.bookname.text = model1.name;
        [_bookview.bookimageview sd_setImageWithURL:[NSURL URLWithString:model1.cover]];
        _bookview = [[BookView alloc]initWithFrame:CGRectMake(218,275,90,20) wtihTag:300+i withBlock:^(NSInteger index) {
     

        }];
        

    }
    }
}

-(void)pusBook:(NSInteger)tap
{
  
    _bookview.tag=tap;
    NSInteger index =_bookview.tag-200;
    if (index==5) {
        comicListItemsModel *model1 = _booksArray[index-index];
        [self.delegate  booksId:model1.comic_id];
        
//        NSLog(@"我是5%@",model1.user_id);
    }else{
    comicListItemsModel *model1 =_booksArray[index+1];
        
        [self.delegate  booksId:model1.comic_id];
        
//         NSLog(@"我是0%@",model1.user_id);
    }

}
//迷失世界尽头:6065
//蓝池:4177111
//你什么都没看见:2412
//月球漩涡:1413
//海上成效"1803314
//胖次奇闻录:5939501
//点0是5,
//点1是2
//点2是3
//点3是4
//点4是5
//点5是0
@end
