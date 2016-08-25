//
//  AddAddressVC.h
//  YuCheng
//
//  Created by apple on 16/6/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"

@interface AddAddressVC : BaseViewController

@property (nonatomic, assign) BOOL isRevise;

@property (nonatomic, copy) NSString *address_id;

@property (nonatomic, strong) AddressModel *model;

@property (nonatomic, copy) NSString *isDefaultID;

@end
