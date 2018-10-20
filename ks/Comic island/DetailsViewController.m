//
//  DetailsViewController.m
//  Comic island
//
//  Created by qianfeng on 15-11-8.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//漫画详情界面

#import "DetailsViewController.h"
#import "DetailModel.h"
#import "LJLControl.h"
#import "DetailTwoModel.h"
#import "ReadviewController.h"
#import "FavoriteManager.h"
#import "YDJlManager.h"

#import "DengLuViewController.h"
#import <BmobSDK/Bmob.h>
@interface DetailsViewController ()<ReadViewDelegate>
{
    UIImageView *_imageivC;
    UILabel *_titlelabel;
    UILabel *_zhuolabel;
    UILabel *_genxinlabel;
    UILabel *_dianjilabel;
    UILabel *_xiangqinglabel;
    UIScrollView *_scrVC;
    DetailModel *detailModel;
    NSMutableArray *_tableArray;
//这个也是等下看看
    NSArray *readArray;
    //这2个变量等下看看要不要
    NSString *readId;
    NSString *readId1;
    NSMutableArray *daoxuArray;
    BOOL _isFavorite;
    NSDictionary *_dic;
    
    
    UIImageView *xiangqingview;
    UIVisualEffectView *effectView;
    
    BOOL _isyudu;
    UIButton *yueudubtn;
}
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableArray = [[NSMutableArray alloc]init];
    daoxuArray = [[NSMutableArray alloc]init];
   [self configUI];
    [self loadData];
   
    
    [self addBarBtnItemWithTitle:@"返回" withImageName:@"" withPosition:LEFT_BARITEM];
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)configUI
{
    
    CGFloat iswithd;
    CGFloat istableheight;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=88;
        istableheight=64;
    }else{
        iswithd=64;
        istableheight=49;
    }
    
    

    
    xiangqingview = [[UIImageView alloc]initWithFrame:CGRectMake(0, iswithd, self.view.frame.size.width, self.view.frame.size.width/2+20)];
    xiangqingview.userInteractionEnabled = YES;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:  UIBlurEffectStyleDark];
       effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
       effectView.alpha =0.99;
        effectView.frame = CGRectMake(0, 0, xiangqingview.frame.size.width, xiangqingview.frame.size.height);
        [xiangqingview addSubview:effectView];
    [self.view addSubview:xiangqingview];
    
    UIColor *textcolor = [UIColor whiteColor];
    
    
    
    _imageivC = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, xiangqingview.frame.size.width/3, (xiangqingview.frame.size.width/3)*1.3)];
    CGFloat heighet =(xiangqingview.frame.size.width/3)*1.3;
    CGFloat s = heighet/5;
    CGFloat jiangjuy = 18;
    CGFloat d = s;
   
    _imageivC.image = [UIImage imageNamed:@""];
    [xiangqingview addSubview:_imageivC];
    
    _titlelabel =[[UILabel alloc]initWithFrame:CGRectMake(_imageivC.frame.origin.x+_imageivC.frame.size.width+5, 10, self.view.frame.size.width-_imageivC.frame.size.width+15, jiangjuy)];
    _titlelabel.text = @"";
    _titlelabel.textColor = textcolor;
    _titlelabel.font = [UIFont systemFontOfSize:17];
    [xiangqingview addSubview:_titlelabel];
    
    _zhuolabel = [[UILabel alloc]initWithFrame:CGRectMake(_titlelabel.frame.origin.x,d+10, _titlelabel.frame.size.width, jiangjuy)];
    _zhuolabel.font = [UIFont systemFontOfSize:14];
    _zhuolabel.text = @"";
    _zhuolabel.textColor =textcolor;
    [xiangqingview addSubview:_zhuolabel];
    
    _genxinlabel = [[UILabel alloc]initWithFrame:CGRectMake(_titlelabel.frame.origin.x, d+d+10, _titlelabel.frame.size.width, jiangjuy)];
    _genxinlabel.text = @"";
    _genxinlabel.font = [UIFont systemFontOfSize:14];
    _genxinlabel.textColor = textcolor;
    [xiangqingview addSubview:_genxinlabel];
    
    
    _dianjilabel = [[UILabel alloc]initWithFrame:CGRectMake(_titlelabel.frame.origin.x, d+d+d+10, _titlelabel.frame.size.width, jiangjuy)];
    _dianjilabel.text = @"";
    _dianjilabel.textColor = textcolor;
    _dianjilabel.font = [UIFont systemFontOfSize:14];
    [xiangqingview addSubview:_dianjilabel];
    

    
    _xiangqinglabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imageivC.frame.size.height+20, (self.view.frame.size.width-15), 20)];
    _xiangqinglabel.numberOfLines = 5;
    _xiangqinglabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _xiangqinglabel.font = [UIFont systemFontOfSize:13];
    _xiangqinglabel.textColor = textcolor;
    _xiangqinglabel.text = @"";
    [xiangqingview addSubview:_xiangqinglabel];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-20, _xiangqinglabel.frame.origin.y, 18, 18)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"comicinfo_icon_down"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnCilck1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [xiangqingview addSubview:btn1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, xiangqingview.frame.origin.y+xiangqingview.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-64-istableheight-xiangqingview.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}
-(void)btnCilck1:(UIButton *)btn1
{
    
    CGFloat iswithd;
    CGFloat istableheight;
    if (kDevice_Is_iPhoneX ==YES||kDevice_Is_iPhoneXR ==YES){
        iswithd=88;
        istableheight=64;
    }else{
        iswithd=64;
        istableheight=49;
    }
    
    if (btn1.selected ==NO) {
        btn1.selected=YES;
        btn1.frame = CGRectMake(self.view.frame.size.width-20, _imageivC.frame.size.height+20, 18, 15);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"comicinfo_icon_up"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
        _xiangqinglabel.frame = CGRectMake(10, _imageivC.frame.size.height+20, (self.view.frame.size.width-15), 60);
         
        xiangqingview.frame = CGRectMake(0, iswithd, self.view.frame.size.width, self.view.frame.size.width/2+20+60);
        CGRect effframe=effectView.frame;
        effframe.size.height = xiangqingview.frame.size.height+100;
        effectView.frame=effframe;
        _tableView.frame = CGRectMake(0, xiangqingview.frame.origin.y+xiangqingview.frame.size.height+10+60, self.view.frame.size.width, self.view.frame.size.height-64-iswithd-xiangqingview.frame.size.height);
        }];
           }else{
        btn1.selected = NO;
        btn1.frame = CGRectMake(self.view.frame.size.width-20, _imageivC.frame.size.height+20, 18, 15);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"comicinfo_icon_down"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
                
        xiangqingview.frame = CGRectMake(0, iswithd, self.view.frame.size.width, self.view.frame.size.width/2+20);
        CGRect effframe=effectView.frame;
        effframe.size.height = xiangqingview.frame.size.height;
        effectView.frame=effframe;
                 
        _xiangqinglabel.frame = CGRectMake(10, _imageivC.frame.size.height+20, (self.view.frame.size.width-15), 20);
        _tableView.frame = CGRectMake(0, xiangqingview.frame.origin.y+xiangqingview.frame.size.height+10, self.view.frame.size.width, self.view.frame.size.height-64-iswithd-xiangqingview.frame.size.height);
               }];
    }

    
}
-(void)loadData
{
    NSString *str1 = @"%205";
    
    NSString *str =[NSString stringWithFormat:@"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%@s&time=1446965471&comicid=%@&",str1,_com_id1];
//    NSLog(@"----------------------%@",str);
[[HttpManager shareManager]requestWithUrl:str withDictionary:nil withSuccessBlock:^(id responseObject) {
    
    NSDictionary *dic =responseObject[@"data"];
    NSDictionary *dic1 = dic[@"returnData"];
    NSDictionary *dic2 = dic1[@"comic"];
    _dic=dic2;
   detailModel = [[DetailModel alloc]initWithDictionary:dic2 error:nil];
    [self fillUI];
} withFailureBlock:^(NSError *error) {
    
}];
    
    NSString *str2 =[NSString stringWithFormat: @"http://app.u17.com/v3/app/ios/phone/comic/detail?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%@s&time=1446965471&comicid=%@&",str1,_com_id1];
    [[HttpManager shareManager]requestWithUrl:str2 withDictionary:nil withSuccessBlock:^(id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        NSDictionary *dic1 = dic[@"returnData"];
        NSArray *array = dic1[@"chapter_list"];
        for (NSDictionary *dic2 in array) {
            DetailTwoModel *model = [[DetailTwoModel alloc]initWithDictionary:dic2 error:nil];
            [_tableArray addObject:model];
            readArray =_tableArray;
            daoxuArray=_tableArray;
        }
        [_tableView reloadData];
    } withFailureBlock:^(NSError *error) {
        
    }];

}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"章节目录"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static  NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    DetailTwoModel *model = _tableArray[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@(%@P)", model.name1,model.image_total];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       DetailTwoModel *model = _tableArray[indexPath.row];
//    NSLog(@"-----------%@",model);
    
    ReadviewController *read = [[ReadviewController alloc]init];
    //分享用到的书图片练级
    read.book_imagename  = detailModel.cover;
    //书简介
    read.book_jianjie = _xiangqinglabel.text;
//书章节名字
                read.BookTitle = model.name1;
//    书名
                read.bookname = detailModel.author_name;
    //书的id
                read.bookid = detailModel.comic_id;
    //书章节id
                read.chid = model.chapter_id;
    //书章节目录
                read.cutaArray=_tableArray;
    read.modalTransitionStyle =1;
    [self presentViewController:read animated:YES completion:^{
        [yueudubtn setTitle:@"继续阅读" forState:UIControlStateNormal];
    }];
    
}
-(void)fillUI
{
    [_imageivC sd_setImageWithURL:[NSURL URLWithString:detailModel.cover]];
    xiangqingview.image = _imageivC.image;
    _titlelabel.text =[NSString stringWithFormat:@"漫画名:%@", detailModel.name];
    
    _zhuolabel.text =[NSString stringWithFormat:@"作者:%@", detailModel.author_name];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"HH:mm:ss";
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"];
    dateFormatter.timeZone=timeZone;
    NSTimeInterval a=[detailModel.last_update_time doubleValue];
    NSDate *currentDate=[NSDate dateWithTimeIntervalSince1970:a];
    NSString *dateStr=[dateFormatter stringFromDate:currentDate];
    _genxinlabel.text=[NSString stringWithFormat:@"更新时间:%@",dateStr];
    _dianjilabel.text = [NSString stringWithFormat:@"点击量:%@",detailModel.click_total];
    _xiangqinglabel.text = [NSString stringWithFormat:@"介绍:%@",detailModel.description1];
    
    _isFavorite = [[FavoriteManager manager]isExists:detailModel.comic_id];
    //    [btn setTitle:_isFavorite?@"取消收藏":@"收藏" forState:UIControlStateNormal];
    _isyudu = [[YDJlManager ydjlManager]isExists:detailModel.comic_id];
    //    NSString *btnstr = _isyudu?@"继续阅读":@"阅读";
    NSArray *ar = @[_isFavorite?@"取消收藏":@"收藏",_isyudu?@"继续阅读":@"阅读"];
    
    NSArray *bgcoar = @[@"allDelete",@"changeUserNameSelect@2x"];

    CGFloat heighet =(xiangqingview.frame.size.width/3)*1.3;
    CGFloat s = heighet/5;
 
  CGFloat d = s;
//    if (self.view.frame.size.width==320) {
//
//        d = 60;
//    }else{
    
//      d = s;
//    }
    
    
    for (NSInteger i=0; i<ar.count; i++) {
        UIButton *btn = [LJLControl creatrButtonTitle:ar[i] imageName:bgcoar[i] tag:100+i target:self action:@selector(btnCilck:) frame:CGRectMake((_titlelabel.frame.origin.x+((10+d*2)+10)*i),d*4+10, d*2+10, d)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (i==1) {
            yueudubtn = btn;
            
        }
        
        [xiangqingview addSubview:btn];
        
        
        
    }
    
    

    
}
-(void)btnCilck:(UIButton *)btn
{
    DetailModel *model = [[DetailModel alloc]init];
    [model setValuesForKeysWithDictionary:_dic];
     DetailTwoModel *modeltwo =[[DetailTwoModel alloc]init];
    BmobUser *user = [BmobUser currentUser];
    if (user!=nil) {
        //这边是点击阅读的逻辑 判断如果登入过那么久跳转，如果没有那么久登入界面跳转
        if (btn.tag==101) {
            ReadviewController *read = [[ReadviewController alloc]init];
            read.book_imagename  = detailModel.cover;
            read.book_jianjie = _xiangqinglabel.text;
            if (_isyudu) {
                DetailModel *model = [[DetailModel alloc]init];
                NSMutableArray *dar = [[NSMutableArray alloc]init];
                dar = [[YDJlManager ydjlManager]allModels];
                for (model in dar) {
                    if (model.comic_id == detailModel.comic_id) {
                        read.BookTitle = model.author_name;
                        read.bookname = model.name;
                        read.bookid = model.comic_id;
                        read.chid = model.cover;
                        read.cutaArray=_tableArray;
                        
                    }
                    
                }
                
            }else{
                modeltwo.chapter_id = [readArray.firstObject chapter_id];
//                readId=modeltwo.chapter_id;
                read.chid = modeltwo.chapter_id;
                read.bookname = model.name;
                read.BookTitle=[readArray.firstObject name1];
                read.cutaArray = readArray;
                read.bookid = model.comic_id;
                _isyudu  =!_isyudu;
                [btn setTitle:@"继续阅读" forState:UIControlStateNormal];
            }
            
            read.modalTransitionStyle =1;
            [self presentViewController:read animated:YES completion:nil];
        }else{
            
            if (model.comic_id.length<=0) {
                //            NSLog(@"没网络");
            }else{
                //            NSLog(@"有网络");
                if (_isFavorite) {
                    [[FavoriteManager manager]deleteModel:model];
                }else{
                    
                    
                    [[FavoriteManager manager]addModel:model];
                    
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"changed" object:nil];
                _isFavorite = !_isFavorite;
                [btn setTitle:_isFavorite?@"取消收藏":@"收藏" forState:UIControlStateNormal];
            }
            
        }
        
       //没登入过跳转登入界面
    }else{
        DengLuViewController *dvc = [[DengLuViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dvc];
        dvc.modalTransitionStyle =0;
        [self presentViewController:nav animated:YES completion:nil];
    }
 
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,30)];
    view.backgroundColor =[UIColor whiteColor];
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(self.view.frame.size.width-30, 0, 30, 30);
    [Btn setImage:[UIImage imageNamed:@"comicinfo_sortBtn"] forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [Btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [Btn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.text = @"章节目录";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    [view addSubview:Btn];
    
    return view;


}
-(void)add:(UIButton *)btn
{
    if (btn.selected==NO) {
        btn.selected=YES;
        _tableArray = (NSMutableArray *)[[_tableArray reverseObjectEnumerator]allObjects];
        [_tableView reloadData];
    }else{
        btn.selected=NO;
        _tableArray=daoxuArray;
        [_tableView reloadData];
    }


}
//阅读界面代理方法（不需要）
-(void)readViewcuiierid:(NSString *)cuid
{
   readId = cuid;
}

@end
