//
//  MyYuChengWebVC.m
//  YuCheng
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyYuChengWebVC.h"

@interface MyYuChengWebVC ()

@end

@implementation MyYuChengWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, -20, WIDTH, HEIGHT + 20)];
	[web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]]];
	web.scrollView.bounces = NO;
	[self.view addSubview:web];

	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bt_bg.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	self.navigationController.navigationBar.hidden = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
