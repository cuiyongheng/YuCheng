//
//  InfoOrderStartVC.m
//  YuCheng
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InfoOrderStartVC.h"
#import "OrderlogisticsHeadView.h"
#import "InfoOrderGoodsModel.h"

@interface InfoOrderStartVC ()

@property (nonatomic, strong) OrderlogisticsHeadView *headView;

@end

@implementation InfoOrderStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"订单详情";

	[self createView];

	[self createData];
}



#pragma mark - createView
- (void)createView {
	self.headView = [[OrderlogisticsHeadView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, UNITHEIGHT * 160)];
	_headView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_headView];

	_headView.startLabel.numberOfLines = 0;
	[_headView.startLabel sizeToFit];

}

#pragma mark - createData
- (void)createData {
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=detail" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		InfoOrderGoodsModel *model = [InfoOrderGoodsModel mj_objectWithKeyValues:responseObject[@"back_order"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			_headView.model = model;
		});

	} Failed:^(NSError *error) {

	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
