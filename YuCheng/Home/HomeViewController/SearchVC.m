//
//  SearchVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchVC.h"
#import "JHCusomHistory.h"
#import "SearchReturnVC.h"

@interface SearchVC ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *hotArr;

@end

@implementation SearchVC

{
	NSString *searchStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self createData];
	
	[self createView];
}



#pragma mark - createData
- (void)createData {
	self.hotArr = [NSMutableArray arrayWithCapacity:0];

	__weak __typeof__(self) weakSelf = self;
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/goodsList.php?act=search" Params:nil Success:^(id responseObject) {

		for (NSDictionary *tempDic in responseObject[@"word_list"]) {
			[_hotArr addObject:tempDic[@"search_word"]];
		}

		NSLog(@"%@", _hotArr);

		// 热搜
		JHCusomHistory *history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 110, WIDTH, HEIGHT - UNITHEIGHT * 110) andItems:_hotArr andItemClickBlock:^(NSInteger i) {

			if (i < _hotArr.count) {
				/*        相应点击事件 i为点击的索引值         */
				SearchReturnVC *searchReturnVC = [[SearchReturnVC alloc] init];
				searchReturnVC.keywords = _hotArr[i];
				[weakSelf.navigationController pushViewController:searchReturnVC animated:YES];
			}
		}];

		[self.view addSubview:history];

	} Failed:^(NSError *error) {

	}];

}

#pragma mark - createView
- (void)createView {
	// 状态栏
	UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
	statusBarView.backgroundColor=[UIColor whiteColor];
	[self.view addSubview:statusBarView];

	UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	leftButton.frame = CGRectMake(UNITHEIGHT * 16, UNITHEIGHT * 31, UNITHEIGHT * 22, UNITHEIGHT * 22);
	[leftButton setBackgroundImage:[UIImage imageNamed:@"yc-22"] forState:UIControlStateNormal];
	[leftButton addTarget:self action:@selector(leftItemAction:) forControlEvents:UIControlEventTouchUpInside];
	[statusBarView addSubview:leftButton];



	// searchBar
	self.searchBar = [[UISearchBar alloc] init];
	self.searchBar.barStyle = UIBarStyleDefault;
	self.searchBar.placeholder = @"搜索：商品 分类 品牌";
	self.searchBar.delegate = self;
//	self.searchBar.layer.borderColor = [UIColor blackColor].CGColor;
//	self.searchBar.layer.borderWidth = 1;
	self.searchBar.barTintColor = [UIColor whiteColor];
	self.searchBar.tintColor = [UIColor blackColor];
	self.searchBar.searchBarStyle = UISearchBarStyleDefault;
	[statusBarView addSubview:_searchBar];

	UIView *searchTextField = nil;
	searchTextField.backgroundColor = [UIColor blackColor];
	// 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
	searchTextField = [[[self.searchBar.subviews firstObject] subviews] lastObject];
	searchTextField.backgroundColor = [UIColor colorWithHexString:@"#ececec"];

	for (UIView *view in self.searchBar.subviews) {
		// for before iOS7.0
		if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
			[view removeFromSuperview];
			break;
		}
		// for later iOS7.0(include)
		if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
			[[view.subviews objectAtIndex:0] removeFromSuperview];
			break;
		}
	}

	[_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(leftButton);
		make.left.mas_equalTo(leftButton).with.offset(UNITHEIGHT * 22);
		make.width.mas_equalTo(WIDTH - UNITHEIGHT * 100);
		make.height.mas_equalTo(UNITHEIGHT * 35);
	}];

	 // Set Search Button Title to Done 2
	for (UIView *searchBarSubview in [self.searchBar subviews]) {
		if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
			// Before iOS 7.0 5
			@try {
				[(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
				[(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
			}
			@catch (NSException * e) {
				// ignore exception
			}
		} else {
			// iOS 7.014
			for(UIView *subSubView in [searchBarSubview subviews]) {
				if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
					@try {
						[(UITextField *)subSubView setReturnKeyType:UIReturnKeyDone];
						[(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
					}
					@catch (NSException * e) {
						// ignore exception22
					}
				}
			}
		}
	}



	// 搜索按钮
	UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
	searchButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[searchButton setTitle:@"搜索" forState:UIControlStateNormal];
	[searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
	searchButton.titleLabel.font = font(14);
	[statusBarView addSubview:searchButton];

	[searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.bottom.mas_equalTo(leftButton);
		make.left.mas_equalTo(_searchBar.mas_right).with.offset(UNITHEIGHT * 5);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];

	UIView *bottomView = [[UIView alloc] init];
	bottomView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
	[self.view addSubview:bottomView];

	[bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.left.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 4);
		make.top.mas_equalTo(statusBarView.mas_bottom);
	}];

	UILabel *hotLabel = [[UILabel alloc] init];
	hotLabel.text = @"热搜：";
	hotLabel.font = font(14);
	[self.view addSubview:hotLabel];

	[hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(UNITHEIGHT * 20);
		make.top.mas_equalTo(bottomView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];



//	// 热搜
//	JHCusomHistory *history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 110, WIDTH, HEIGHT - UNITHEIGHT * 110) andItems:_hotArr andItemClickBlock:^(NSInteger i) {
//
//		if (i < _hotArr.count) {
//			NSLog(@"%@", _hotArr[i]);
//		}
//		/*        相应点击事件 i为点击的索引值         */
//
//
//	}];
//
//	[self.view addSubview:history];
}



#pragma mark - searchAction
- (void)searchButton:(UIButton *)button {
	[self.view endEditing:YES];

	if (searchStr.length > 0) {
		SearchReturnVC *searchReturnVC = [[SearchReturnVC alloc] init];
		searchReturnVC.keywords = searchStr;
		[self.navigationController pushViewController:searchReturnVC animated:YES];
	} else {
		[RegosterAlert showAlert:@"请输入关键字" err:nil];
	}
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	searchStr = searchBar.text;
}



#pragma mark - leftItemAction
- (void)leftItemAction:(UIButton *)button {
	[self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	return NO;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.hidden = NO;
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
