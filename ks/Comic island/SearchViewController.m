//
//  SearchViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-2.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//搜索主界面
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]




#define DEFAULT_VOID_COLOR [UIColor whiteColor]
#import "SearchViewController.h"
#import "SearModel.h"
#import "SearCell.h"
#import "SearView.h"
#import "SearchTwoViewController.h"

@interface SearchViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    UICollectionView *_collectionView;
   
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets =NO;
    [self addleftandrightbtn];
    [self configUI];
    [self loadData];
   [self configSearCh];
    [self configView];
}
-(void)configUI
{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向一共2个方向:Vertical这个是竖直方向,,Horizontal这个是水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width-60)/4,60);
    //这个是设置横向间距
//    flowLayout.minimumLineSpacing =10;
//    //设置纵向间距
//    flowLayout.minimumInteritemSpacing = 5;
    //注意:当竖直滚动的时候,横向间距是直接生效的,纵向间距是根据(UIEdgInset 和cell尺寸加minimumInteritemSpacing)来调控的.
    
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=175;
        
    }else{
        iswithd=145;
        
    }
    
    
    //根据尺寸和flowLayout来创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, iswithd, [UIScreen mainScreen].bounds.size.width-20, 500)collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    // _collectionView.showsHorizontalScrollIndicator =NO;
    _collectionView.showsVerticalScrollIndicator= NO;

    [_collectionView registerNib:[UINib nibWithNibName:@"SearCell" bundle:nil] forCellWithReuseIdentifier:@"searcell"];
}

-(void)configView
{
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=90;
        
    }else{
        iswithd=70;
        
    }
    
    
    UIView *searVC = [[SearView alloc]initWithFrame:CGRectMake(0, iswithd, SCREEN_WIDTH, 30)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [searVC addGestureRecognizer:tap];
    [self.view addSubview: searVC];
    

}
-(void)tapAction:(UITapGestureRecognizer *)tap
{

    SearchTwoViewController *seactwo  =[[SearchTwoViewController alloc]init];
  seactwo.title = @"搜索";
    [self.navigationController pushViewController:seactwo animated:YES];
//    NSLog(@"我是收索");
}
-(void)configSearCh
{
    
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR==YES){
        iswithd=120;
        
    }else{
        iswithd=100;
        
    }
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0*RATE, iswithd, self.view.frame.size.width*RATE, 30)];
    [self.view addSubview:view];
    UIImageView *iamgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 6, 20)];
    iamgview.image = [UIImage imageNamed:@"searchSX"];
    [view addSubview:iamgview];
    
    UILabel *selable = [[UILabel alloc]initWithFrame:CGRectMake(12*RATE, 0, 200*RATE, 29)];
    selable.text = @"热门收索";
    selable.font = [UIFont systemFontOfSize:14];
    [view addSubview:selable];
    
    UIView *vie1 = [[UIView alloc]initWithFrame:CGRectMake(0, 29*RATE, self.view.frame.size.width*RATE, 1)];
    vie1.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:vie1];
    
}
-(void)loadData
{

[[HttpManager shareManager]requestWithUrl:URL_SEARCHE withDictionary:nil withSuccessBlock:^(id responseObject) {
    NSDictionary *Dic1 = responseObject[@"data"];
    NSArray *array = Dic1[@"returnData"];
    for (NSDictionary *dic2 in array) {
        SearModel *seModel = [[SearModel alloc]initWithDictionary:dic2 error:nil];
        [_dataArray addObject:seModel];
    }
    [_collectionView reloadData];
} withFailureBlock:^(NSError *error) {
    

    
}];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"searcell";
    SearCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    SearModel *model = _dataArray[indexPath.row];
    
    cell.searTitleLabel.text = model.tag1;
    cell.searImageview.backgroundColor = [UIColor colorWithRed:0.1 * (arc4random() % 9) green:0.1 * (arc4random() % 9) blue:0.1 * (arc4random() % 9) alpha:0.7];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTwoViewController *TWO = [[SearchTwoViewController alloc]init];
    TWO.Str1 = [_dataArray[indexPath.row] tag1];
    TWO.title = [_dataArray[indexPath.row]tag1];
    [self.navigationController pushViewController:TWO animated:YES];
}

-(UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

//字符串转颜色
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
//    
//    if ([cString length] < 6)
//        return DEFAULT_VOID_COLOR;
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
//    range.location = 0;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
//    range.location = 2;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
//    range.location = 4;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
//    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
    
    
}

//调用:
//[Xxxxx getColor@"FFFFFF"]

@end
