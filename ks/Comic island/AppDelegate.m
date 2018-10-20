//
//  AppDelegate.m
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//



//bmob短信验证和后台用户平台
#define BMOBSDK_APPID @"bf91179b8487b95ad0d060c45111624e"

//qq appid：1106525555  key：Gb23zzqMG2HktWeS
#define QQAPIID @"1106525555"
#define QQKEY @"Gb23zzqMG2HktWeS"



//微信


//微博
#define WB_KEY @"3138601916"
#define WB_APP_SECRET @"f5f054b8fd0b68554cb10117d3ee571e"



#import "AppDelegate.h"
#import "MyViewController.h"



#import <BmobSDK/Bmob.h>
//腾讯
#import <TencentOpenAPI/TencentOAuth.h>

//极光分享
#import "JSHAREService.h"

//极光推送
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    
    
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    
    
    //极光推送比较耗时
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"ffbff1c88e2f87a4da8c368a"
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
//            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
//            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    
    

  
    
    
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    _tabvc = [[MyTabViewController alloc]init];
  
    MyViewController *myvc = [[MyViewController alloc]init];

    self.LeftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:myvc andMainView:_tabvc];
    self.window.rootViewController = self.LeftSlideVC;
    
      application.applicationIconBadgeNumber = 0;
   //开启并行队列
//    dispatch_queue_t que = dispatch_queue_create(" ",DISPATCH_QUEUE_CONCURRENT);
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //异步
    __weak __typeof(&*self) weakSelf=self;
    dispatch_async(queue, ^{
        [weakSelf initBmob];
        [weakSelf initJGshare];
        
    });
    
    return YES;
}
-(void)initBmob{
    //后台比较耗时 要开线程
    [Bmob registerWithAppKey:BMOBSDK_APPID];
    
}
-(void)initJGshare{
    
    //极光推送比较耗时
    //极光分享 比较耗时
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc]init];
    config.appKey = @"ffbff1c88e2f87a4da8c368a";
    config.SinaWeiboAppKey = @"3138601916";
    config.SinaWeiboAppSecret = @"f5f054b8fd0b68554cb10117d3ee571e";
    config.SinaRedirectUri = @"http://www.baidu.com";
    config.QQAppId = QQAPIID;
    config.QQAppKey =QQKEY;
    config.WeChatAppId = @"wx0105fa0fa5ed69a1";
    config.WeChatAppSecret = @"f5f8951ca735ea62202c795b3957fae5";
    config.isSupportWebSina = YES;
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:YES];
    
  
    
}

//app失去激活状态的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    
//    [[UIScreen mainScreen] setBrightness: 0.66];//0.5是自己设定认为比较合适的亮度值
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//Openurl 第三方登入回调
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [JSHAREService handleOpenUrl:url];
    return [TencentOAuth HandleOpenURL:url];
    
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
      [JSHAREService handleOpenUrl:url];
    return [TencentOAuth HandleOpenURL:url];
}


//获取ken 极光
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    NSLog(@"-----------completionHandiler %ld",completionHandler);
    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
   
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    completionHandler(UNNotificationPresentationOptionBadge);
//    NSLog(@"%ld",UNNotificationPresentationOptionBadge);
     NSDictionary * userInfo = notification.request.content.userInfo;
//   NSLog(@"--------------------------<<>>>>>>>>%@",userInfo);
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        /// iOS10处理远程推送
        [JPUSHService handleRemoteNotification:userInfo];
//        pushDic = userInfo;
        /// 应用处于前台收到推送的时候转成本地通知 ===========================
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        NSDictionary *dic = userInfo[@"aps"];
        notification.alertTitle =dic[@"alert"];
       
//       notification.alertBody =@"aaaaaa";
        notification.userInfo = userInfo;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else{
//        NSLog(@"++++++++++++++++++++++++++");
        /// 应用处于前台收到本地通知不会出现在通知中心 借用极光推送的方法将本地通知添加到通知栏 ==============================
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    }
    
    
    
    
    
    
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}
 /// 程序运行于前台，后台 或杀死 点击推送通知 都会走这个方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
//   NSLog(@"zzzzzzzzzzzzzz%@");
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//   NSLog(@"$$$$$$$$$$$$$$$$$$");
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//       NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^");
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
