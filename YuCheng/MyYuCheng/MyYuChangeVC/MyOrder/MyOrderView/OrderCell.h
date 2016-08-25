//
//  OrderCell.h
//  YuCheng
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCellDelegate <NSObject>

- (void)payButtonAction:(NSInteger)buttonTag;

@end

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) ShoppingCell *baseCell;
//
//@property (nonatomic, strong) UILabel *stateLabel;// 状态
//
//@property (nonatomic, strong) UILabel *numberLabel;// 订单号
//
//@property (nonatomic, strong) UIButton *payButton;// 付款
//
//@property (nonatomic, assign) id<OrderCellDelegate>delegate;

@end
