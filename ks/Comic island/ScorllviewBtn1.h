//
//  ScorllviewBtn.h
//  AutoHome
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScorllviewBtn : UIView<UIScrollViewDelegate>


-(id)initWithFrame:(CGRect)frame ScbgColor:(UIColor *)sccolor WithTitleArray:(NSArray *)titleNameArray WithimageName:(NSArray *)imageNameArray  target:(id)target action:(SEL)action tag:(NSInteger)tag;

-(UIView *)congigNavgationBtnTitleNarray:(NSArray *)titleArray Wtihframe:(CGRect)frame target:(id)target action:(SEL)action tag:(NSInteger)tag;


@end
