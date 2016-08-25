//
//  MapCell.h
//  YuCheng
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) UILabel *addLabel;

@property (nonatomic, copy) NSString *addressStr;

@end
