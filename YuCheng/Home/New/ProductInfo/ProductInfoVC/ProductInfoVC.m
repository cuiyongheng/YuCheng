//
//  ProductInfoVC.m
//  YuCheng
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProductInfoVC.h"
#import "ProductOneCell.h"
#import "ProductTwoCell.h"
#import "ProductThirdCell.h"
#import "RIghtNavigationView.h"
#import "InfoStatsView.h"
#import "ProductOrderCell.h"
#import "ProductIntroduceCell.h"
#import "JustStartTimeView.h"
#import <OpenShareHeader.h>
#import "LCZAVPlayerTool.h"
#import "ProductInfoModel.h"
#import "ShoppingBagVC.h"
#import "ShareCollectionCell.h"
#import "SDPhotoBrowser.h"

@interface ProductInfoVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, RIghtNavigationViewDelegate, WXApiDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ShareCollectionCellDelegate, SDPhotoBrowserDelegate, ProductThirdCellDelegate>

@property (nonatomic, strong) UIView *navigationView;// 导航栏

@property (nonatomic, strong) RIghtNavigationView *rightNavigationView;

@property (nonatomic, strong) UIScrollView *picScrollView;

@property (nonatomic, strong) UIPageControl *page;

@property (nonatomic, strong) UITableView *infoTableView;

@property (nonatomic, strong) NSMutableArray *picArr;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) NSMutableArray *certificateArr;

@property (nonatomic, strong) UIButton *leftButton;// 返回按钮

@property (nonatomic, strong) NSMutableDictionary *statsDic;// 保存layer状态

@property (nonatomic, assign) BOOL isUp;// 购物车在上还是下

@property (nonatomic, assign) BOOL isPlay;// 是否播放

@property (nonatomic, strong) UIView *hiddenView;// 蒙版

@property (nonatomic, strong) NSMutableDictionary *foldDic;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) ProductInfoModel *productModel;

@property (nonatomic, assign) BOOL isSave;

@property (nonatomic, assign) BOOL isThumbup;

@property (nonatomic, strong) UIImageView *playerImageView;

@property (nonatomic, strong) UIView *shareView;

@property (nonatomic, strong) OSMessage *msg;

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) UIImageView *shareImageView;

@property (nonatomic, strong) MyQRCodeView *qrView;

@property (nonatomic, strong) NSMutableDictionary *modelDic;

@end

@implementation ProductInfoVC

{
	UIButton *footButton;
	UIButton *footRightButton;
	UIButton *overButton;
	InfoStatsView *infoStatsView;
	JustStartTimeView *timeView;
	UILabel *justStartLabel;
}

- (void)dealloc {
	[_infoTableView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//	self.view.backgroundColor = [UIColor colorWithHexString:@"#DCDCDD"];

	[self createView];
	[self createData];
}

#pragma mark - footmark
- (void)footmark {
	if ([SaveTool isHavePlist:_productModel]) {
		// 没足迹
		[SaveTool saveToPlist:_productModel];
	} else {
		// 有足迹
		[SaveTool cancelInPlist:_productModel];
		[SaveTool saveToPlist:_productModel];
	}
}

#pragma mark - createData
- (void)createData {

	self.picArr = [NSMutableArray arrayWithCapacity:0];
	self.certificateArr = [NSMutableArray arrayWithCapacity:0];

	self.statsDic = [NSMutableDictionary dictionaryWithCapacity:0];
	self.foldDic = [NSMutableDictionary dictionaryWithCapacity:0];

	// 收藏 点赞
	RIghtNavigationView *rightView = (RIghtNavigationView *)[self.view viewWithTag:7654321];
	RIghtNavigationView *otherRightView = (RIghtNavigationView *)[self.view viewWithTag:7654322];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/goodsDetail.php" params:@{@"goods_id" : _goodsID} Success:^(id responseObject) {

		_modelDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
		_productModel = [ProductInfoModel mj_objectWithKeyValues:responseObject[@"goods"]];

		// 我的足迹
		[self footmark];

		// 证书
		for (NSDictionary *dic in responseObject[@"goods_credit_list"]) {
			[_certificateArr addObject:[NSString stringWithFormat:@"%@%@", API_BASE_URL, dic[@"img_original"]]];
		}

		_rightNavigationView.numberLabel.text = [NSString stringWithFormat:@"%@" ,_modelDic[@"cart_goods_number"]];
		if ([_productModel.goods_number isEqualToString:@"1"]) {
			_stats = normalStats;
		} else if ([_productModel.goods_number isEqualToString:@"0"]) {
			_stats = sellOut;
		}

//		if (_stats == normalStats) {
//			// 正常状态
//			overButton.hidden = YES;
//			infoStatsView.hidden = YES;
//			timeView.hidden = YES;
//			justStartLabel.hidden = YES;
//
//		}  else if (_stats == sellOut) {
//			// 售罄
//			overButton.hidden = NO;
//			infoStatsView.hidden = YES;
//			footButton.hidden = YES;
//			footRightButton.hidden = YES;
//			timeView.hidden = YES;
//			justStartLabel.hidden = YES;
//			
//		}



		// 轮播
		for (NSDictionary *dic in responseObject[@"goods_img_list"]) {
			[_picArr addObject:[NSString stringWithFormat:@"%@%@", API_BASE_URL, dic[@"img_original"]]];
		}
		[_picArr addObject:@""];

		_picScrollView.contentSize = CGSizeMake(WIDTH * _picArr.count + 1, 0);
		for (NSInteger i = 0; i < _picArr.count; i++) {
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, UNITHEIGHT * 363.5)];
			[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _picArr[i]]] placeholderImage:[UIImage imageNamed:@""]];
			[_picScrollView addSubview:imageView];



			// 渐变背景
			UIView * picBackView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), UNITHEIGHT * 200, WIDTH, UNITHEIGHT * 363.5 - UNITHEIGHT * 200)];
			picBackView.backgroundColor = [UIColor clearColor];
			picBackView.tag = 100000 + i;
			[_picScrollView addSubview:picBackView];

			// 渐变
			UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(imageView.frame.origin.x + 1, imageView.frame.origin.y + 1)];
			const CGFloat  *components = CGColorGetComponents(selectColor.CGColor);
			int R = components[0] * 255;
			int G = components[1] * 255;
			int B = components[2] * 255;

			UIColor *colorOne = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:0.0];
			UIColor *colorTwo = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:1.0];
			NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
			NSNumber *stopOne = [NSNumber numberWithFloat:0.3];
			NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
			NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];

			//crate gradient layer
			CAGradientLayer *headerLayer = [CAGradientLayer layer];

			headerLayer.colors = colors;
			headerLayer.locations = locations;
			headerLayer.frame = picBackView.bounds;
			[picBackView.layer addSublayer:headerLayer];
			self.view.backgroundColor = selectColor;

			// 毛玻璃效果
			// 用来显示模糊效果
			UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
			UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
			effectView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
			effectView.tag = 110000 + i;
			effectView.alpha = 0;
			[imageView addSubview:effectView];
		}



		// 是否收藏 点赞
		if ([responseObject[@"is_collect"] isEqual:@1]) {
			// 收藏
			_isSave = 1;
			[otherRightView.saveButton setBackgroundImage:[UIImage imageNamed:@"zan_3"] forState:UIControlStateNormal];
			[rightView.saveButton setBackgroundImage:[UIImage imageNamed:@"zan_3"] forState:UIControlStateNormal];
		} else {
			// 未收藏
			_isSave = 0;
			[otherRightView.saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
			[rightView.saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
		}

		if ([responseObject[@"is_thumbup"] isEqual:@1]) {
			// 点赞
			_isThumbup = 1;
			[otherRightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
			[rightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
		} else {
			// 未点赞
			_isThumbup = 0;
			[otherRightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_1"] forState:UIControlStateNormal];
			[rightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_1"] forState:UIControlStateNormal];
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			[_infoTableView reloadData];
			[[LCZAVPlayerTool shareSingleton] creatAVplayer:_productModel.goods_vedio_url];
			[[LCZAVPlayerTool shareSingleton] changeFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 363.5)];
			[_playerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, responseObject[@"goods_img_list"][0][@"img_original"]]] placeholderImage:[UIImage imageNamed:@""]];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	// navigationView
	self.navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
	_navigationView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:_navigationView];

	self.rightNavigationView = [[RIghtNavigationView alloc] initWithFrame:CGRectMake(WIDTH - UNITHEIGHT * 27 - UNITHEIGHT * 65 - UNITHEIGHT * 37 - UNITHEIGHT * 75, 64 - UNITHEIGHT * 27.5, UNITHEIGHT * 65 + UNITHEIGHT * 37 + UNITHEIGHT * 75, UNITHEIGHT * 27.5)];
	_rightNavigationView.delegate = self;
	_rightNavigationView.tag = 7654321;
	[self.view addSubview:_rightNavigationView];
	[self.view bringSubviewToFront:_rightNavigationView];
	_rightNavigationView.hidden = YES;

//	[_rightNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.bottom.mas_equalTo(_navigationView.mas_bottom).with.offset(-UNITHEIGHT * 3);
//		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 27);
//		make.height.mas_equalTo(UNITHEIGHT * 27.5);
//		make.width.mas_equalTo(UNITHEIGHT * 65);
//	}];

	self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_leftButton setBackgroundImage:[UIImage imageNamed:@"yc-22"] forState:UIControlStateNormal];
	_leftButton.frame = CGRectMake(UNITHEIGHT * 15, UNITHEIGHT * 28, UNITHEIGHT * 28, UNITHEIGHT * 28);
	[_leftButton addTarget:self action:@selector(leftButtonPop:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_leftButton];

	// tableView
	self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - UNITHEIGHT * 45) style:UITableViewStylePlain];
	_infoTableView.delegate = self;
	_infoTableView.dataSource = self;
	_infoTableView.showsVerticalScrollIndicator = NO;
	_infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_infoTableView.contentInset = UIEdgeInsetsMake(UNITHEIGHT * 422.5 - 64, 0, 0, 0);
	_infoTableView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:_infoTableView];

	[_infoTableView registerClass:[ProductOneCell class] forCellReuseIdentifier:@"infoOneCell"];

	[_infoTableView registerClass:[ProductTwoCell class] forCellReuseIdentifier:@"infoTwoCell"];

	[_infoTableView registerClass:[ProductOrderCell class] forCellReuseIdentifier:@"infoOrderCell"];

	[_infoTableView registerClass:[ProductIntroduceCell class] forCellReuseIdentifier:@"introduceCell"];

	// scrollView
	self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 422.5)];
	[self.view addSubview:_headView];

	self.picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 363.5)];
	_picScrollView.pagingEnabled = YES;
	_picScrollView.delegate = self;
	_picScrollView.showsHorizontalScrollIndicator = NO;
	[_headView addSubview:_picScrollView];

	[LCZAVPlayerTool shareSingleton].frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
	[[LCZAVPlayerTool shareSingleton] changeFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 363.5)];
	[_picScrollView addSubview:[LCZAVPlayerTool shareSingleton]];



//	for (NSInteger i = 0; i < _picArr.count; i++) {
//		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, UNITHEIGHT * 363.5)];
//		imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _picArr[i]]];
//		[_picScrollView addSubview:imageView];
//
//
//
//		// 渐变背景
//		UIView * picBackView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH * i, UNITHEIGHT * 200, WIDTH, UNITHEIGHT * 363.5 - UNITHEIGHT * 200)];
//		picBackView.backgroundColor = [UIColor clearColor];
//		picBackView.tag = 100000 + i;
//		[_picScrollView addSubview:picBackView];
//
//		// 渐变
//		UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(imageView.frame.origin.x + 1, imageView.frame.origin.y + 1)];
//		const CGFloat  *components = CGColorGetComponents(selectColor.CGColor);
//		int R = components[0] * 255;
//		int G = components[1] * 255;
//		int B = components[2] * 255;
//
//		UIColor *colorOne = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:0.0];
//		UIColor *colorTwo = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:1.0];
//		NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
//		NSNumber *stopOne = [NSNumber numberWithFloat:0.3];
//		NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
//		NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
//
//		//crate gradient layer
//		CAGradientLayer *headerLayer = [CAGradientLayer layer];
//
//		headerLayer.colors = colors;
//		headerLayer.locations = locations;
//		headerLayer.frame = picBackView.bounds;
//		[picBackView.layer addSublayer:headerLayer];
//		self.view.backgroundColor = selectColor;
//
//
//		// 毛玻璃效果
//		// 用来显示模糊效果
//		UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//		UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//		effectView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
//		effectView.tag = 110000 + i;
//		effectView.alpha = 0;
//		[imageView addSubview:effectView];
//	}



	// page
	self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 363.5, WIDTH, UNITHEIGHT * 59)];
	[_headView addSubview:_page];
	_page.numberOfPages = _picArr.count;
	_page.currentPageIndicatorTintColor = [UIColor whiteColor];
	_page.pageIndicatorTintColor = [UIColor colorWithHexString:@"#ECECEC"];
	_page.backgroundColor = [UIColor clearColor];
//	[_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];

	// 添加监听
	[_infoTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];



	// foot
	self.footView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 10, UNITHEIGHT * 607, WIDTH - UNITHEIGHT * 20, 60)];
	_footView.backgroundColor = [UIColor whiteColor];
	[self.view bringSubviewToFront:_footView];
	[self.view addSubview:_footView];

	// 判断状态
	[self judgeStartView];



	// 购物车
	UIButton * shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	shopCarBtn.frame = CGRectMake(0, 0, UNITHEIGHT * 120, UNITHEIGHT * 120);
	shopCarBtn.center = self.view.center;
	shopCarBtn.hidden = YES;
	[shopCarBtn setImage:[UIImage imageNamed:@"upimMainGrayShopCar"] forState:UIControlStateNormal];
	shopCarBtn.tag = 99999;
	[shopCarBtn addTarget:self action:@selector(shopCarButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:shopCarBtn];

	// 播放器
	[self createPlayer];

	// 分享
	[self createShareView];
}

#pragma mark - judgeStartView
- (void)judgeStartView {
	// 判断状态添加
	footButton = [UIButton buttonWithType:UIButtonTypeCustom];
	footButton.backgroundColor = [UIColor blackColor];
	footButton.titleLabel.font = font(19);
	[footButton setTitle:@"加入购物车" forState:UIControlStateNormal];
	[footButton addTarget:self action:@selector(footButton:) forControlEvents:UIControlEventTouchUpInside];
	[_footView addSubview:footButton];

	[footButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.right.mas_equalTo(_footView.mas_centerX);
		make.width.mas_equalTo(UNITHEIGHT * 171);
		make.centerY.mas_equalTo(_footView);
	}];

	footRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
	footRightButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	footRightButton.titleLabel.font = font(19);
	[footRightButton setTitle:@"立即购买" forState:UIControlStateNormal];
	[footRightButton addTarget:self action:@selector(footRightButton:) forControlEvents:UIControlEventTouchUpInside];
	[_footView addSubview:footRightButton];

	[footRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.left.mas_equalTo(_footView.mas_centerX);
		make.width.mas_equalTo(UNITHEIGHT * 171);
		make.centerY.mas_equalTo(_footView);
	}];

	overButton = [UIButton buttonWithType:UIButtonTypeCustom];
	overButton.backgroundColor = [UIColor colorWithHexString:@"#595757"];
	overButton.titleLabel.font = font(19);
	[overButton setTitle:@"售罄" forState:UIControlStateNormal];
	[overButton addTarget:self action:@selector(overButton:) forControlEvents:UIControlEventTouchUpInside];
	overButton.hidden = YES;
	[_footView addSubview:overButton];

	[overButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.centerY.mas_equalTo(_footView);
		make.width.mas_equalTo(UNITHEIGHT * 342);
		make.height.mas_equalTo(UNITHEIGHT * 45);
	}];

	// 状态
	infoStatsView = [[InfoStatsView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 329.5 - 64, UNITHEIGHT * 163, UNITHEIGHT * 69)];
	infoStatsView.hidden = YES;
	[_headView addSubview:infoStatsView];

	// 倒计时
	timeView = [[JustStartTimeView alloc] init];
	[timeView countDownViewWithEndString:@"2016-6-16"];
	timeView.dayLabel.textColor = [UIColor whiteColor];
	timeView.hourLabel.textColor = [UIColor whiteColor];
	timeView.minuteLabel.textColor = [UIColor whiteColor];
	timeView.secondLabel.textColor = [UIColor whiteColor];
	timeView.dayLabel.font = font(19);
	timeView.hourLabel.font = font(19);
	timeView.minuteLabel.font = font(19);
	timeView.secondLabel.font = font(19);
	timeView.dayLabel.hidden = YES;
	timeView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	timeView.hidden = YES;
	[_footView addSubview:timeView];

	justStartLabel = [[UILabel alloc] init];
	justStartLabel.text = @"即将开始：";
	justStartLabel.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	justStartLabel.font = font(19);
	timeView.hidden = YES;
	justStartLabel.textAlignment = NSTextAlignmentRight;
	justStartLabel.textColor = [UIColor whiteColor];
	[_footView addSubview:justStartLabel];

	[justStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_footView);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.width.mas_equalTo(UNITHEIGHT * 151);
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 16.5);
	}];

	[timeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_footView);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.width.mas_equalTo(UNITHEIGHT * 271);
		make.left.mas_equalTo(justStartLabel.mas_right).with.offset(-UNITHEIGHT * 80);
	}];

	if (_stats == normalStats) {
		// 正常状态
		overButton.hidden = YES;
		infoStatsView.hidden = YES;
		timeView.hidden = YES;
		justStartLabel.hidden = YES;

	} else if (_stats == justStart) {
		// 即将开始
		infoStatsView.hidden = YES;
		//		infoStatsView.whiteBackView.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
		//		infoStatsView.statsLabel.text = @"即将开始";
		//		infoStatsView.statsLabel.textColor = [UIColor whiteColor];
		//		infoStatsView.timeLabel.textColor = [UIColor whiteColor];
		//		[overButton setTitle:@"敬请期待" forState:UIControlStateNormal];
		overButton.hidden = YES;
		infoStatsView.hidden = YES;
		footButton.hidden = YES;
		footRightButton.hidden = YES;
		timeView.hidden = NO;
		justStartLabel.hidden = NO;

	} else if (_stats == limitRush) {
		// 限时抢购
		infoStatsView.hidden = YES;
		overButton.hidden = YES;
		timeView.hidden = YES;
		justStartLabel.hidden = YES;

	} else if (_stats == sellOut) {
		// 售罄
		overButton.hidden = NO;
		infoStatsView.hidden = YES;
		footButton.hidden = YES;
		footRightButton.hidden = YES;
		timeView.hidden = YES;
		justStartLabel.hidden = YES;

	}
	[self.view bringSubviewToFront:_leftButton];
}

#pragma mark - createPlayer
- (void)createPlayer {
	self.playerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	_playerImageView.frame = CGRectMake(0, 0, WIDTH, UNITHEIGHT * 363.5);
	[_picScrollView addSubview:_playerImageView];

	UIView * picBackView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 200, WIDTH, UNITHEIGHT * 363.5 - UNITHEIGHT * 200)];
	picBackView.backgroundColor = [UIColor clearColor];
	picBackView.tag = 600;
	[_picScrollView addSubview:picBackView];

	// 渐变
//	UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(_playerImageView.frame.origin.x + 1, _playerImageView.frame.origin.y + 1)];
//	const CGFloat  *components = CGColorGetComponents(selectColor.CGColor);
//	int R = components[0] * 255;
//	int G = components[1] * 255;
//	int B = components[2] * 255;
//
//	UIColor *colorOne = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:0.0];
//	UIColor *colorTwo = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:1.0];
//	NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
//	NSNumber *stopOne = [NSNumber numberWithFloat:0.3];
//	NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
//	NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
//
//	//crate gradient layer
//	CAGradientLayer *headerLayer = [CAGradientLayer layer];
//
//	headerLayer.colors = colors;
//	headerLayer.locations = locations;
//	headerLayer.frame = picBackView.bounds;
//	[picBackView.layer addSublayer:headerLayer];
//	self.view.backgroundColor = selectColor;



	// 毛玻璃效果
	// 用来显示模糊效果
	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
	effectView.frame = CGRectMake(0, 0, _playerImageView.frame.size.width, _playerImageView.frame.size.height);
	effectView.alpha = 0;
	effectView.tag = 1111111;
	[_playerImageView addSubview:effectView];

	// 播放按钮
	self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_playButton.backgroundColor = [UIColor clearColor];
	_playButton.frame = CGRectMake(0, 0, WIDTH, UNITHEIGHT * 363.5);
	[_playButton setBackgroundImage:[UIImage imageNamed:@"播放图标"] forState:UIControlStateNormal];
	[_playButton addTarget:self action:@selector(playButton:) forControlEvents:UIControlEventTouchUpInside];
	[_picScrollView addSubview:_playButton];
	_isPlay = 0;

	self.hiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, UNITHEIGHT * 363.5, WIDTH, HEIGHT - UNITHEIGHT * 363.5)];
	_hiddenView.hidden = YES;
	_hiddenView.backgroundColor = [UIColor blackColor];
	_hiddenView.alpha = 0.8;
	[self.view addSubview:_hiddenView];

	UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTap:)];
	[_hiddenView addGestureRecognizer:hiddenTap];

}

#pragma mark - createShareView
- (void)createShareView {
	self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 250)];
	_shareView.backgroundColor = [UIColor blackColor];
	_shareView.alpha = 0.8;
	_shareView.hidden = YES;
	[self.view addSubview:_shareView];

	UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareHidden:)];
	[_shareView addGestureRecognizer:shareTap];

	// 二维码
	self.qrView = [[MyQRCodeView alloc] initWithFrame:
							CGRectMake(UNITHEIGHT * 50, UNITHEIGHT * 100, WIDTH - UNITHEIGHT * 100, WIDTH - UNITHEIGHT * 100)];
	_qrView.hidden = YES;
	[_shareView addSubview:_qrView];

	UITapGestureRecognizer *qrViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qrViewTap:)];
	[_qrView addGestureRecognizer:qrViewTap];


	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.sectionInset = UIEdgeInsetsMake( UNITHEIGHT * 10, UNITHEIGHT * 10, UNITHEIGHT * 10, UNITHEIGHT * 10);
	flowLayout.itemSize = CGSizeMake(UNITHEIGHT * 110, UNITHEIGHT * 110);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 10;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 10;

	self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HEIGHT - UNITHEIGHT * 250, WIDTH, UNITHEIGHT * 250) collectionViewLayout:flowLayout];
	_collection.delegate = self;
	_collection.dataSource = self;
	_collection.hidden = YES;
	_collection.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_collection];

	[_collection registerClass:[ShareCollectionCell class] forCellWithReuseIdentifier:@"shareCell"];



	// 分享参数
	self.msg=[[OSMessage alloc]init];
	_msg.title=@"玉城";
	_msg.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
	_msg.thumbnail = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon (4)" ofType:@"png"]];
	_msg.link = @"http://www.jadechina.cn/mobile/";
}



#pragma mark - scrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _picScrollView) {
		_page.currentPage = scrollView.contentOffset.x / WIDTH;

		NSString *str = [NSString stringWithFormat:@"%.2f", scrollView.contentOffset.x];

		if([self.statsDic[str] integerValue] == 0){
			[self.statsDic setObject:@1 forKey:str];
			if (_picScrollView.contentOffset.x == 0) {
				UIView *picBackView = (UIView *)[self.view viewWithTag:600];
				UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(_headView.frame.origin.x + 1, _headView.frame.origin.y + 1)];
				const CGFloat  *components = CGColorGetComponents(selectColor.CGColor);
				int R = components[0] * 255;
				int G = components[1] * 255;
				int B = components[2] * 255;

				UIColor *colorOne = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:0.0];
				UIColor *colorTwo = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:1.0];
				NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
				NSNumber *stopOne = [NSNumber numberWithFloat:0.3];
				NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
				NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];

				//crate gradient layer
				CAGradientLayer *headerLayer = [CAGradientLayer layer];

				headerLayer.colors = colors;
				headerLayer.locations = locations;
				headerLayer.frame = picBackView.bounds;
				[picBackView.layer addSublayer:headerLayer];
			} else {
				UIView *picBackView = (UIView *)[self.view viewWithTag:100000 + scrollView.contentOffset.x / WIDTH - 1];
				UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(_headView.frame.origin.x + 1, _headView.frame.origin.y + 1)];
				const CGFloat  *components = CGColorGetComponents(selectColor.CGColor);
				int R = components[0] * 255;
				int G = components[1] * 255;
				int B = components[2] * 255;

				UIColor *colorOne = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:0.0];
				UIColor *colorTwo = [UIColor colorWithRed:(R/255.0)  green:(G/255.0)  blue:(B/255.0)  alpha:1.0];
				NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
				NSNumber *stopOne = [NSNumber numberWithFloat:0.3];
				NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
				NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];

				//crate gradient layer
				CAGradientLayer *headerLayer = [CAGradientLayer layer];

				headerLayer.colors = colors;
				headerLayer.locations = locations;
				headerLayer.frame = picBackView.bounds;
				[picBackView.layer addSublayer:headerLayer];
			}

//			self.view.backgroundColor = selectColor;
		}

		UIColor *selectColor = [self getPixelColorAtLocation:CGPointMake(_headView.frame.origin.x + 1, _headView.frame.origin.y + 1)];

		[self performSelectorInBackground:@selector(backViewAnimate:) withObject:selectColor];
	} else if (scrollView == _infoTableView) {

		if (scrollView.contentOffset.y > - UNITHEIGHT * 280 && scrollView.contentOffset.y < 64) {
			[_infoTableView setContentOffset:CGPointMake(0, UNITHEIGHT * 44) animated:YES];
		} else if (scrollView.contentOffset.y < -UNITHEIGHT * 280 && scrollView.contentOffset.y > -UNITHEIGHT * 422.5 + 64) {
			[_infoTableView setContentOffset:CGPointMake(0, -UNITHEIGHT * 422.5 + 64) animated:YES];
		}
	}
	_hiddenView.hidden = YES;
}

- (void)backViewAnimate:(UIColor *)selectColor {
	[UIView animateWithDuration:0.5f animations:^{
		//动画
		self.view.backgroundColor = selectColor;
	} completion:^(BOOL finished) {
		//动画结束
	}];
}



#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shareCell" forIndexPath:indexPath];
	cell.delegate = self;
	cell.imageViewButton.tag = 100 + indexPath.item;

	if (indexPath.item == 0) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-02"];
		cell.titleLabel.text = @"微信好友";
	} else if (indexPath.item == 1) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-03"];
		cell.titleLabel.text = @"微信朋友圈";
	} else if (indexPath.item == 2) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-07"];
		cell.titleLabel.text = @"扫描二维码";
	} else if (indexPath.item == 3) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-06"];
		cell.titleLabel.text = @"QQ好友";
	} else if (indexPath.item == 4) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-04"];
		cell.titleLabel.text = @"QQ朋友圈";
	} else if (indexPath.item == 5) {
		cell.picImageView.image = [UIImage imageNamed:@"Nipic_20437544_20150328161815141625-05"];
		cell.titleLabel.text = @"微博";
	}

	return cell;
}

- (void)shareImageToThirdPart:(NSInteger)buttonTag {
	if (buttonTag == 100) {
		// 微信好友
		[OpenShare shareToWeixinSession:_msg Success:^(OSMessage *message) {
			ULog(@"微信分享到会话成功");
		} Fail:^(OSMessage *message, NSError *error) {
			ULog(@"微信分享到会话失败");
		}];


		// 微信登录
//		UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//
//		snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//			if (response.responseCode == UMSResponseCodeSuccess) {
//
//				NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//				UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//				NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//
//			}
//
//		});

	} else if (buttonTag == 101) {
		// 微信朋友圈
		[OpenShare shareToWeixinTimeline:_msg Success:^(OSMessage *message) {
			ULog(@"微信分享到朋友圈成功");
		} Fail:^(OSMessage *message, NSError *error) {
			ULog(@"微信分享到朋友圈失败");
		}];

	} else if (buttonTag == 102) {
		// 扫描二维码
		_qrView.hidden = NO;
	} else if (buttonTag == 103) {
		OSMessage *msg=[[OSMessage alloc] init];
		msg.title = @"玉城";
		msg.link = @"http://www.jadechina.cn/mobile/";
		msg.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
		msg.thumbnail = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon (4)" ofType:@"png"]];
		msg.desc = [NSString stringWithFormat:@"玉城分享"];

		// qq好友
		[OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
			ULog(@"分享到QQ好友成功");
		} Fail:^(OSMessage *message, NSError *error) {
			ULog(@"分享到QQ好友失败");
		}];


		// QQ登录
//		UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//
//		snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//			//          获取微博用户名、uid、token等
//
//			if (response.responseCode == UMSResponseCodeSuccess) {
//
//				NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//				UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//				NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//
//			}});

	} else if (buttonTag == 104) {
		OSMessage *msg=[[OSMessage alloc] init];
		msg.title = @"玉城";
		msg.link = @"http://www.jadechina.cn/mobile/";
		msg.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
		msg.thumbnail = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon (4)" ofType:@"png"]];
		msg.desc = [NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];

		// qq朋友圈
		[OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
			ULog(@"分享到QQ空间成功");
		} Fail:^(OSMessage *message, NSError *error) {
			ULog(@"分享到QQ空间失败");
		}];
	} else if (buttonTag == 105) {
		// 微博
		[OpenShare shareToWeibo:_msg Success:^(OSMessage *message) {
			NSLog(@"分享到sina微博成功");
		} Fail:^(OSMessage *message, NSError *error) {
			NSLog(@"分享到sina微博失败");
		}];

		// 微博登录
//		UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//
//		snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//			//          获取微博用户名、uid、token等
//
//			if (response.responseCode == UMSResponseCodeSuccess) {
//
//				NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//				UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//				NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//
//			}});
	}
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		ProductOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoOneCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.navigationView.delegate = self;
		cell.model = _productModel;
		cell.navigationView.tag = 7654322;
		cell.navigationView.numberLabel.text = [NSString stringWithFormat:@"%@" ,_modelDic[@"cart_goods_number"]];

		if (_isSave) {
			// 收藏
			[cell.navigationView.saveButton setBackgroundImage:[UIImage imageNamed:@"zan_3"] forState:UIControlStateNormal];
		} else {
			// 为收藏
			[cell.navigationView.saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
		}

		if (_isThumbup) {
			// 点赞
			[cell.navigationView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
		} else {
			[cell.navigationView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_1"] forState:UIControlStateNormal];
		}

		return cell;
	} else if (indexPath.row == 2) {
		ProductTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoTwoCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		cell.model = _productModel;
		cell.modelDic = _modelDic;
//		NSLog(@"%@", _modelDic);
//		cell.certificateLabel.text = _modelDic[@"accessory_desc"];
//		cell.shouhouLabel.text = _modelDic[@"aftersale_promise_desc"];
//		cell.certificateLabel.text = _modelDic[@"certificate_desc"];
//		cell.peisongLabel.text = _modelDic[@"delivery_time_desc"];

		return cell;
	} else if (indexPath.row == 1) {
		ProductOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoOrderCell"];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;

		return cell;
	} else if (indexPath.row == 3){
		static NSString *reuse = @"infoThirdCell";
		ProductThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
		cell.delegate = self;

		// 商品详情
		if (!cell) {
			cell = [[ProductThirdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.titleLabel.text = @"商品详情";
			cell.porductArr = _picArr;
		}

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			cell.picView.hidden = YES;
			cell.lineView.hidden = YES;
		}
		//如果状态值为不为0，代表展开
		else{
			cell.picView.hidden = NO;
			cell.lineView.hidden = NO;
		}
		return cell;
	} else if (indexPath.row == 4) {
		static NSString *reuse = @"infoThirdCell";
		ProductThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];

		// 相关证书
		if (!cell) {
			cell = [[ProductThirdCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
			cell.picArr = _certificateArr;
		}

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			cell.picView.hidden = YES;
			cell.lineView.hidden = YES;
		}
		//如果状态值为不为0，代表展开
		else{
			cell.picView.hidden = NO;
			cell.lineView.hidden = NO;
		}
		return cell;
	} else {
		ProductIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introduceCell"];
		
		if (indexPath.row == 5) {
			cell.isTransparent = 1;
		} else {
			cell.isTransparent = 0;
		}

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];
		if([self.statsDic[str] integerValue] == 0){
			cell.collectionView.hidden = YES;
		}
		//如果状态值为不为0，代表展开
		else{
			cell.collectionView.hidden = NO;
		}

		return cell;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return UNITHEIGHT * 129.0f;
	} else if (indexPath.row == 2) {
		return UNITHEIGHT * 235.0f + UNITHEIGHT * 200;
	} else if (indexPath.row == 4) {

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			return UNITHEIGHT * 60;
		}
		//如果状态值为不为0，代表展开
		else{
			return UNITHEIGHT * 60 + _certificateArr.count * UNITHEIGHT * 500;
		}
	} else if (indexPath.row == 1) {
		return UNITHEIGHT * 122.0f;
	} else if (indexPath.row == 3){

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			return UNITHEIGHT * 60;
		}
		//如果状态值为不为0，代表展开
		else{
			return UNITHEIGHT * 80 + (_picArr.count - 1) * UNITHEIGHT * 302;
		}

	} else {
		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			return UNITHEIGHT * 60;
		}
		//如果状态值为不为0，代表展开
		else{
			return UNITHEIGHT * 635.0f;
		}
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if (indexPath.row > 2) {

		NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row + 5000];

		if([self.statsDic[str] integerValue] == 0){
			[self.statsDic setObject:@1 forKey:str];
		}
		//如果状态值为不为0，代表展开
		else{
			[self.statsDic setObject:@0 forKey:str];
		}

		// 刷新
		[_infoTableView reloadData];
	}
}

- (void)multiplieurPic:(NSInteger)imageViewTag total:(NSInteger)total {

	SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
	photoBrowser.delegate = self;
	photoBrowser.currentImageIndex = imageViewTag;
	photoBrowser.sourceImagesContainerView = self.view;
	photoBrowser.imageCount = total;

	[photoBrowser show];
}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
	// 不建议用此种方式获取小图，这里只是为了简单实现展示而已
	UIImageView *imageView;
	[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _picArr[index]]] placeholderImage:[UIImage imageNamed:@""]];

	return imageView.image;

}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@", _picArr[index]]];
}


#pragma mark KVC 回调
//本例设置headerView的最大高度为200，最小为64
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"contentOffset"])
	{
		CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];

		if (offset.y > -UNITHEIGHT * 422.5 + 64) {
			_isUp = 1;

			UIView *effectView = (UIView *)[self.view viewWithTag:1111111];
			effectView.alpha = 1 - (offset.y / (-UNITHEIGHT * 422.5 + 64));

			for (NSInteger i = 0; i < _picArr.count; i++) {

				UIView *effectView = (UIView *)[self.view viewWithTag:110000 + i];
				effectView.alpha = 1 - (offset.y / (-UNITHEIGHT * 422.5 + 64));
			}

			[self.view sendSubviewToBack:_headView];
			[self.view bringSubviewToFront:_hiddenView];
			[self.view bringSubviewToFront:_shareView];
			[self.view bringSubviewToFront:_collection];
			[self.view bringSubviewToFront:_footView];
			if (offset.y > UNITHEIGHT * 7) {
				_rightNavigationView.hidden = NO;
				_rightNavigationView.frame = CGRectMake(_rightNavigationView.frame.origin.x, -offset.y + 64 + UNITHEIGHT * 7, _rightNavigationView.frame.size.width, _rightNavigationView.frame.size.height);

				if (offset.y > UNITHEIGHT * 40) {
					_rightNavigationView.frame = CGRectMake(_rightNavigationView.frame.origin.x, UNITHEIGHT *  28, _rightNavigationView.frame.size.width, _rightNavigationView.frame.size.height);
				}
			}  else {
				_rightNavigationView.hidden = YES;
			}
		} else {
			_isUp = 0;
			[self.view sendSubviewToBack:_infoTableView];
			[self.view bringSubviewToFront:_hiddenView];
			[self.view bringSubviewToFront:_shareView];
			[self.view bringSubviewToFront:_collection];
			[self.view bringSubviewToFront:_footView];
		}
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[[LCZAVPlayerTool shareSingleton].player pause];
	if (scrollView == _infoTableView) {

		if (scrollView.contentOffset.y > - UNITHEIGHT * 280 && scrollView.contentOffset.y < 64) {
			[_infoTableView setContentOffset:CGPointMake(0, UNITHEIGHT * 44) animated:YES];
		} else if (scrollView.contentOffset.y < -UNITHEIGHT * 280 && scrollView.contentOffset.y > -UNITHEIGHT * 422.5 + 64) {
			[_infoTableView setContentOffset:CGPointMake(0, -UNITHEIGHT * 422.5 + 64) animated:YES];
		}
	}
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	[[LCZAVPlayerTool shareSingleton].player pause];
	if (scrollView == _infoTableView) {

		if (scrollView.contentOffset.y > - UNITHEIGHT * 280 && scrollView.contentOffset.y < 64) {
			[_infoTableView setContentOffset:CGPointMake(0, UNITHEIGHT * 44) animated:YES];
		} else if (scrollView.contentOffset.y < -UNITHEIGHT * 280 && scrollView.contentOffset.y > -UNITHEIGHT * 422.5 + 64) {
			[_infoTableView setContentOffset:CGPointMake(0, -UNITHEIGHT * 422.5 + 64) animated:YES];
		}
	}
}

- (void)pageAction:(UIPageControl *)page {
	[self.picScrollView setContentOffset:CGPointMake(page.currentPage * WIDTH, 0) animated:YES];
}



#pragma mark - buttonAction
- (void)footButton:(UIButton *)button {
	NSLog(@"加入购物袋");

	UIButton *shopButton = (UIButton *)[self.view viewWithTag:99999];
	RIghtNavigationView *navigationView = (RIghtNavigationView *)[self.view viewWithTag:7654322];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/shoppingCart.php?act=add" params:@{@"goods_id" : _productModel.goods_id} Success:^(id responseObject) {

		if ([responseObject[@"error"] isEqual:@0]) {
			[self shopCarButtonEvent:shopButton];
		} else {
			[RegosterAlert showAlert:@"加入购物车失败" err:nil];
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			_rightNavigationView.numberLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"goods_number"]];
			navigationView.numberLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"goods_number"]];
		});

	} Failed:^(NSError *error) {

	}];

}

- (void)footRightButton:(UIButton *)button {
	NSLog(@"支付定金");

//	NSString *res = [self jumpToBizPay];
//	if( ![@"" isEqual:res] ){
//		UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//
//		[alter show];
//	}

//	[NetWorkingTool PostNetWorking:@"http://yucheng.chebank.com/mapi/apppay.php" params:nil Success:^(id responseObject) {
//
//		NSLog(@"%@", responseObject);
//
//		[WXPay WXPay:responseObject Success:^{
//			// 支付成功
//
//
//		}];
//
//	} Failed:^(NSError *error) {
//		
//	}];


	[self footButton:footButton];
	// 进入购物车
	ShoppingBagVC *shoppingBagVC = [[ShoppingBagVC alloc] init];
	shoppingBagVC.isTabPush = 0;
	[self.navigationController pushViewController:shoppingBagVC animated:YES];
}



- (void)overButton:(UIButton *)button {
	NSLog(@"售空");
}

- (void)leftButtonPop:(UIButton *)button {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)pushShopping {
	// 进入购物车
	ShoppingBagVC *shoppingBagVC = [[ShoppingBagVC alloc] init];
	shoppingBagVC.isTabPush = 0;
	[self.navigationController pushViewController:shoppingBagVC animated:YES];
}

- (void)relationService {
	// 联系客服
	NSLog(@"联系客服");
}

- (void)takeFavour:(UIButton *)button {
	// 点赞
	RIghtNavigationView *rightView = (RIghtNavigationView *)[self.view viewWithTag:7654321];
	RIghtNavigationView *otherRightView = (RIghtNavigationView *)[self.view viewWithTag:7654322];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userThumbup.php?act=thumbup" params:@{@"goods_id" : _goodsID} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			// 点赞成功
			[RegosterAlert showAlert:@"点赞成功" err:responseObject[@"info"]];
			[otherRightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
			[rightView.favourButton setBackgroundImage:[UIImage imageNamed:@"zan_2"] forState:UIControlStateNormal];
		} else {
			[RegosterAlert showAlert:@"点赞失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
}

- (void)saveCollection:(UIButton *)button {
	// 收藏
	RIghtNavigationView *rightView = (RIghtNavigationView *)[self.view viewWithTag:7654321];
	RIghtNavigationView *otherRightView = (RIghtNavigationView *)[self.view viewWithTag:7654322];

	if (!_isSave) {
		// 加入收藏
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userCollect.php?act=collect" params:@{@"goods_id" : _productModel.goods_id} Success:^(id responseObject) {
			if ([responseObject[@"status"] isEqual:@0]) {
				// 收藏失败
				[RegosterAlert showAlert:@"收藏失败" err:responseObject[@"info"]];
			} else {
				// 收藏成功
				[RegosterAlert showAlert:@"收藏成功" err:responseObject[@"info"]];
				[otherRightView.saveButton setBackgroundImage:[UIImage imageNamed:@"zan_3"] forState:UIControlStateNormal];
				[rightView.saveButton setBackgroundImage:[UIImage imageNamed:@"zan_3"] forState:UIControlStateNormal];
				_isSave = 1;
			}

		} Failed:^(NSError *error) {
			
		}];
	} else {
		// 删除收藏
		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userCollect.php?act=cancel" params:@{@"goods_id" : _productModel.goods_id} Success:^(id responseObject) {
			if ([responseObject[@"status"] isEqual:@0]) {
				// 取消收藏失败
				[RegosterAlert showAlert:@"取消收藏失败" err:responseObject[@"info"]];
			} else {
				// 取消收藏成功
				[RegosterAlert showAlert:@"取消收藏成功" err:responseObject[@"info"]];
				[otherRightView.saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
				[rightView.saveButton setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
				_isSave = 0;
			}

		} Failed:^(NSError *error) {

		}];
	}
}



#pragma mark - 分享
- (void)shareImage {
	// 分享
	// 微博
//	OSMessage *message=[[OSMessage alloc]init];
//	message.title=@"玉城";
//	message.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
//
//	[OpenShare shareToWeibo:message Success:^(OSMessage *message) {
//		NSLog(@"分享到sina微博成功:\%@",message);
//	} Fail:^(OSMessage *message, NSError *error) {
//		NSLog(@"分享到sina微博失败:\%@\n%@",message,error);
//	}];

	// 微信
//	OSMessage *msg=[[OSMessage alloc]init];
//	msg.title=@"玉城";
//	msg.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
//	msg.thumbnail = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon (4)" ofType:@"png"]];
//	msg.link = @"http://yucheng.chebank.com/mobile/";
//
//	[OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//		ULog(@"微信分享到朋友圈成功：\n%@",message);
//	} Fail:^(OSMessage *message, NSError *error) {
//		ULog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
//	}];

//	[OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//		ULog(@"微信分享到会话成功：\n%@",message);
//	} Fail:^(OSMessage *message, NSError *error) {
//		ULog(@"微信分享到会话失败：\n%@\n%@",error,message);
//	}];

	// QQ
//	OSMessage *msg=[[OSMessage alloc] init];
//	msg.title = @"玉城";
//	msg.link = @"http://yucheng.chebank.com/mobile/";
//	msg.image = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"u=3088881127,3891192212&fm=21&gp=0" ofType:@"jpg"]];
//	msg.thumbnail = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon (4)" ofType:@"png"]];
//	msg.desc = [NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];
//
//	[OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//		ULog(@"分享到QQ空间成功:%@",msg);
//	} Fail:^(OSMessage *message, NSError *error) {
//		ULog(@"分享到QQ空间失败:%@\n%@",msg,error);
//	}];

	_shareView.hidden = NO;
	_collection.hidden = NO;
}

- (void)shareHidden:(UITapGestureRecognizer *)tap {
	_collection.hidden = YES;
	_shareView.hidden = YES;
	_qrView.hidden = YES;
}

- (void)qrViewTap:(UITapGestureRecognizer *)tap {
	_qrView.hidden = YES;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.hidden = YES;
	self.tabBarController.tabBar.hidden = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[[LCZAVPlayerTool shareSingleton].player pause];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
	[self scrollViewDidEndDecelerating:_picScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navigationController.navigationBar.hidden = NO;
	self.tabBarController.tabBar.hidden = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	[[LCZAVPlayerTool shareSingleton].player pause];
}


#pragma mark - 购物车动画
- (void)shopCarButtonEvent:(UIButton *)button_
{
	CGRect rr = button_.frame;
	rr.size.width = 34;
	rr.size.height = 34;
	rr.origin.x = (WIDTH - 34) / 2;
	rr.origin.y = (HEIGHT - 34) / 2;
	[self addToShopCarAnimation:rr];
}



//添加到购物车动画
- (void)addToShopCarAnimation:(CGRect)rect
{
	CGFloat moveD = rect.origin.y - 20;

	NSTimeInterval nowTime = [[NSDate date]timeIntervalSince1970] * 1000;
	NSInteger imTag = (long)nowTime % (3600000 * 24);
	UIImageView * sImgView = [[UIImageView alloc]initWithFrame:rect];
	sImgView.tag = imTag;
	sImgView.image = [UIImage imageNamed:@"upimMainGrayShopCar"];
	[self.view addSubview:sImgView];

	//组动画之修改透明度
	CABasicAnimation * alphaBaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	alphaBaseAnimation.fillMode = kCAFillModeForwards;//不恢复原态
	alphaBaseAnimation.duration = 2.0 * moveD / 800;
	alphaBaseAnimation.removedOnCompletion = NO;
	[alphaBaseAnimation setToValue:[NSNumber numberWithFloat:0.3]];
	alphaBaseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//决定动画的变化节奏

	//组动画之缩放动画
	CABasicAnimation * scaleBaseAnimation = [CABasicAnimation animation];
	scaleBaseAnimation.removedOnCompletion = NO;
	scaleBaseAnimation.fillMode = kCAFillModeForwards;//不恢复原态
	scaleBaseAnimation.duration = 2.0 * moveD / 800;
	scaleBaseAnimation.keyPath = @"transform.scale";
	scaleBaseAnimation.toValue = @0.3;

	//组动画之路径变化
	CGMutablePathRef path = CGPathCreateMutable();//创建一个路径
	CGPathMoveToPoint(path, NULL, sImgView.center.x, sImgView.center.y);
	//下面8行添加8条直线的路径到path中
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 10,sImgView.center.y-moveD / 8);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 20 * 3,sImgView.center.y - moveD / 4);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 40 * 7,sImgView.center.y - moveD / 8 * 3);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 80 * 15,sImgView.center.y - moveD / 2);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 40 * 7,sImgView.center.y - moveD / 8 * 5);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 20 * 3,sImgView.center.y - moveD / 4 * 3);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x - moveD / 10,sImgView.center.y - moveD / 8 * 7);
//	CGPathAddLineToPoint(path,NULL,sImgView.center.x,sImgView.center.y - moveD);

	if (_isUp) {
		CGPathAddLineToPoint(path, NULL, WIDTH - UNITHEIGHT * 40, UNITHEIGHT * 44);
	} else {
		CGPathAddLineToPoint(path, NULL, WIDTH - UNITHEIGHT * 40, UNITHEIGHT * 432.5);
	}


	CAKeyframeAnimation * frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	frameAnimation.duration = 2.0 * moveD / 800;
	frameAnimation.removedOnCompletion = NO;
	frameAnimation.fillMode = kCAFillModeForwards;
	[frameAnimation setPath:path];
	CFRelease(path);

	CAAnimationGroup *animGroup = [CAAnimationGroup animation];
	animGroup.animations = @[alphaBaseAnimation,scaleBaseAnimation,frameAnimation];
	animGroup.duration = 2.0 * moveD / 800;
	animGroup.fillMode = kCAFillModeForwards;//不恢复原态
	animGroup.removedOnCompletion = NO;
	[sImgView.layer addAnimation:animGroup forKey:[NSString stringWithFormat:@"%ld",(long)imTag]];

	NSDictionary * dic = @{@"animationGroup":sImgView};
	NSTimer * t = [NSTimer scheduledTimerWithTimeInterval:animGroup.duration target:self selector:@selector(removeImgView:) userInfo:dic repeats:NO];
	[[NSRunLoop currentRunLoop]addTimer:t forMode:NSRunLoopCommonModes];
}

- (void)removeImgView:(NSTimer *)timer
{
	//    NSLog(@"%@",timer.userInfo);
	UIImageView * imgView = (UIImageView *)[timer.userInfo objectForKey:@"animationGroup"];

	if (imgView) {
		[imgView removeFromSuperview];
		imgView = nil;
	}

	if (timer) {
		[timer invalidate];
		timer = nil;
	}
}



#pragma mark - playButton
- (void)playButton:(UIButton *)button {
	_playerImageView.hidden = YES;
	UIView *picBackView = (UIView *)[self.view viewWithTag:600];
	if (_isPlay) {
		[[LCZAVPlayerTool shareSingleton].player pause];
		_hiddenView.hidden = YES;
		picBackView.hidden = NO;
		[button setBackgroundImage:[UIImage imageNamed:@"播放图标"] forState:UIControlStateNormal];
	} else {
		[[LCZAVPlayerTool shareSingleton].player play];
		_hiddenView.hidden = NO;
		picBackView.hidden = YES;
		[button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
	}
	_isPlay = !_isPlay;
}

- (void)hiddenTap:(UITapGestureRecognizer *)tap {
	[[LCZAVPlayerTool shareSingleton].player pause];
	_hiddenView.hidden = YES;
	[self playButton:_playButton];
}


#pragma mark - 取色
- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
	UIColor* color = nil;
	//    CGImageRef inImage = self.image.CGImage;

	UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	CGImageRef inImage = viewImage.CGImage;

	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return nil; /* error */ }

	size_t w = self.view.bounds.size.width;
	size_t h = self.view.bounds.size.height;

	CGRect rect = {{0,0},{w,h}};

	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage);

	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
		//        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}

	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { free(data); }

	return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {

	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;

	size_t pixelsWide = self.view.bounds.size.width;
	size_t pixelsHigh = self.view.bounds.size.height;

	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);

	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();

	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}

	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}

	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}

	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );

	return context;
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
