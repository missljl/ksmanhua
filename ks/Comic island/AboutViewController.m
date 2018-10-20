//
//  AboutViewController.m
//  AutoHome
//
//  Created by ZK on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AboutViewController.h"

#import "MBProgressHUD.h"

#import <BmobSDK/Bmob.h>
#import "DengLuViewController.h"
@interface AboutViewController ()<UITextFieldDelegate>
//
//@property(nonatomic,strong)UIButton *leftbtn;
//@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UITextField *Fieldtext;

@end

@implementation AboutViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"意见反馈";
     [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:16], NSFontAttributeName, nil]];
    [self addBarBtnItemWithTitle:@"" withImageName:@"SettingBack_t@2x" withPosition:LEFT_BARITEM];
    [self addBarBtnItemWithTitle:@"提交" withImageName:@"" withPosition:RIGHT_BARITEM];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self yijianUI];
    
    
//    self.navigationItem.title=@"关于爱漫画";
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0*RATE, 64, SCREEN_WIDTH*RATE, 200)];
//    view.backgroundColor=[UIColor whiteColor];
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(125*RATE, 60, 70*RATE, 70)];
//    imageView.image=[UIImage imageNamed:@"mine_commic_icon"];
//
//    imageView.layer.cornerRadius=10;
//    imageView.layer.masksToBounds=YES;
//    [view addSubview:imageView];
//
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0*RATE, 130, 320*RATE, 20)];
//    label.text=@"版本 1.0.0 ";
//
//    label.textAlignment=NSTextAlignmentCenter;
//    label.font=[UIFont systemFontOfSize:12];
//    [view addSubview:label];
//
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(60*RATE,160, 200*RATE, 30)];
//    label2.textAlignment=NSTextAlignmentCenter;
//    label2.text=@"爱漫画,画漫画,有漫画的生活真好";
//    label2.font=[UIFont systemFontOfSize:14];
//    [view addSubview:label2];
//
//
//
//    [self.view addSubview:view];
//
    
    
    
}
-(void)yijianUI{
    
    _Fieldtext = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height/2)];
    
    _Fieldtext.borderStyle = UITextBorderStyleRoundedRect;
    
    
    _Fieldtext.placeholder = @"在这里输入你要说的话";
    _Fieldtext.textColor = [UIColor lightGrayColor];
    _Fieldtext.textAlignment = NSTextAlignmentLeft;
    
    _Fieldtext.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _Fieldtext.font = [UIFont systemFontOfSize:15];
    
    _Fieldtext.delegate = self;
    _Fieldtext.clearsOnBeginEditing = YES;
    
    _Fieldtext.keyboardType = UIKeyboardAppearanceDefault;
    
    _Fieldtext.returnKeyType = UIReturnKeySend;
    [self.view addSubview:_Fieldtext];
    
    [_Fieldtext becomeFirstResponder];
    
}

-(void)leftClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightClick{
//    NSLog(@"判断有没有登入");
    if (_Fieldtext.text.length<=0) {

        [self hudstring:@"主人给点意见吧"];
        
        
    }else{
        BmobUser *usr =[BmobUser currentUser];
         [_Fieldtext  resignFirstResponder];
        if (usr!=nil) {
//            NSLog(@"发送完成跳转");
            [self hudstring:@"正在提交....."];
            [usr setObject:_Fieldtext.text forKey:@"yijian"];
            [usr updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (!error) {
                    [self hudstring:@"我们收到了辛苦了"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    
                    [self hudstring:@"发送失败"];
                }
                
            }];
            
            
        }else{
            
            DengLuViewController *dengruvc = [[DengLuViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dengruvc];
            dengruvc.modalTransitionStyle =0;
            [self presentViewController:nav animated:YES completion:nil];
            
        }
        
        
   
        
    }
    
}
-(void)hudstring:(NSString *)str{
    
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = str;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor orangeColor];
    [hud hideAnimated:YES afterDelay:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
