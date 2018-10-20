//
//  LJLSeachbar.m
//  9.28爱限免1
//
//  Created by qianfeng on 15-9-29.
//  Copyright (c) 2015年 lijinlong. All rights reserved.
//

#import "LJLSeachbar.h"

@implementation LJLSeachbar
{
    UISearchBar *_searchBar;
    NSString *_placeholder;
    UIView *_bgview;//这个是朦层
    //定义代理,遵从协议
    id<LJLSeachbarDelegate> _delegate;
    
    
    UITableView *SearTableview;
    NSArray *SearArray;
    

}

-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id<LJLSeachbarDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _placeholder = placeholder;//这个是显示的文字
        [self configView];
        [self showInView];
        _delegate =delegate;//协议

        
    }
    return self;
}
-(void)configView
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    
    _searchBar.placeholder = _placeholder;
    //设置收索栏的样式
    _searchBar.delegate = self;//这个是_searchBar的协议
  _searchBar.layer.borderWidth = 0.8;
    _searchBar.layer.borderColor = [UIColor orangeColor].CGColor;
    _searchBar.layer.masksToBounds = YES;
    _searchBar.barTintColor = [UIColor lightGrayColor];
    //取消字体颜色
    _searchBar.tintColor =  [UIColor orangeColor];
    [self addSubview:_searchBar];
}
//
-(void)showInView
{

      _bgview = [[UIView alloc]initWithFrame:CGRectMake(0,44,self.frame.size.width,500)];
    _bgview.userInteractionEnabled = YES;
      [self addSubview:_bgview];
    SearTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,500) style:UITableViewStylePlain];
    SearTableview.delegate = self;
    SearTableview.dataSource = self;
    SearArray = @[@"海贼王",@"火影",@"盗墓笔记",@"死神",@"完美世界",@"镇魂街",@"舞动乾坤"];
    [_bgview addSubview:SearTableview];
    
    
    _bgview.backgroundColor = [UIColor whiteColor];
    _bgview.hidden= YES;
    
    
 
  

}
//secarchBar将要编辑的时候调用的方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //这个是设置cancel按钮是否显示,第一个表示显示,第二个表示动画
    _searchBar.showsCancelButton = YES;
    
    for(id cc in [_searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    [_searchBar setShowsCancelButton:YES animated:YES];
    
    
    
  _bgview.hidden = NO;
    return YES;

}
//这个是当点击键盘上searbarbutton的时候调用的方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [_delegate searchWithKey:_searchBar.text];
    [self hiddenKeyBoard];
   
}
//这个方法是cancel按钮被点击的时候调用的
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hiddenKeyBoard];
    
}




//结束编辑所做的处理
-(void)hiddenKeyBoard{
    //resignFirstResponder让scearchBar取消第一响应者(就是键盘隐藏)
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    [_searchBar setShowsCancelButton:NO animated:YES];
    _bgview.hidden = YES;
    
    
}
#pragma SeartableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return SearArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = SearArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
 
    [_delegate searchWithKey:SearArray[indexPath.row]];
 [self hiddenKeyBoard];
    
}


@end
