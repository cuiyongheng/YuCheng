///Users/apple/Desktop/YuCheng/YuCheng.xcodeproj
//  StoreViewController.m
//  YuCheng
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreCell.h"
#import "personalStoreVC.h"

@interface StoreViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, StoreCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *page;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商铺";

	[self createView];
	self.navigationItem.leftBarButtonItem = nil;

}

#pragma mrak - createView
- (void)createView {
	// tableView
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.rowHeight = UNITHEIGHT * 194;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[StoreCell class] forCellReuseIdentifier:@"storeCell"];

	// headerView
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 183)];
	headerView.backgroundColor = [UIColor clearColor];
	_tableView.tableHeaderView = headerView;

	// scroll
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 183)];
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.contentSize = CGSizeMake(WIDTH * 5, 0);
	_scrollView.delegate = self;
	_scrollView.pagingEnabled = YES;
	[headerView addSubview:_scrollView];

	for (NSInteger i = 15; i < 20; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i - 15), 0, WIDTH, UNITWIDTH * 183)];
		imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"玉城LOGO-%ld.jpg", (long)i]];
		[_scrollView addSubview:imageView];
	}

	// page
	self.page = [[UIPageControl alloc] init];
	[headerView addSubview:_page];
	_page.numberOfPages = 5;
	_page.currentPageIndicatorTintColor = [UIColor whiteColor];
	_page.pageIndicatorTintColor = [UIColor colorWithHexString:@"#817a75"];
	_page.backgroundColor = [UIColor clearColor];
	[_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];

	[_page mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_scrollView);
		make.bottom.mas_equalTo(_scrollView).with.offset(-UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeCell"];

	cell.comeStoreButton.tag = 20000 + indexPath.row;
	cell.delegate = self;

	if (indexPath.row % 2 == 0) {
		cell.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
	} else {
		cell.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - storeDelegate
- (void)comeinStore:(NSInteger)buttonTag {
	personalStoreVC *storeVC = [[personalStoreVC alloc] init];
	[self.navigationController pushViewController:storeVC animated:YES];
}



#pragma mark - scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _scrollView) {
		_page.currentPage = scrollView.contentOffset.x / WIDTH;
	}
}

- (void)pageAction:(UIPageControl *)page {
	[self.scrollView setContentOffset:CGPointMake(page.currentPage * WIDTH, 0) animated:YES];
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
