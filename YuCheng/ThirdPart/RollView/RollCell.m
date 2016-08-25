//
//  RollCell.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RollCell.h"

@implementation RollCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.picImageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.picImageView];
        
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 40, self.contentView.frame.size.width, 40)];
        [self.contentView addSubview:self.backView];
        self.backView.backgroundColor = [UIColor blackColor];
        self.backView.alpha = 0.5;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 40, self.contentView.frame.size.width, 40)];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        
    }
    return self;
}

@end
