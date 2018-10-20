//
//  ListViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-2.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//
//漫画分类界面
#import "ListViewController.h"
#import "ListeCell.h"
#import "ListeModel.h"
#import "FenLeiViewController.h"
#import "CacheManager.h"
@interface ListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

 UICollectionView *_collectionView;
 
}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addleftandrightbtn];
    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
     self.automaticallyAdjustsScrollViewInsets =NO;
    [self addleftandrightbtn];
    [self configUI];
    [self NSNotiCache];
    [self loadData];
//    [self preData];
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_CH object:nil];
    
}
-(void)NSNotiCache
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(remove:) name:_CH object:nil];
    
}
//通知
-(void)remove:(NSNotification *)not
{
    
    NSInteger index = [not.userInfo[@"tag1"]integerValue];
    if (index==1) {
        [[CacheManager manager]removeItematPAth:URL_SPECIES];
    }
}

-(void)configUI
{
    //这个只有3个属性一个是设置水平还是竖直方向,还有是横向间距,纵向间距
    //UICollectionViewFlowLayout是用来控制UICollectionView布局的类,她的父类是UICollectionViewLayout,这个是控制布局的父类,一般都用子类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向一共2个方向:Vertical这个是竖直方向,,Horizontal这个是水平方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //这个是设置横向间距
    flowLayout.minimumLineSpacing =10;
    //设置纵向间距
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat iswithd;
    if (kDevice_Is_iPhoneX ==YES){
        iswithd=64;
        
    }else{
        iswithd=49;
        
    }
    
    
    
    
    //注意:当竖直滚动的时候,横向间距是直接生效的,纵向间距是根据(UIEdgInset 和cell尺寸加minimumInteritemSpacing)来调控的.
    
    //根据尺寸和flowLayout来创建UICollectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width-20, [UIScreen mainScreen].bounds.size.height-64-iswithd) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    // _collectionView.showsHorizontalScrollIndicator =NO;
    _collectionView.showsVerticalScrollIndicator= NO;
   
    [_collectionView registerNib:[UINib nibWithNibName:@"ListeCell" bundle:nil] forCellWithReuseIdentifier:@"lisecell"];
    
    
}
-(void)preData
{
//    if ([[CacheManager manager]isExists:URL_SPECIES]) {
//        //如果没有就就下载
//        NSLog(@"我有缓存哦");
//        NSData *data = [[CacheManager manager]getCache:URL_SPECIES];
//
//        id res= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        if ([res isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dataDic = res[@"data"];
//            NSDictionary *returnData = dataDic[@"returnData"];
//            NSArray *rankinglist = returnData[@"rankinglist"];
//            for (NSDictionary *dic1 in rankinglist) {
//                ListeModel *model = [[ListeModel alloc]initWithDictionary:dic1 error:nil];
//                [_dataArray addObject:model];
//            }
//            [_collectionView reloadData];
//        }
//    }else{
//        [self loadData];
//    }
}
-(void)loadData
{
[[HttpManager shareManager]requestWithUrl:URL_SPECIES withDictionary:nil withSuccessBlock:^(id responseObject) {

    
    NSDictionary *dataDic = responseObject[@"data"];
    NSDictionary *returnData = dataDic[@"returnData"];
    NSArray *rankinglist = returnData[@"rankinglist"];
    for (NSDictionary *dic1 in rankinglist) {
        ListeModel *model = [[ListeModel alloc]initWithDictionary:dic1 error:nil];
        
        [_dataArray addObject:model];

    }
    [_collectionView reloadData];
} withFailureBlock:^(NSError *error) {
   
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络死掉了？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [self.view addSubview:alert];
    [alert show];
}];
    
    

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *cellId = @"lisecell";
    ListeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    ListeModel *model = _dataArray[indexPath.row];
    cell.lisetTitle.text = model.sortName;
    cell.backgroundColor = [UIColor redColor];
    [cell.listeImageview sd_setImageWithURL:[NSURL URLWithString:model.cover]placeholderImage:[UIImage imageNamed:@"recommend_comic_default@2x"]];
   return cell;
    
}
//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   CGFloat width = self.view.frame.size.width;

    if (width==320) {
        return CGSizeMake(90, 90);
    }if (width==375) {
   
        return CGSizeMake(108, 108);
    }else {
        return CGSizeMake(121, 121);
    }
   
    return CGSizeMake(0, 0);
}
//bi
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 8, 10, 8);
//}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenLeiViewController *fenVC = [[FenLeiViewController alloc]init];
    fenVC.title =[_dataArray[indexPath.row]sortName];
    fenVC.bookId = [_dataArray[indexPath.row]argValue];
    fenVC.argName = [_dataArray[indexPath.row]argName];
//    NSLog(@"---%@----%@---%@",fenVC.title,fenVC.bookId,fenVC.argName);
    [self.navigationController pushViewController:fenVC animated:YES];
//    NSLog(@"%ld",indexPath.row);

}
@end
