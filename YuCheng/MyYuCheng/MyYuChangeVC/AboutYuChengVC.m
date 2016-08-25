//
//  AboutYuChengVC.m
//  YuCheng
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AboutYuChengVC.h"

@interface AboutYuChengVC ()

@end

@implementation AboutYuChengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"关于玉城";

	[self createView];
}

- (void)createView {
	UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register1"]];
	[self.view addSubview:logoImageView];
	[logoImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
	logoImageView.contentMode =  UIViewContentModeScaleAspectFill;
	logoImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	logoImageView.clipsToBounds = YES;

	[logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 140);
		make.width.mas_equalTo(UNITHEIGHT * 120);
		make.top.mas_equalTo(self.view).with.offset(UNITHEIGHT * 100);
	}];

	UILabel *descLabel = [[UILabel alloc] init];
//	descLabel.text = @"致力于服务传统翡翠珠宝实体商家和全球翡翠珠宝消费者的综合性多用户电商平台。打造供给端与消费端共享模式----即整合传统翡翠珠宝行业资源，帮助中缅源头商户及原创玉雕师、珠宝设计师，塑造实体商户线下零售和线上销售互动互补模式，经过权威鉴定和安全速递，让翡翠玉石产品从货源商户直接送到全球消费者手中，为消费者提供大数量、高品质、最时尚、价格透明的一手商品的全方位扁平化的电商服务平台。";
	descLabel.text = @"玉城，是瑞丽市姐告中缅边贸特区内成立最早享受 “境内关外”免税政策的翡翠玉石交易平台。 玉城平台致力于服务传统翡翠珠宝实体商家和全球翡翠珠宝的综合性多用户电商平台。打造供给端与消费端共享模式----即整合传统翡翠珠宝行业资源，帮助中缅源头商户及原创玉雕师、珠宝设计师，塑造实体商户线下零售和线上销售互动互补模式，通过权威鉴定把关和安全有效的速递业务，让翡翠玉石产品从货源商户直接送到全球消费者手中，为消费者提供大数量、高品质、最时尚、价格透明的一手商品的全方位扁平化的电商服务平台。";
	descLabel.numberOfLines = 0;
	[descLabel sizeToFit];
	descLabel.font = font(14);
	descLabel.textColor = [UIColor blackColor];
	[self.view addSubview:descLabel];

	[descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(logoImageView.mas_bottom).with.offset(UNITHEIGHT * 50);
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
	}];

	UILabel *companyLabel = [[UILabel alloc] init];
	companyLabel.text = @"JadeChina.cn\n琞域网络科技有限公司";
	companyLabel.font = font(14);
	companyLabel.textAlignment = NSTextAlignmentCenter;
	companyLabel.numberOfLines = 2;
	[companyLabel sizeToFit];
	[self.view addSubview:companyLabel];

	[companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-UNITHEIGHT * 50);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.tabBarController.tabBar.hidden = NO;
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
