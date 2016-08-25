//
//  InfoOrderCell.h
//  YuCheng
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "infoProductModel.h"

@protocol InfoOrderCellDelegate <NSObject>

// 退款
- (void)refundButton:(NSInteger)buttonTag;

@end

@interface InfoOrderCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) UIButton *refundButton;// 退款

@property (nonatomic, strong) infoProductModel *goodsModel;

@property (nonatomic, assign) id<InfoOrderCellDelegate>delegate;

@end
