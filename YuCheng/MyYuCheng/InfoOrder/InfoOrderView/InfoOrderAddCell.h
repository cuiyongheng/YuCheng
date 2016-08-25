//
//  InfoOrderAddCell.h
//  YuCheng
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoOrderModel.h"

@interface InfoOrderAddCell : UITableViewCell

@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) UILabel *addLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIImageView *addImageView;

@property (nonatomic, strong) InfoOrderModel *model;

@end
