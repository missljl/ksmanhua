//
//  GRZliaoViewController.m
//  Comic island
//
//  Created by 1111 on 2017/12/12.
//  Copyright © 2017年 李金龙. All rights reserved.
//从上一个界面传过来2个参数一个图片，一个昵称
//修改个人资料 左边按钮，右边发送按钮，一个图像，一个昵称，一个性别
#import "GRZliaoViewController.h"
#import "UIImageView+WebCache.h"
#import "ValuePickerView.h"

#import "DatePicekView.h"

#import <BmobSDK/Bmob.h>
#import "MBProgressHUD.h"
#define COLOR_BACKGROUD_GRAY    [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1]

@interface GRZliaoViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    
    //头像 要有点击事件颜色灰色
    UIView *_Headview;
    UIImageView *_Headimageview;
    
    
    
    //昵称 白色 textfield
    UITextField *NameTextfield;
    //性别 按钮 选择器

   UIButton *Xingbiebtn;
    //生日也是选择器
    UIButton *shengribtn;
    //性别选择器
    ValuePickerView *picekview;
    //生日选择器
    DatePicekView *datepicekview;
    //判断如果有地方改过那么返回上一界面的时候提示用户存
    BOOL isgai;
    
    MBProgressHUD *hud;
}


@end

@implementation GRZliaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUD_GRAY;
    self.title = @"编辑资料";
    isgai = NO;
    [self configLeftBtn];
    
    [self configUIHeaderV];
    
    [self configUINameTextfield];
   
}
#pragma mark---头像框
-(void)configUIHeaderV{
    _Headview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.width/2)];
    _Headview.backgroundColor = COLOR_BACKGROUD_GRAY;
    [self.view addSubview:_Headview];
    
    _Headimageview = [[UIImageView alloc]initWithFrame:CGRectMake(_Headview.frame.size.width/2-(_Headview.frame.size.height/2)/2, _Headview.frame.size.height/2-(_Headview.frame.size.height/2)/2,_Headview.frame.size.height/2, _Headview.frame.size.height/2)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headtap)];
    [_Headimageview addGestureRecognizer:tap];
    
    [_Headimageview sd_setImageWithURL:[NSURL URLWithString:_headerimagename]];
    [_Headimageview.layer setCornerRadius:_Headimageview.frame.size.width/2];
    [_Headimageview.layer setMasksToBounds:YES];
    _Headimageview.userInteractionEnabled = YES;

    [_Headview addSubview:_Headimageview];
    
}
//头像点击手势
-(void)headtap{
    
    UIAlertController *alercoller =[UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //分别按顺序放入每个按钮；
    [alercoller addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        
//          NSLog(@"相册");
         [self takePhotoOrPhotos:NO];
        
    }]];
    
    [alercoller addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
//         NSLog(@"相机");
        [self takePhotoOrPhotos:YES];
        
    }]];
    
    
    [alercoller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
//       NSLog(@"取消");
    }]];
    //弹出提示框；
    [self presentViewController:alercoller animated:true completion:nil];

    
}


//其他控件
-(void)configUINameTextfield{
    
    NameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_Headview.frame), self.view.frame.size.width-20, 40)];
    NameTextfield.delegate = self;
    NameTextfield.text = _nametitle;
    NameTextfield.font = [UIFont systemFontOfSize:15];
    NameTextfield.backgroundColor = [UIColor whiteColor];
    NameTextfield.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 39.5)];
    //左侧按钮图标一直出现
    NameTextfield.leftViewMode = UITextFieldViewModeAlways;
    UILabel *leftlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 39.5)];
    leftlable.text = @"昵称";
      leftlable.font = [UIFont systemFontOfSize:15];
    NameTextfield.enabled = YES;
    leftlable.textAlignment = NSTextAlignmentCenter;
    [NameTextfield.leftView addSubview:leftlable];
    //编辑时出现x👌
    NameTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
  [self.view addSubview:NameTextfield];
    
    
 //性别框
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(NameTextfield.frame)+5,60, 39.5)];
    lable.text = @"性别";
    lable.font = [UIFont systemFontOfSize:15];
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    Xingbiebtn = [[UIButton alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(NameTextfield.frame)+5,self.view.frame.size.width-80, 39.5)];
    //字体左对齐
    Xingbiebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [Xingbiebtn setTitle:@"未选择" forState:UIControlStateNormal];
    [Xingbiebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Xingbiebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    Xingbiebtn.backgroundColor = [UIColor whiteColor];
    [Xingbiebtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Xingbiebtn];
    
    picekview = [[ValuePickerView alloc]init];
    
    
    
    //生日框
    UILabel *shengrilable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(Xingbiebtn.frame)+5,60, 39.5)];
    shengrilable.text = @"生日";
    shengrilable.font = [UIFont systemFontOfSize:15];
    shengrilable.backgroundColor = [UIColor whiteColor];
    shengrilable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shengrilable];
    
    shengribtn = [[UIButton alloc]initWithFrame:CGRectMake(70, CGRectGetMaxY(Xingbiebtn.frame)+5,self.view.frame.size.width-80, 39.5)];
    //字体左对齐
    shengribtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    但是问题又出来，此时文字会紧贴到做边框，我们可以设置
    //    btn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [shengribtn setTitle:@"未选择" forState:UIControlStateNormal];
    [shengribtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shengribtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shengribtn.backgroundColor = [UIColor whiteColor];
    [shengribtn addTarget:self action:@selector(shengribtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shengribtn];
    
  
    datepicekview = [[DatePicekView alloc]init];
    

    

    
    
    
    
}
#pragma mark----性别按钮点击事件
-(void)btnClick:(UIButton *)btn{
    
    [NameTextfield resignFirstResponder];
    
    picekview.dataSource = @[@"男",@"女"];
                    __weak typeof(Xingbiebtn) weakSelf = Xingbiebtn;
                picekview.valueDidSelect = ^(NSString *value){
                    NSArray * stateArr = [value componentsSeparatedByString:@"/"];
                    [weakSelf setTitle:stateArr[0] forState:UIControlStateNormal];
                    //昵称改过
                    isgai = YES;
    
                };
    
                [picekview show];
    
}
#pragma mark---生日按钮点击事件
-(void)shengribtnClick{

    
    datepicekview.selectDate = @"2015-12-28";
       __weak typeof(shengribtn) weakSelf = shengribtn;
//       __weak typeof(isgai) weakSelf1 = isgai;
    datepicekview.GetSelectDate = ^(NSString *dateStr) {
        [weakSelf setTitle:dateStr forState:UIControlStateNormal];
        //生日改过
        isgai = YES;
    };
      [datepicekview show];
}

#pragma mark---textfielddelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    
        return YES;

    
   
}
//已经进入编辑状态
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:NameTextfield.text]) {
        
    }else{
        //昵称改过
        isgai = YES;
    }
}



#pragma mark----导航栏左右按钮
-(void)configLeftBtn{
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(5, 0, 44, 44);
    [leftbtn setImage:[UIImage imageNamed:@"SettingBack_t@2x"] forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *BarItme = [[UIBarButtonItem alloc]initWithCustomView:leftbtn];
      self.navigationItem.leftBarButtonItem =BarItme;
    
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn.frame = CGRectMake(0, 0, 44, 44);
    [rightbtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rigClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rigBarItme = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem =rigBarItme;
    
}
#pragma mark----左边按钮点击事件
-(void)leftClick{
//    if (isgai==YES) {
//        NSLog(@"提示用户存");
//    }else{
    [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
}
#pragma mark----右边按钮点击事件
-(void)rigClick{
    BmobUser *user = [BmobUser currentUser];
    [user setUsername:NameTextfield.text];
    [user setObject:Xingbiebtn.titleLabel.text forKey:@"xingbie"];
    [user setObject:shengribtn.titleLabel.text forKey:@"shengri"];
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"55" ofType:@"png"];
//    NSData *data = UIImagePNGRepresentation(_Headimageview.image);
    NSData *data = UIImageJPEGRepresentation(_Headimageview.image,0.5);
    BmobFile *bmobFile = [[BmobFile alloc]initWithFileName:@"ss1.png" withFileData:data];
    //提示用户
    [self hudstring:@"正在上传"];
    [bmobFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (error) {
//            NSLog(@"%@",error.description);
        }else{
            [user setObject:bmobFile.url forKey:@"userimagename"];
            [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (!error) {
                    [self hudstring:@"修改成功"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"mydengru" object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }else{
                    
                    [self hudstring:@"失败了"];
                }
                
            }];
            
        }
    }];
   
//    NSLog(@"发送资料以后成功的化返回");
    
}
#pragma mark--拍照，图库相关方法
-(void)takePhotoOrPhotos:(BOOL)isTorP{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    
    picker.sourceType = isTorP?UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
    //    picker.mediaTypes =
    //    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:picker animated:YES completion:nil];
    
    
}
////图库
//-(void)Photos{
//    // 创建UIImagePickerController控制器对象
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//
//    [self presentViewController:picker animated:YES completion:nil];
//
//
//
//
//}

#pragma  mark-- 相机相册代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //相机
    UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
      _Headimageview.image = chosenImage;
    //图片改过
    isgai = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
