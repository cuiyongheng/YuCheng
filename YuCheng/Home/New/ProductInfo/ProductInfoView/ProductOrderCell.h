//
//  ProductOrderCell.h
//  YuCheng
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductOrderCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

//@property (nonatomic, strong) UILabel *alertLabel;// 提示框
//
//@property (nonatomic, strong) UILabel *dutyLabel;// 关税

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIView *bottonLine;

@property (nonatomic, strong) UILabel *oneLabel;

@property (nonatomic, strong) UILabel *twoLabel;

@property (nonatomic, strong) UILabel *threeLabel;

@property (nonatomic, strong) UILabel *fourLabel;

@property (nonatomic, strong) UILabel *explainOneLabel;// 说明框

@property (nonatomic, strong) UILabel *explainTwoLabel;

@end
