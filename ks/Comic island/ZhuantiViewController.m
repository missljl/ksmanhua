//
//  ZhuantiViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//壁纸预览界面
#import "ZhuantiViewController.h"

#import "ZhuanTiCollertionCell.h"
#import "ProjectModel.h"
#import "LJLControl.h"

#import "DengLuViewController.h"
#import <BmobSDK/Bmob.h>


#import "JSHAREService.h"

#import "ShareView.h"



@interface ZhuantiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
   
    NSInteger scrollofsetx;
    
    UICollectionView *collercitonview;
    //标签view
    UIView *bottmview;
    //屏幕预览
    UIImageView *imageview;
    
    UIImageView *potoimageview;
    
}
@property (nonatomic, strong) ShareView * shareView;
@end

@implementation ZhuantiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%ld",_imagearray.count);
  [self configUI];
}
//进入界面前隐藏状态栏
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    //隐藏：YES,  显示：NO,  Animation:动画效果

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

}


//界面推出时显示状态栏
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];

    //隐藏：YES, 显示：NO ,Animation:动画效果

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

}
-(void)configUI
{
    
//    CGFloat iswithd;
//
//    if (kDevice_Is_iPhoneX ==YES){
//        iswithd=22;
//
//    }else{
//        iswithd=0;
//
//    }
    
    
    potoimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:potoimageview];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向一共2个方向:Vertical这个是竖直方向,,Horizontal这个是水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //这个是设置横向间距
   flowLayout.minimumLineSpacing =0;
//    //设置纵向间距
//    flowLayout.minimumInteritemSpacing = 0;
//
    //注意:当竖直滚动的时候,横向间距是直接生效的,纵向间距是根据(UIEdgInset 和cell尺寸加minimumInteritemSpacing)来调控的.

    //根据尺寸和flowLayout来创建UICollectionView
    collercitonview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    collercitonview.delegate = self;
    collercitonview.dataSource =self;
    collercitonview.bounces = NO;
    //分页平移
    collercitonview.pagingEnabled = YES;
    collercitonview.showsVerticalScrollIndicator= NO;
    [self.view addSubview:collercitonview];
    
    [collercitonview registerNib:[UINib nibWithNibName:NSStringFromClass([ZhuanTiCollertionCell class]) bundle:nil] forCellWithReuseIdentifier:@"zhuanticell"];



    //自动定位到某一行
    [collercitonview scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_collectionitemid inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //滑动到点击页scrollview需要用
    scrollofsetx = _collectionitemid*self.view.frame.size.width;
  
 
    [self configSuoPingView];
    [self configbiaoqianlanView];
}
//锁屏imageview
-(void)configSuoPingView{
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    imageview.backgroundColor = [UIColor redColor];
    imageview.image = [UIImage imageNamed:@"preview_cover_home"];
    imageview.userInteractionEnabled= YES;
    imageview.alpha = 0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [imageview addGestureRecognizer:tap];
    [self.view addSubview:imageview];
    [self.view bringSubviewToFront:imageview];
}
//4个标签按钮
-(void)configbiaoqianlanView{
    //标签view
    bottmview = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    bottmview.backgroundColor = [UIColor blackColor];
    bottmview.alpha = 0.5;
    
    NSArray *btnimagear = @[@"fanhui",@"yanjing",@"xiazai",@"actionbar_share"];
    
    CGFloat btnspex = (self.view.frame.size.width-44*4)/5;
    for (NSInteger i=0; i<btnimagear.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnspex+(44+btnspex)*i, 2.5,44, 44)];
    [btn setImage:[UIImage imageNamed:btnimagear[i]] forState:UIControlStateNormal];
        
    btn.tag = 100+i;
    [btn addTarget:self action:@selector(btnCilck:) forControlEvents:UIControlEventTouchUpInside];
        
        
    [bottmview addSubview:btn];
    }
    
    [self.view addSubview:bottmview];
    [self.view bringSubviewToFront:bottmview];
}
//点击锁屏图片时逻辑
-(void)tap{
    
    imageview.alpha = !imageview.alpha;
    bottmview.hidden = !bottmview.hidden;
}
//标签按钮逻辑
-(void)btnCilck:(UIButton *)btn{
    
    switch (btn.tag) {
        case 100:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 101:
            imageview.alpha = !imageview.alpha;
       
            break;
        case 102:{
            BmobUser *user = [BmobUser currentUser];
            if (user!=nil) {
                NSInteger pototeger = (long)(scrollofsetx/self.view.frame.size.width);
               ProjectModel *model =_imagearray[pototeger];
                [potoimageview sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
                UIImageWriteToSavedPhotosAlbum(potoimageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
            }else{
                DengLuViewController *dvc = [[DengLuViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
                dvc.modalTransitionStyle =0;
                [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }
            break;
        case 103:{
            BmobUser *user = [BmobUser currentUser];
            if (user!=nil) {
//                NSLog(@"----分享出去");
                  [self.shareView showWithContentType:1];
            }else{
            DengLuViewController *dvc = [[DengLuViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
            dvc.modalTransitionStyle =0;
            [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }
            
            break;
        default:
            break;
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagearray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhuanTiCollertionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zhuanticell" forIndexPath:indexPath];
    
    //NSDictionary *dicstring = _imagearray[indexPath.row];
    
    ProjectModel *model =_imagearray[indexPath.row];
    [cell.zhuantiimageivew sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    
    return cell;
}
#pragma mark ----  点击item的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    [UIView animateWithDuration:1 animations:^{

        bottmview.hidden = !bottmview.hidden;
        imageview.alpha = !imageview.alpha;
    }];
    
   
    //这里要
    
    //    [self.dataArr removeObjectAtIndex:indexPath.item];
    //TODO:  这个方法 特别注意 删除item的方法
    //    [self.myCollectionView deleteItemsAtIndexPaths:@[indexPath]];
}
//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    
}

//这个地方只做一个提示的功能
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"下载失败"
                                                       message:@"请打开 设置-隐私-照片 来进行设置"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        
        [alert show];

    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"下载成功"
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
//        NSLog(@"%@",image);
//        NSLog(@"保存成功");
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    scrollofsetx=scrollView.contentOffset.x;

    
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
    NSInteger pototeger = (long)(scrollofsetx/self.view.frame.size.width);
   ProjectModel *model =_imagearray[pototeger];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.thumb]];
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;

    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];
}


@end
