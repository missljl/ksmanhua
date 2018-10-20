//
//  MyViewController.m
//  AutoHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyViewController.h"
#import "questionViewController.h"
#import "AboutViewController.h"
#import <MessageUI/MessageUI.h>
//#import "UMSocial.h"
#define UMKEY @"5631e80167e58ebeb90006d5"
#import "Define.h"

#import <BmobSDK/Bmob.h>
#import "DengLuViewController.h"
//个人资料修改界面
#import "GRZliaoViewController.h"
//意见提交
#import "AboutViewController.h"


#import "JSHAREService.h"

#import "ShareView.h"


@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_UpArray;
    
    NSArray *_downArray;
    
    NSMutableArray *_iconArray;
  UIImageView *_iamgeview;
     NSArray *imageArray;
    
    
    UIImageView *headerimageview;
    UIImageView *touxiangimagev;
    UILabel *lable;
    
//    UIImageView *xingbieimageview;
    
}
@property (nonatomic, strong) ShareView * shareView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    

    [super viewDidLoad];
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=-44;
        
    }else{
        iswithd=-22;
        
    }
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    imageArray = @[@"vcircle_top",@"my_fenxiang",@"yijian",@"vcircle_delete",@"vcircle_collect",@"my_banben",@"",@"",@""];
   _downArray=@[@"给我评分",@"分享好友",@"意见反馈",@"清除缓存",@"夜间模式",@"应用版本",@"",@"",@""];
  
  
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,iswithd, self.view.frame.size.width-50, self.view.frame.size.height-iswithd) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self headeriamgev];

    [self.view addSubview:_tableView];



    
}
- (void)viewWillAppear:(BOOL)animated
{
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notAction) name:@"mydengru" object:nil];
}
-(void)notAction{
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        NSString *imagename = [user objectForKey:@"userimagename"];
        NSString *username  =[user objectForKey:@"username"];
        [touxiangimagev sd_setImageWithURL:[NSURL URLWithString:imagename]];
        lable.text = username;
       _tableView.tableFooterView.hidden = NO;
    }else{
//        [touxiangimagev sd_setImageWithURL:[NSURL URLWithString:imagename]];
        lable.text = @"点击头像登录";
        touxiangimagev.image =nil;
        _tableView.tableFooterView.hidden = YES;
    }

}

-(void)headeriamgev{
    
    headerimageview  =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width,_tableView.frame.size.width-50)];
    headerimageview.userInteractionEnabled = YES;
    headerimageview.image = [UIImage imageNamed:@"headerimage.jpg"];
    CGFloat touwitdh = _tableView.frame.size.width/3;
//    CGRectGetMaxY(dengrubtn.frame)+20
   touxiangimagev = [[UIImageView alloc]initWithFrame:CGRectMake(_tableView.frame.size.width/2-touwitdh/2, headerimageview.frame.size.height/2-touwitdh/2, touwitdh, touwitdh)];
    touxiangimagev.backgroundColor = [UIColor whiteColor];
    touxiangimagev.image = [UIImage imageNamed:@"user"];
    [touxiangimagev.layer setCornerRadius:touxiangimagev.frame.size.width/2];
    [touxiangimagev.layer setMasksToBounds:YES];
    touxiangimagev.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touxiangimagetap)];
    [touxiangimagev addGestureRecognizer:tap];
   lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(touxiangimagev.frame)+10,_tableView.frame.size.width,30)];
    lable.text = @"点击头像登录";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    
    [headerimageview addSubview:lable];
    
    
    UIButton *tuchubtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, _tableView.frame.size.width-40,35)];
    [tuchubtn setTitle:@"退出登录" forState:UIControlStateNormal];
    tuchubtn.backgroundColor = [UIColor orangeColor];
    tuchubtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [tuchubtn addTarget:self action:@selector(tuichubtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tuchubtn.layer setCornerRadius:20];
    [tuchubtn.layer setMasksToBounds:YES];
    
      _tableView.tableFooterView=tuchubtn;
    _tableView.tableFooterView.hidden = YES;
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        NSString *imagename = [user objectForKey:@"userimagename"];
        NSString *username  =[user objectForKey:@"username"];
        [touxiangimagev sd_setImageWithURL:[NSURL URLWithString:imagename]];
        lable.text = username;
        _tableView.tableFooterView.hidden = NO;
    }
    
    
    [headerimageview addSubview:touxiangimagev];
    _tableView.tableHeaderView=headerimageview;
    
    
    
    
    
}
-(void)tuichubtnClick{
    
    [BmobUser logout];
    [self notAction];
    
      [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengruTuiChu" object:nil];
    
}


-(void)touxiangimagetap{
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        GRZliaoViewController *grvc = [[GRZliaoViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:grvc];
        grvc.modalTransitionStyle =0;
        
        grvc.nametitle = lable.text;
        grvc.headerimagename = [user objectForKey:@"userimagename"];
        [self presentViewController:nav animated:YES completion:nil];
//        NSLog(@"跳转到修改界面");
        
    }else{
        
        DengLuViewController *dengruvc = [[DengLuViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dengruvc];
        dengruvc.modalTransitionStyle =0;
        [self presentViewController:nav animated:YES completion:nil];
    }

    
    
    
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _downArray.count;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//        return 20;
//
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text=_downArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
    cell.imageView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
//    cell.accessoryType=UITableViewCellAccessoryNone;
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        cell.accessoryType=UITableViewCellAccessoryNone;
        
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
        
        CGFloat size=[self folderSizeAtPath:path];
        
        if (size<=0.02) {
            
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f MB",size];
            cell.detailTextLabel.textColor = [UIColor orangeColor];
        }else{
            cell.detailTextLabel.textColor = [UIColor orangeColor];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2f MB",size];
        }
  
    }
 
    if ([cell.textLabel.text isEqualToString:@"应用版本"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"1.0.0"];
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    }
    if ([cell.textLabel.text isEqualToString:@"夜间模式"]) {
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(_tableView.frame.size.width-60,10, 50, 30)];
        [switchButton setOn:NO];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        switchButton.onTintColor = [UIColor orangeColor];
        [cell addSubview:switchButton];
    }
    
    
    return cell;
}
-(void)switchAction:(id)btn{
    BOOL Ison = [btn isOn];
    CGFloat currentLight = [[UIScreen mainScreen] brightness];
//    NSLog(@"%f",currentLight);
    if (Ison) {
        currentLight = currentLight-0.2;
        [[UIScreen mainScreen] setBrightness: currentLight];
//        NSLog(@"11开");
    }else{
            [[UIScreen mainScreen] setBrightness: 0.6];
//        NSLog(@"222关");
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //清除缓存
    if (indexPath.row==3) {

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"你确定要清除缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        [self.view addSubview:alert];
        [alert show];
        
    }
    //推荐给好友
    
    //评分1246292556
    if (indexPath.row==0) {
        NSDictionary *dic=@{@"d":@"d"};

//       [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com"]];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E7%AE%80%E9%9F%B3%E6%82%A6/id1246292556?mt=8"] options:dic completionHandler:^(BOOL success) {
            
        }];
    }
    if (indexPath.row==2) {
        
        AboutViewController *abvc = [[AboutViewController alloc]init];
       
//        DengLuViewController *dengruvc = [[DengLuViewController alloc]init];
       UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:abvc];
        abvc.modalTransitionStyle =0;
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (indexPath.row ==1) {
           [self.shareView showWithContentType:1];
    }
//    //求书反馈
//    if (indexPath.section==1&&indexPath.row==0) {
//        
//        if ([MFMailComposeViewController canSendMail]) {
//            [self sendEmailAction];
//        }
//        
//    }
    

    
    //关于爱漫画
    if (indexPath.row==5) {
        
//        AboutViewController *about=[[AboutViewController alloc]init];
//        [self.navigationController pushViewController:about animated:YES];
        
    }
    
    
    
}


#pragma mark 清除缓存操作

//计算单个文件大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//记录目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize=0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//清理缓存文件
-(void)clearCache:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
//    [[SDImageCache sharedImageCache] cleanDisk];
//    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}
//    [[SDImageCache sharedImageCache] cleanDisk];
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches"];
    if (buttonIndex == 1) {
        [self clearCache:path];
        [[NSNotificationCenter defaultCenter]postNotificationName:_CH object:nil userInfo:@{@"tag1":@"1"}];
        
        [_tableView reloadData];
    }
    
}
#pragma mark 发送邮件的方法

-(void)sendEmailAction{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc]init];
    [mailCompose setMailComposeDelegate:self];
    [mailCompose setSubject:@"爱漫画——求书反馈"];
    [mailCompose setToRecipients:@[@"xxxx154266797@163.com"]];
    [self presentViewController:mailCompose animated:YES completion:nil];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    
    switch(result){
        case MFMailComposeResultCancelled://用户取消编辑
//            NSLog(@"Cancelled");
            break;
        case MFMailComposeResultFailed://用户发送失败
//            NSLog(@"Failed");
            break;
        case MFMailComposeResultSaved://用户保存邮件
//            NSLog(@"Saved");
            break;
        case MFMailComposeResultSent://用户发送邮件
//            NSLog(@"Send");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            [self shareLinkWithPlatform:platform];
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {

    JSHAREMessage *message = [JSHAREMessage message];
    message.mediaType = JSHARELink;
    message.url = @"https://itunes.apple.com/cn/app/%E7%AE%80%E9%9F%B3%E6%82%A6/id1246292556?mt=8";
    message.text = @"看漫画就上-->看啥漫画";
    message.title = @"看啥漫画app";
    message.platform = platform;
//    NSString *imageURL = @"http://img2.3lian.com/2014/f5/63/d/23.jpg";
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"33" ofType:@"png"];
//    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
//        NSLog(@"分享回调");
        
    }];
    
}

//结束分享后回调的方法
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
//    
//    NSLog(@"%@",response);
//    
//}

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
