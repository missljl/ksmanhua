//
//  ZuCeViewController.m
//  Comic island
//
//  Created by 1111 on 2017/12/8.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import "ZuCeViewController.h"
#import <BmobSDK/Bmob.h>

#import "MBProgressHUD.h"
#import "DengLuViewController.h"

#import "MyUser.h"
@interface ZuCeViewController ()<UITextFieldDelegate>
{
    
    UITextField *iphonetextfield;
    UITextField *pawdtextfield;
    UITextField *yanzhengmafield;
    
    
    UIView *Shuluview;
    
    UIButton *zucebtn;
    
    
    NSString *btnstrZorD;
    NSString *fieldstrXorM;
    
    MBProgressHUD *hud;
    
}
@end

@implementation ZuCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self configLeftBtn];
    
    
    
    [self configZuce];
    
    // Do any additional setup after loading the view.
}


#pragma mark----左边按钮
-(void)configLeftBtn{
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(10, 22, 49, 49);
    [leftbtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbtn];
    
}
-(void)leftClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark----注册
-(void)configZuce{
    
    
    
    
    
    
    Shuluview = [[UIView alloc]initWithFrame:CGRectMake(50,self.view.frame.size.height/2-60-50, self.view.frame.size.width-100, 120)];
    Shuluview.backgroundColor = [UIColor whiteColor];
    Shuluview.userInteractionEnabled = YES;
    //Shuluview.layer.borderWidth = 0.5;
    Shuluview.layer.cornerRadius = 7;
    [self.view addSubview:Shuluview];
    
    iphonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Shuluview.frame.size.width, 39.5)];
    iphonetextfield.delegate = self;
    //    iphonetextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 39.5)];
    //左侧按钮图标一直出现
    //    iphonetextfield.leftViewMode = UITextFieldViewModeAlways;
    
    //    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, 22, 22)];
    iphonetextfield.keyboardType = UIKeyboardTypeNumberPad;
    //    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    iphonetextfield.placeholder = @"您的手机号";
    iphonetextfield.enabled = YES;
    //    [iphonetextfield.leftView addSubview:imgUser];
    //编辑时出现x👌
    iphonetextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [Shuluview addSubview:iphonetextfield];
    
    
    
    //分割线
    UIView *fengeview= [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, Shuluview.frame.size.width, 1)];
    fengeview.backgroundColor = [UIColor lightGrayColor];
    [Shuluview addSubview:fengeview];
    
    yanzhengmafield = [[UITextField alloc]initWithFrame:CGRectMake(0, 39.5, Shuluview.frame.size.width, 39.5)];
    yanzhengmafield.delegate = self;
    yanzhengmafield.enabled = YES;
    //键盘样式
    yanzhengmafield.font = [UIFont systemFontOfSize:14];
    yanzhengmafield.keyboardType = UIKeyboardTypeNumberPad;
    //键盘return键样式
    yanzhengmafield.returnKeyType = UIReturnKeyDone;
    yanzhengmafield.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,yanzhengmafield.frame.size.width/3, 40)];
    yanzhengmafield.rightViewMode = UITextFieldViewModeAlways;
    //    pawdtextfield.secureTextEntry = YES;
    yanzhengmafield.placeholder = @"请输入验证码";
    //    pawdtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIButton *yanbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,yanzhengmafield.frame.size.width/3, 40)];
    [yanbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    yanbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [yanbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    yanbtn.backgroundColor = [UIColor colorWithRed:0.04f green:0.65 blue:0.16 alpha:1.00f];
    [yanbtn addTarget:self action:@selector(yanbtnonClick:) forControlEvents:UIControlEventTouchUpInside];
    [yanzhengmafield.rightView addSubview:yanbtn];
    [Shuluview addSubview:yanzhengmafield];
    
    
    //第二条分割线分割线
    UIView *fengeviewtwo= [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(yanzhengmafield.frame), Shuluview.frame.size.width, 1)];
    fengeviewtwo.backgroundColor = [UIColor lightGrayColor];
    [Shuluview addSubview:fengeviewtwo];
    
    
    pawdtextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(fengeviewtwo.frame), Shuluview.frame.size.width, 39.5)];
    pawdtextfield.delegate = self;
    iphonetextfield.enabled = YES;
    //键盘样式
    pawdtextfield.keyboardType = UIKeyboardTypeDefault;
    //键盘return键样式
    pawdtextfield.returnKeyType = UIReturnKeyDone;
    
    pawdtextfield.secureTextEntry = YES;
    pawdtextfield.placeholder = _iszeceOrdengru?@"请输入密码":@"请输入新的密码";
    pawdtextfield.font = [UIFont systemFontOfSize:14];
    pawdtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [Shuluview addSubview:pawdtextfield];
    
    
    
    zucebtn = [[UIButton alloc]initWithFrame:CGRectMake(Shuluview.frame.origin.x, CGRectGetMaxY(Shuluview.frame)+20,Shuluview.frame.size.width,30)];
    zucebtn.layer.cornerRadius = 7;
    
    zucebtn.backgroundColor =[UIColor colorWithRed:0.04f green:0.65 blue:0.16 alpha:1.00f];
    //    [dengrubtn setBackgroundImage:[UIImage imageNamed:@"changeUserNameSelect@2x"] forState:UIControlStateNormal];
    [zucebtn setTitle:_iszeceOrdengru?@"注册":@"下一步" forState:UIControlStateNormal];
    [zucebtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    zucebtn.userInteractionEnabled = NO;
    zucebtn.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [zucebtn addTarget:self action:@selector(zucebtnonClick) forControlEvents:UIControlEventTouchUpInside];
    //Shuluview.layer.borderWidth = 0.5;
    [self.view addSubview:zucebtn];
    
    CGFloat px = Shuluview.frame.size.width/3;
    
    UIImageView  *imageview= [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-px/2,Shuluview.frame.origin.y-(px+20), px, px)];
    imageview.image = [UIImage imageNamed:@"33"];
    [self.view addSubview:imageview];
    
    
    
    
}
//获取验证码按钮点击shi'jian
-(void)yanbtnonClick:(UIButton *)btn{
    
    [self hudstring:@"验证码已发送"];
    
    if ([self isIphonestring:iphonetextfield.text]) {
        //请求验证码
        [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:iphonetextfield.text andTemplate:@"kasha" resultBlock:^(int number, NSError *error) {
        }];
        //按钮倒计时
        [self daojishibtn:btn];
    }else{
        
        [self hudstring:@"手机号码不正确"];
    }
    
 
}
-(void)zucebtnonClick{
    [self iskongyanzhengfield];
    [self ispwadfield];
    if (_iszeceOrdengru==NO) {
        [BmobUser resetPasswordInbackgroundWithSMSCode:yanzhengmafield.text andNewPassword:pawdtextfield.text block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [self.navigationController popViewControllerAnimated:YES];
                [self hudstring:@"修改密码成功"];

            }else{
                [self hudstring:@"你还没有注册哦"];
            }
        }];

    
        
    }else{

        BmobUser *user =[[BmobUser alloc]init];
        [user setUsername:@"_用户9527"];
        [user setPassword:pawdtextfield.text];
        [user setMobilePhoneNumber:iphonetextfield.text];
        
    NSString *path = [[NSBundle mainBundle]pathForResource:@"55" ofType:@"png"];
                                       NSData *data = [NSData dataWithContentsOfFile:path];
                                   BmobFile *bmobFile = [[BmobFile alloc]initWithFileName:@"ss.png" withFileData:data];
        [bmobFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
            if (!error) {
                [user setObject:bmobFile.url forKey:@"userimagename"];
                [user objectForKey:@"userimagename"];
                [user signUpOrLoginInbackgroundWithSMSCode:yanzhengmafield.text block:^(BOOL isSuccessful, NSError *error) {
                    if (!error) {
                        [self hudstring:@"成功注册"];
                        [self.delegate zuceDelegate:@"1"];
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengru" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        
                        [self hudstring:@"该号码已经注册过"];
                    }
                    
                }];
            }
          

        }];
        
  
    }
//    NSLog(@"注册要做逻辑判断如果手机号和密码都是正确的那么把输入的验证码发送给第三方的短信验证服务");
    
}

//已经进入编辑状态
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:pawdtextfield]) {
        zucebtn.userInteractionEnabled = YES;
        [zucebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        zucebtn.userInteractionEnabled = NO;
        [zucebtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
//    NSLog(@"我进入编辑了");
}
//点击键盘上的return时候出发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self iskongyanzhengfield];
    [self ispwadfield];
    if (_iszeceOrdengru==NO) {
        //            NSLog(@"忘记密码");
        [BmobUser resetPasswordInbackgroundWithSMSCode:yanzhengmafield.text andNewPassword:pawdtextfield.text block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
            [self hudstring:@"修改密码成功"];
            [self.navigationController popViewControllerAnimated:YES];
            

            }else{
                [self hudstring:@"你还没有注册哦"];
            }
        }];
        
    }else{
        //短信注册 这边要存userid,并且跳转还要给我的界面发通知
        
      
        NSString *path = [[NSBundle mainBundle]pathForResource:@"55" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        BmobFile *bmobFile = [[BmobFile alloc]initWithFileName:@"ss1.png" withFileData:data];
        [bmobFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
//            NSLog(@"上传链接图片地址%@",bmobFile.url);
            BmobUser *user =[[BmobUser alloc]init];
            NSString *str = [NSString stringWithFormat:@"漫友_%@",yanzhengmafield.text];
            [user setUsername:str];
            [user setPassword:pawdtextfield.text];
            [user setMobilePhoneNumber:iphonetextfield.text];
            
//            [user setObject:bmobFile.url forKey:@"userimagename"];
             [user setObject:bmobFile.url forKey:@"userimagename"];
            [user signUpOrLoginInbackgroundWithSMSCode:yanzhengmafield.text block:^(BOOL isSuccessful, NSError *error) {
                if (!error) {
                    //发送通知给我的界面
                    [self hudstring:@"成功注册"];
                    [self.delegate zuceDelegate:@"1"];
                    [self.navigationController popViewControllerAnimated:YES];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengru" object:nil];
                }else{
                    
                    [self hudstring:@"该号码已经注册过"];
                }
                
            }];
            
            
        }];
       
       
        
        }
    [textField resignFirstResponder];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

  
    
}



//判断手机号和密码
-(BOOL)isIphonestring:(NSString *)str{
    
    if (str.length != 11) {
        //        NSLog(@"手机号不正确");
        return NO;
    }else{
        if ([str hasPrefix:@"1"]) {
            //            NSLog(@"正确");
            //            ipstr = str;
            return YES;
        }else{
            //           NSLog(@"手机号不正确");
            return NO;
        }
        
    }
    return nil;
}
-(void)daojishibtn:(UIButton *)btn{
    __block NSInteger time = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [btn setTitle:@"重新发送" forState:UIControlStateNormal];
                //                    [btn setTitleColor:[UIColor colorFromHexCode:@"FB8557"] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [btn setTitle:[NSString stringWithFormat:@"%.2d", seconds] forState:UIControlStateNormal];
                //                    [btn setTitleColor:[UIColor colorFromHexCode:@"979797"] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}
-(void)iskongyanzhengfield{
    if (yanzhengmafield.text.length==0) {
        [self hudstring:@"验证码还没有填写"];
    }
    
}
-(void)ispwadfield{
    if (pawdtextfield.text.length==0) {
      
        [self hudstring:@"密码不能为空"];
    }
    
}
-(void)hudstring:(NSString *)str{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor orangeColor];
    [hud hideAnimated:YES afterDelay:1.5];
}

@end
