//
//  BaseViewController.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//
// 30000+ 购物袋delegateView
// 40000+ 我的订单payButton
// 50000+ 确认订单delegateView
// 20000+ 分类
// 15000+ 精品推荐图片
// 100000+ 详情渐变背景

//   支付功能   玉城客服

// 美国国家广播公司(NBC)提供奥运会虚拟现实节目
// eBay与澳大利亚零售商Myer合作将打造全球首个虚拟现实百货店铺。
// VR Pay
// 游戏 影视 医疗
//
//
//
//
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    // 导航栏设置
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]}];
	
	//用于去除导航栏的底线，也就是周围的边线
	[[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
	[self.navigationController.navigationBar setShadowImage:[UIImage new]];



	// 导航栏左侧按钮
	self.leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_leftItemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 25, UNITHEIGHT * 25);
	[_leftItemButton setBackgroundImage:[UIImage imageNamed:@"yc-22"] forState:UIControlStateNormal];
	[_leftItemButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftItemButton];

	// 右侧
//	self.rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	_rightItemButton.frame = CGRectMake(0, 0, UNITWIDTH * 22, UNITHEIGHT * 22);
//	[_rightItemButton setBackgroundImage:[UIImage imageNamed:@"yc-10"] forState:UIControlStateNormal];
//	[_rightItemButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
//
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightItemButton];


	
	// 点击空白
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSpace)];
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];



	// 右滑返回
	UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
	rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
	[self.view addGestureRecognizer:rightSwipe];
}



- (void)leftItemAction:(UIButton *)button {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButton:(UIButton *)button {

}



#pragma mark - 点击空白
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch.view isKindOfClass:[UITextField class]])
	{
	 return NO;
	}
	// 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
	if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
		[self.view endEditing:YES];
		return NO;
	}
	if ([NSStringFromClass([touch.view class]) isEqualToString:@"ProvinceView"]) {
		return NO;
	}
	if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]) {
		return NO;
	}
	return YES;
}

- (void)tapSpace {
	[self.view endEditing:YES];
}



#pragma mark - 右滑返回
- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe {
	[self.navigationController popViewControllerAnimated:YES];
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
