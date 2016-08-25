//
//  MyTicketVC.h
//  YuCheng
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"

@protocol MyTicketVCDelegate <NSObject>

// 优惠券返回
- (void)takeTicketID:(NSString *)ticketID ticketName:(NSString *)ticketName NSIndex:(NSInteger)NSIndexRow;

@end

@interface MyTicketVC : BaseViewController

@property (nonatomic, assign) BOOL isMyYuCheng;

@property (nonatomic, strong) NSMutableArray *modelArr;

@property (nonatomic, assign) NSInteger NSIndexRow;

@property (nonatomic, assign) id<MyTicketVCDelegate>delegate;

@end
