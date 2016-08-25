//
//  ProductTwoCell.h
//  YuCheng
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfoModel.h"

@interface ProductTwoCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *sizeLabel;// 尺寸

@property (nonatomic, strong) UILabel *cololLabel;// 颜色

@property (nonatomic, strong) UILabel *alphaLabel;// 透明度

@property (nonatomic, strong) UILabel *defcetLabel;// 瑕疵

@property (nonatomic, strong) UILabel *productionLabel;// 产地

@property (nonatomic, strong) UILabel *levelLabel;// 工艺水平

@property (nonatomic, strong) UILabel *certificateLabel;// 证书

//@property (nonatomic, strong) UILabel *testingLabel;// 测试证书

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *kucunLabel;

@property (nonatomic, strong) UILabel *shouhouLabel;

@property (nonatomic, strong) UILabel *peisongLabel;

@property (nonatomic, strong) UILabel *bianjiLabel;

@property (nonatomic, strong) UILabel *sheyingLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *peisongTimeLabel;

@property (nonatomic, strong) ProductInfoModel *model;

@property (nonatomic, strong) NSMutableDictionary *modelDic;

@end
