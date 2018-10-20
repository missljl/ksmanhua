

//
//  DengLuViewController.m
//  Comic island
//
//  Created by 1111 on 2017/12/7.
//  Copyright © 2017年 李金龙. All rights reserved.
//
//登入界面//返回按钮，右边忘记密码 ，输入框上面有一个图片app图标

#define QQAPIID @"1106525555"
#define QQKEY @"Gb23zzqMG2HktWeS"

#import "DengLuViewController.h"

#import "ZuCeViewController.h"
#import "MBProgressHUD.h"
#import <BmobSDK/Bmob.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import "MyUser.h"


#import "JSHAREService.h"
@interface DengLuViewController ()<UITextFieldDelegate,ZuCeDelegate,TencentSessionDelegate>
{
    UITextField *iphonetextfield;
    UITextField *pawdtextfield;
    UIView *Shuluview;
    UIImageView *appImageview;
    
    UIButton *dengrubtn;
    
    UIButton *zhucebtn;
    
    UIView *bottomview;
    
    MBProgressHUD *hud;
    
    TencentOAuth *tencentOAuth;
}
@end

@implementation DengLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self Selfviewtap];

    //导航条2个按钮
    [self configNavitembtns];
    //输入框
    [self configShuluView];
    //应用图标
     [self configAppImageview];
    //注册登入按钮
    [self configuidengrubtn];
    //其他方式view
    [self configBottomview];
}


-(void)Selfviewtap{
    
    self.navigationController.navigationBarHidden = YES;
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
}

//左上右上按钮
-(void)configNavitembtns{
    
     UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     leftbtn.frame = CGRectMake(10, 22, 49, 49);
    [leftbtn setImage:[UIImage imageNamed:@"SettingBack"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbtn];
   

    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(self.view.frame.size.width-80, 22,70, 49);
    [rightbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

       [rightbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    rightbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [rightbtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightbtn];


    
}
//应用图片控件
-(void)configAppImageview{
    
    CGFloat px = Shuluview.frame.size.width/3;
    
    appImageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-px/2,Shuluview.frame.origin.y-(px+20), px, px)];
    appImageview.image = [UIImage imageNamed:@"33"];
    [self.view addSubview:appImageview];
    
    
    
}
#pragma mark----手机号，密码控件
-(void)configShuluView{
    
    Shuluview = [[UIView alloc]initWithFrame:CGRectMake(50,self.view.frame.size.height/2-40, self.view.frame.size.width-100, 80)];
   Shuluview.backgroundColor = [UIColor whiteColor];
    Shuluview.userInteractionEnabled = YES;
   //Shuluview.layer.borderWidth = 0.5;
    Shuluview.layer.cornerRadius = 7;
    [self.view addSubview:Shuluview];
    
    iphonetextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Shuluview.frame.size.width, 39.5)];
    iphonetextfield.delegate = self;
    iphonetextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 39.5)];
    //左侧按钮图标一直出现
    iphonetextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, 22, 22)];
    iphonetextfield.keyboardType = UIKeyboardTypeNumberPad;
    imgUser.image = [UIImage imageNamed:@"iconfont-user"];
    iphonetextfield.placeholder = @"您的手机号";
    iphonetextfield.enabled = YES;
    [iphonetextfield.leftView addSubview:imgUser];
    //编辑时出现x👌
    iphonetextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [Shuluview addSubview:iphonetextfield];
    
    
    
    //分割线
    UIView *fengeview= [[UIView alloc]initWithFrame:CGRectMake(10, 39.5, Shuluview.frame.size.width-20, 1)];
    fengeview.backgroundColor = [UIColor lightGrayColor];
    [Shuluview addSubview:fengeview];
    
    pawdtextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 39.5, Shuluview.frame.size.width, 39.5)];
    pawdtextfield.delegate = self;
      iphonetextfield.enabled = YES;
    //键盘样式
    pawdtextfield.keyboardType = UIKeyboardTypeDefault;
    //键盘return键样式
    pawdtextfield.returnKeyType = UIReturnKeyDone;
    pawdtextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 39.5)];
    pawdtextfield.leftViewMode = UITextFieldViewModeAlways;
     pawdtextfield.secureTextEntry = YES;
    pawdtextfield.placeholder = @"请输入密码";
      pawdtextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, 25, 25)];
    imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
    [pawdtextfield.leftView addSubview:imgPwd];
    [Shuluview addSubview:pawdtextfield];
    
    
    
    
}
//cgrectgetmaxy---是木一个控件的y+高
//  max----是一个控件的x+款
#pragma mark--登入按钮
-(void)configuidengrubtn{
    dengrubtn = [[UIButton alloc]initWithFrame:CGRectMake(Shuluview.frame.origin.x,CGRectGetMaxY(Shuluview.frame)+20,Shuluview.frame.size.width,30)];
     dengrubtn.layer.cornerRadius = 7;
    
    dengrubtn.backgroundColor =[UIColor colorWithRed:0.04f green:0.65 blue:0.16 alpha:1.00f];
//    [dengrubtn setBackgroundImage:[UIImage imageNamed:@"changeUserNameSelect@2x"] forState:UIControlStateNormal];
    [dengrubtn setTitle:@"登录" forState:UIControlStateNormal];
    [dengrubtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    dengrubtn.userInteractionEnabled = NO;
    dengrubtn.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [dengrubtn addTarget:self action:@selector(dengrubtnonClick) forControlEvents:UIControlEventTouchUpInside];
      //Shuluview.layer.borderWidth = 0.5;
    [self.view addSubview:dengrubtn];
    
    zhucebtn = [[UIButton alloc]initWithFrame:CGRectMake(Shuluview.frame.origin.x,CGRectGetMaxY(dengrubtn.frame)+20, Shuluview.frame.size.width, 30)];
    [zhucebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhucebtn setTitle:@"立即注册" forState:UIControlStateNormal];
    zhucebtn.titleLabel.textAlignment =NSTextAlignmentCenter;
    [zhucebtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [zhucebtn addTarget:self action:@selector(zhucebtnonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhucebtn];
    

    
    
    
}
//其他方式登入view
-(void)configBottomview{
    
    bottomview = [[UIView alloc]initWithFrame:CGRectMake(Shuluview.frame.origin.x, self.view.frame.size.height-120,Shuluview.frame.size.width , 120)];
//    bottomview.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomview];
    UILabel *fengexianlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, Shuluview.frame.size.width, 20)];
    fengexianlabel.text = @"用以下账号登录";
    fengexianlabel.textColor = [UIColor lightGrayColor];
    fengexianlabel.textAlignment = NSTextAlignmentCenter;
   
    [fengexianlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [bottomview addSubview:fengexianlabel];
    CGFloat x = (bottomview.frame.size.width-20)/6;
    NSArray *ar = @[@"find_friend_icon_tencent",@"find_friend_icon_weibo"];
    for (NSInteger i=0; i<ar.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10+(5*x)*i,CGRectGetMaxY(fengexianlabel.frame)+20,x, x)];
        btn.tag = 200+i;
        [btn setImage:[UIImage imageNamed:ar[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(qitabtnonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomview addSubview:btn];
        
    }
    
    
}
#pragma mark---第三方登入按钮
-(void)qitabtnonClick:(UIButton *)btn{
      //微博登入申请还没有过 这边要弄一个菊花转起来
    
    [self hud];
    
    if (btn.tag==200) {
//
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:QQAPIID andDelegate:self];
//       tencentOAuth.authShareType = AuthShareType_QQ;
         NSArray  *ar =  [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
        [tencentOAuth authorize:ar];
        
        
    }else{
      BmobUser *user = [BmobUser currentUser];
        if (user != nil) {
            NSLog(@"有值");
        }else{
        
        //微博登入申请还没有过 这边要弄一个菊花转起来
        [JSHAREService getSocialUserInfo:JSHAREPlatformSinaWeibo handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
            if (error) {
                  [hud hideAnimated:YES];
                [self hudstring:@"无法获取到用户信息"];
            }else{
                
//                   NSLog(@"-----++++++____________________%@",userInfo.userOriginalResponse);
              NSString *str=[NSString stringWithFormat:@"%ld",userInfo.expiration];//时间戳
               NSTimeInterval time =(NSTimeInterval )[str floatValue];//因为时差问题要加8小时 == 28800 sec
                NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//                NSLog(@"date:%@",detaildate);
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                
                [dateFormatter setDateFormat:@"yyyy/MM/dd hh:mm"];
                
//                NSString *dateStr = [dateFormatter stringFromDate:detaildate];
//                NSLog(@"%@----weibo",dateStr);
                NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                      userInfo.accessToken, @"access_token",
                                      userInfo.uid, @"uid",
                                      detaildate, @"expirationDate",
                                      nil];
             
//    NSDictionary *dic = @{@"access_token":actoken,@"uid":uid,@"expirationDate":expiresdate};
               [BmobUser signUpInBackgroundWithAuthorDictionary:dic2 platform:BmobSNSPlatformSinaWeibo block:^(BmobUser *user, NSError *error) {
                   NSLog(@"---------%@",error.description);
                   NSLog(@"微博账户名字:%@,图像:%@",userInfo.name,userInfo.iconurl);
                   [self bmobSetName:userInfo.name andSetImagename:userInfo.iconurl];
////                    [tencentOAuth getUserInfo];
             }];

//              [self bmobSetName:userInfo.name andSetImagename:userInfo.iconurl];

            }

        }];
        
    }
    }
    
}
//qq代理
#pragma mark---qq登入代理方法
//获取到accessToken,和openid代表陈宫了，存起来用的时候直接用，或者请求服务器接口，获取我们项目中用到的usersession
-(void)tencentDidLogin{
//    5b8c9c7412
          NSString *actoken =tencentOAuth.accessToken;
          NSString *uid = tencentOAuth.openId;
          NSDate *expiresdate = tencentOAuth.expirationDate;
//    NSLog(@"--qq时间%@",expiresdate);
          NSDictionary *dic = @{@"access_token":actoken,@"uid":uid,@"expirationDate":expiresdate};

    [self Bmobto_kendic:dic and:YES];
    //用户基本信息
//     [tencentOAuth getUserInfo];
    
    
   
    
    
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
//        NSLog(@"取消登录");
        [self hudstring:@"已取消登录"];
    }
    
}
-(void)tencentDidNotNetWork{
//    NSLog(@"tencentDidNotWork");
    
}
//qq获取个人信息
-(void)getUserInfoResponse:(APIResponse *)response{

 
   

        NSDictionary *jsdata = response.jsonResponse;
//    NSLog(@"%@",response.jsonResponse[@"nickname"]);
    [self bmobSetName:jsdata[@"nickname"] andSetImagename:jsdata[@"figureurl_qq_2"]];


    
    
}



-(void)dengrubtnonClick{
    

    BOOL s = [self isIphonestring:iphonetextfield.text];
    if (s==YES&&pawdtextfield.text.length !=0) {
//        NSLog(@"可以登入");
         [self bmob_iphonetext:iphonetextfield.text andbmob_pawtext:pawdtextfield.text];

    }else{
        [self hudstring:@"手机号码或密码错误"];

    }
    
    
    
}
-(void)zhucebtnonClick{
    
//    NSLog(@"注册界面跳转");
    ZuCeViewController *zuvc = [[ZuCeViewController alloc]init];
    zuvc.iszeceOrdengru = YES;
    zuvc.delegate = self;
    [self.navigationController pushViewController:zuvc animated:YES];
}

#pragma mark----点击界面其他位置键盘下移
//点击界面其他位置键盘退出
-(void)tap{
    
    [iphonetextfield resignFirstResponder];
    [pawdtextfield resignFirstResponder];
    if (pawdtextfield.text.length==0) {
        dengrubtn.userInteractionEnabled = NO;
        [dengrubtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }else{
        dengrubtn.userInteractionEnabled = YES;
        [dengrubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark---textfielddelegate

//是否可以编辑
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"1");
    return YES;
}
//已经进入编辑状态
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:pawdtextfield]) {
        dengrubtn.userInteractionEnabled = YES;
        [dengrubtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        dengrubtn.userInteractionEnabled = NO;
        [dengrubtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
//    NSLog(@"我进入编辑了");
}
//点击键盘上的return时候出发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    BOOL s = [self isIphonestring:iphonetextfield.text];
    if (s==YES&&pawdtextfield.text.length !=0) {

        [self bmob_iphonetext:iphonetextfield.text andbmob_pawtext:pawdtextfield.text];


  }else{
//
       [self hudstring:@"手机号码或密码错误"];
  }
    //回收键盘
    [textField resignFirstResponder];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

}

//能够实时获取到text的输入信息
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"%@",textField.text);
    return YES;
}



-(void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)rightClick{
    ZuCeViewController *zuvc = [[ZuCeViewController alloc]init];
    zuvc.iszeceOrdengru = NO;
    zuvc.delegate=self;
    [self.navigationController pushViewController:zuvc animated:YES];
    
}
//判断手机号和密码
-(BOOL)isIphonestring:(NSString *)str{
    
    if (str.length != 11) {

        return NO;
    }else{
        if ([str hasPrefix:@"1"]) {

            return YES;
        }else{

            return NO;
        }
        
    }
    return nil;
}
//注册成功以后返回根界面代理
-(void)zuceDelegate:(NSString *)ismiss{
    if ([ismiss isEqualToString:@"1"]) {
        [self leftClick];
        
    }
    
}
-(void)hudstring:(NSString *)str{
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor orangeColor];
    [hud hideAnimated:YES afterDelay:2.0];
}
-(void)hud{
    
      hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      hud.mode = MBProgressHUDModeIndeterminate; //菊花;
     hud.removeFromSuperViewOnHide = YES;
}


//qq第三方登入用ken来穿件id
-(void)Bmobto_kendic:(NSDictionary *)dic and:(BOOL)isQorB{
    
    
    
    [BmobUser signUpInBackgroundWithAuthorDictionary:dic platform:BmobSNSPlatformQQ block:^(BmobUser *user, NSError *error) {
        //        NSLog(@"---------");
       [tencentOAuth getUserInfo];
    }];
    
}
//第三方登入bmob存接口
-(void)bmobSetName:(NSString *)user_name andSetImagename:(NSString *)user_imagename{
    
    
      BmobUser *us = [BmobUser currentUser];
        [us setObject:user_imagename forKey:@"userimagename"];
        [us setUsername:user_name];
        

    [us updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            [hud hideAnimated:YES];
       [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengru" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];

            
        }else{
            [hud hideAnimated:YES];
            [self hudstring:@"登录失败"];
        }
    }];
    
    
}
//手机登入
-(void)bmob_iphonetext:(NSString *)iptext andbmob_pawtext:(NSString *)patext{
    
    
    [BmobUser loginInbackgroundWithAccount:iptext andPassword:patext block:^(BmobUser *user, NSError *error) {
        if (user!=nil) {

            [self hudstring:@"成功登录"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengru" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
          
        }else{
            [self hudstring:@"该用户还没有注册"];
            
        }
    }];
    
}



@end
