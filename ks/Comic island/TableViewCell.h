//
//  TableViewCell.h
//  Comic island
//
//  Created by qianfeng on 15-11-4.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksCell.h"

@protocol centerCellDelegate <NSObject>


@end


@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *booklevelTitle;

@property (weak, nonatomic) IBOutlet UIView *booView;

@property (weak, nonatomic) IBOutlet UIImageView *bookimageview;

//@property(nonatomic,copy)NSArray *CellbooskAarray;
@property (weak, nonatomic) IBOutlet BooksCell *BOOKView;
@property (weak, nonatomic) IBOutlet UIButton *genduobtn;


@end
