//
//  ShoucangViewCell.h
//  Comic island
//
//  Created by 1111 on 2017/12/6.
//  Copyright © 2017年 李金龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookView.h"
@interface ShoucangViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet BookView *Bookview;
@property (weak, nonatomic) IBOutlet UIButton *deletabtn;
@property (weak, nonatomic) IBOutlet UIImageView *bookimageview;
@property (weak, nonatomic) IBOutlet UILabel *booklabel;

@end
