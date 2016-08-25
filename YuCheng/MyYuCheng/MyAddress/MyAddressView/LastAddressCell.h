//
//  LastAddressCell.h
//  YuCheng
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LastAddressCellDelegate <NSObject>

- (void)lastIsDefault:(NSInteger)isdefault;

@end

@interface LastAddressCell : UITableViewCell

@property (nonatomic, strong) UILabel *explainLabel;

@property (nonatomic, strong) UIButton *defaultButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, assign) id<LastAddressCellDelegate>delegate;

@end
