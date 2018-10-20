//
//  DatePicekView.m
//  Comic island
//
//  Created by 1111 on 2017/12/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define HEIGHT_OF_POPBOX (([UIScreen mainScreen].bounds.size.width == 414)?290:280)
#define HEIGHT_PICKER HEIGHT_OF_POPBOX - 160 + self.dataSource.count * 20

#define COLOR_BACKGROUD_GRAY    [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1]

#import "DatePicekView.h"

@interface DatePicekView()
@property(nonatomic,strong)UIButton *btnDone;
@property(nonatomic,strong)UIButton *btnCancel;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIView *blackview;
@property(nonatomic,strong)NSDateFormatter *formatter;

@end

@implementation DatePicekView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0,SCREEN_HEIGHT,SCREEN_WIDTH,HEIGHT_OF_POPBOX);
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
    [_datePicker setDate:[NSDate date]animated:YES];
    [_datePicker setMaximumDate:[NSDate date]];
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    
    [_datePicker setMinimumDate:[self.formatter dateFromString:@"1900-01-01日"]];
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
    
    
    _blackview = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, 40)];
    _blackview.backgroundColor = COLOR_BACKGROUD_GRAY;
    _blackview.userInteractionEnabled = YES;
    [self addSubview:_blackview];
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(0,0,60, 30);
    _btnDone.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnDone setTitleColor:self.tintColor forState:UIControlStateNormal];
    [_btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
//    _btnDone.layer.borderWidth = 0.3;
//    _btnDone.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_blackview addSubview:_btnDone];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame = CGRectMake(self.frame.size.width-60, 0, 60, 30);
    _btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [_btnCancel setTitleColor:self.tintColor forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_blackview addSubview:_btnCancel];
    
 
    
}
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectDate) {
        _GetSelectDate([self.formatter stringFromDate:_datePicker.date]);
        [self removeFromSuperview];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

- (void)dateChange:(id)datePicker {
    
}
#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    [_datePicker setDate:[self.formatter dateFromString:selectDate] animated:YES];
}
- (NSDateFormatter *)formatter {
    if (_formatter) {
        return _formatter;
    }
    _formatter =[[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    return _formatter;
    
}
- (void)show{

        [[[UIApplication sharedApplication].delegate window] addSubview:self];
    
        //动画出现
        CGRect frame = self.frame;
        if (frame.origin.y == SCREEN_HEIGHT) {
           frame.origin.y -= HEIGHT_OF_POPBOX - 80;
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = frame;
            }];
        }
  
}

@end
