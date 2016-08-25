//
//  MyAddressCell.h
//  YuCheng
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@protocol MyAddressCellDelegate <NSObject>

// 删除
- (void)deleteAction:(NSInteger)buttonTag;

// 修改
- (void)reviseAction:(NSInteger)buttonTag;

@end

@interface MyAddressCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *deleteView;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIButton *reviseButton;

@property (nonatomic, strong) UILabel *deleteLabel;

@property (nonatomic, strong) UILabel *reviseLabel;

@property (nonatomic, strong) AddressModel *model;

@property (nonatomic, copy) NSString *defaultAddressStr;

@property (nonatomic, assign) id<MyAddressCellDelegate>delegate;

@property (nonatomic, strong) UIImageView *deleteImageView;

@property (nonatomic, strong) UIImageView *changeImageView;

@end
