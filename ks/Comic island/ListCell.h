//
//  ListCell.h
//  Comic island
//
//  Created by qianfeng on 15-11-5.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImageview;
@property (weak, nonatomic) IBOutlet UILabel *listTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *listDeltaillable;
@property (weak, nonatomic) IBOutlet UILabel *listlastlabel;

@end
