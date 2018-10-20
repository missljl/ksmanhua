//
//  LasetView.m
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import "LasetView.h"
#import "Define.h"
#import "RecommendModelLastModel.h"
#import "UIImageView+WebCache.h"
@implementation LasetView
{
    UIImageView *_iamgeview;
    NSArray *_ImageArray;
}
-(instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageviewArray
{
    if (self=[super initWithFrame:frame]) {
      _ImageArray = imageviewArray;
        self.userInteractionEnabled = YES;
    [self configUI];
    }
    return self;
}
//-(void)setImageviewArray:(NSArray *)imageviewArray{
//
//    _ImageArray =imageviewArray;
//    [self configUI];
//
//}
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
//    ---战争----7---themehttp:\/\/image.mylife.u17t.com\/2016\/12\/28\/1482920257_yznXvXJcrvk8.jpg//    古风----46---special
//    ---火影----38---special
//    ---耽美----3---cate
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
//    view.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:view];
   // KWS(ws);
    CGFloat width = (SCREEN_WIDTH-30)/2;
    CGFloat height = (self.frame.size.height-30)/2;
    CGFloat spaceX = 10;//(SCREEN_WIDTH-2*15-3*width)/2.0;//x之间间隔;
    CGFloat spaceY = 10;//(245+5-2*height)/2.0;//y间隔
    for (NSInteger i=0; i<_ImageArray.count; i++) {
//        NSLog(@"--------%ld",_ImageArray.count);
       RecommendModelLastModel *lastmodel = _ImageArray[i];
       [_iamgeview sd_setImageWithURL:[NSURL URLWithString:lastmodel.imagename]];
        _iamgeview.userInteractionEnabled = YES;

        _iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(spaceX+(width+spaceX)*(i%2),spaceY+(height+spaceY)*(i/2), width, height)];
        _iamgeview.tag=300+i;
       if (i==3) {
           RecommendModelLastModel *lastmodel = _ImageArray[0];
           _iamgeview = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-width-10,self.frame.size.height-height-10,width,height)];
          [_iamgeview sd_setImageWithURL:[NSURL URLWithString:lastmodel.imagename]];
           _iamgeview.userInteractionEnabled = YES;
           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
           [_iamgeview addGestureRecognizer:tap];
           _iamgeview.tag=303;
           [self addSubview:_iamgeview];
      }
         [self addSubview:_iamgeview];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_iamgeview addGestureRecognizer:tap];
        
        
    }
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView = (UIImageView *)tap.view;
    NSInteger index = imgView.tag - 300;
    if (index==3) {
      RecommendModelLastModel *model =_ImageArray[index-index];
        [self.delgate sendLastid:model.leiid andargName:model.name addTitle:model.leixin];
//    NSLog(@"我是古风:%@",model);
    }else{
    RecommendModelLastModel *model =_ImageArray[index+1];
//    NSLog(@"这边是尾部广告要穿id%@",model);
          [self.delgate sendLastid:model.leiid andargName:model.name addTitle:model.leixin];
//  [self.delgate sendLastid:model.argValue andargName:model.argName addTitle:model.specialTitle];
    // [self.delegate didTapAdModel:model image:imgView.image];
    }


}
//古风:12966
//穿越:27107
//历任:83541
//万圣节:110471
@end
