//
//  questionViewController.m
//  AutoHome
//
//  Created by ZK on 15/10/28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "questionViewController.h"

@interface questionViewController ()
{
    
    UIWebView *_webView;
}
@end

@implementation questionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationItem.title=@"常见问题";
    
    
    
    
    NSString *str=@"http://app.api.autohome.com.cn/autov5.0.0/Html/UseHelp_iphone.json";
    
    
    
    //创建UIWebView
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0*RATE, 64, SCREEN_WIDTH*RATE, self.view.frame.size.height-64-49)];
    
    NSURL *url=[NSURL URLWithString:str];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    
    //让_webView加载请求
    [_webView loadRequest:request];
    
    
    [self.view addSubview:_webView];
    
    
    
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
