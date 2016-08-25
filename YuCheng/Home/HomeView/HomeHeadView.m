//
//  HomeHeadView.m
//  YuCheng
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
//	CYHRollView *rollView = [[CYHRollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 235) image:nil title:nil];
//	[self addSubview:rollView];

	// 轮播
	self.headScroll = [[UIScrollView alloc] init];
	_headScroll.showsHorizontalScrollIndicator = NO;
	_headScroll.pagingEnabled = YES;
	_headScroll.backgroundColor = [UIColor blackColor];
	_headScroll.delegate = self;
	_headScroll.contentOffset = CGPointMake(WIDTH, 0);
	[self addSubview:_headScroll];

	[_headScroll mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.mas_equalTo(WIDTH);
		make.left.and.top.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 235);
	}];

	// 新品
	self.NewButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_NewButton.backgroundColor = [UIColor blackColor];
	_NewButton.layer.cornerRadius = UNITHEIGHT * 37 / 2;
	_NewButton.layer.masksToBounds = YES;
	[_NewButton setBackgroundImage:[UIImage imageNamed:@"yc-03"] forState:UIControlStateNormal];
	[_NewButton addTarget:self action:@selector(tapNewButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_NewButton];

	[_NewButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.and.width.mas_equalTo(UNITHEIGHT * 37);
		make.top.mas_equalTo(self).with.offset(UNITHEIGHT * 251);
		make.left.mas_equalTo(self.mas_left).with.offset(UNITHEIGHT * 53.55);
	}];

	// 商家推荐
	self.recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_recommendButton.backgroundColor = [UIColor blackColor];
	_recommendButton.layer.cornerRadius = UNITHEIGHT * 37 / 2;
	_recommendButton.layer.masksToBounds = YES;
	[_recommendButton setBackgroundImage:[UIImage imageNamed:@"yc-04"] forState:UIControlStateNormal];
	[_recommendButton addTarget:self action:@selector(tapRecommendButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_recommendButton];

	[_recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_NewButton.mas_right).with.offset(UNITWIDTH * 38.42);
		make.top.and.height.and.width.equalTo(_NewButton);
	}];

	// 限时抢购
	self.limitButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_limitButton.backgroundColor = [UIColor blackColor];
	_limitButton.layer.cornerRadius = UNITHEIGHT * 37 / 2;
	_limitButton.layer.masksToBounds = YES;
	[_limitButton setBackgroundImage:[UIImage imageNamed:@"yc-05"] forState:UIControlStateNormal];
	[_limitButton addTarget:self action:@selector(tapLimitButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_limitButton];

	[_limitButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_recommendButton.mas_right).with.offset(UNITWIDTH * 38.42);
		make.top.and.height.and.width.equalTo(_NewButton);
	}];

	// 已卖
	self.sellOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_sellOutButton.backgroundColor = [UIColor blackColor];
	_sellOutButton.layer.cornerRadius = UNITHEIGHT * 37 / 2;
	_sellOutButton.layer.masksToBounds = YES;
	[_sellOutButton setBackgroundImage:[UIImage imageNamed:@"yc-06"] forState:UIControlStateNormal];
	[_sellOutButton addTarget:self action:@selector(tapSellOutButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_sellOutButton];

	[_sellOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_limitButton.mas_right).with.offset(UNITWIDTH * 38.42);
		make.top.and.height.and.width.equalTo(_NewButton);
	}];

	// 新品标签
	self.NewLabel = [[UILabel alloc] init];
	_NewLabel.text = @"新品";
	_NewLabel.font = font(11);
	[self addSubview:_NewLabel];

	[_NewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_NewButton);
		make.top.mas_equalTo(_NewButton.mas_bottom).with.offset(UNITWIDTH * 5);
		make.height.mas_equalTo(UNITWIDTH * 10);
	}];

	// 商家推荐
	self.recommendLabel = [[UILabel alloc] init];
	_recommendLabel.text = @"品牌商家";
	_recommendLabel.font = font(11);
	[self addSubview:_recommendLabel];

	[_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_recommendButton);
		make.top.mas_equalTo(_recommendButton.mas_bottom).with.offset(UNITWIDTH * 5);
		make.height.mas_equalTo(UNITWIDTH * 10);
	}];

	// 限时抢购
	self.limitLabel = [[UILabel alloc] init];
	_limitLabel.text = @"限时抢购";
	_limitLabel.font = font(11);
	[self addSubview:_limitLabel];

	[_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_limitButton);
		make.top.mas_equalTo(_limitButton.mas_bottom).with.offset(UNITWIDTH * 5);
		make.height.mas_equalTo(UNITWIDTH * 10);
	}];

	// 已卖
	self.sellOutLabel = [[UILabel alloc] init];
	_sellOutLabel.text = @"达人推荐";
	_sellOutLabel.font = font(11);
	[self addSubview:_sellOutLabel];

	[_sellOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_sellOutButton);
		make.top.mas_equalTo(_sellOutButton.mas_bottom).with.offset(UNITWIDTH * 5);
		make.height.mas_equalTo(UNITWIDTH * 10);
	}];

	self.backView = [[UIView alloc] init];
	_backView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
	[self addSubview:_backView];

	[_backView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_NewLabel.mas_bottom).with.offset(UNITWIDTH * 16);
		make.height.mas_equalTo(UNITWIDTH * 215);
		make.left.and.right.mas_equalTo(self);
	}];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"精品推荐\nRECOMMEND";
	_titleLabel.numberOfLines = 2;
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.font = boldFont(11.44);
	[self addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.top.mas_equalTo(_backView);
		make.height.mas_equalTo(UNITWIDTH * 40);
	}];

	// 图片
	self.scrollView = [[UIScrollView alloc] init];
	[self addSubview:_scrollView];
	_scrollView.showsHorizontalScrollIndicator = NO;

	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_titleLabel.mas_bottom);
		make.height.mas_equalTo(UNITWIDTH * 167);
		make.left.and.right.mas_equalTo(self);
	}];

	self.page = [[UIPageControl alloc] init];
	[self addSubview:_page];
	_page.currentPageIndicatorTintColor = [UIColor whiteColor];
	_page.pageIndicatorTintColor = [UIColor colorWithHexString:@"#817a75"];
	_page.backgroundColor = [UIColor clearColor];
	[_page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];

	[_page mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.bottom.mas_equalTo(_headScroll).with.offset(-UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 150);
	}];

}



#pragma mark - scrollDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//	if (scrollView == _headScroll) {
////		_page.currentPage = (scrollView.contentOffset.x / WIDTH);
//
////		[self.headScroll setContentOffset:CGPointMake(self.headScroll.contentOffset.x + WIDTH, 0) animated:YES];
////		if (self.headScroll.contentOffset.x == WIDTH * self.adsArr.count + 1) {
////			self.headScroll.contentOffset = CGPointMake(WIDTH, 0);
////			_page.currentPage = 0;
////		} else if (self.headScroll.contentOffset.x == 0) {
////			self.headScroll.contentOffset = CGPointMake(_adsArr.count * WIDTH, 0);
//////			_page.currentPage = scrollView.contentOffset.x / WIDTH - 1;
////		}
//	}
//}

- (void)pageAction:(UIPageControl *)page {
//	[self.headScroll setContentOffset:CGPointMake(page.currentPage * WIDTH, 0) animated:YES];
}



- (void)tapNewButton:(UIButton *)button {
	[self.delegate tapNewViewController];
}

- (void)tapRecommendButton:(UIButton *)button {
	[self.delegate tapRecommendViewController];
}

- (void)tapLimitButton:(UIButton *)button {
	[self.delegate tapLimitRushViewController];
}

- (void)tapSellOutButton:(UIButton *)button {
	[self.delegate tapSellOutViewController];
}

- (void)imageViewTap:(UITapGestureRecognizer *)tap {
	if (tap.view.tag >= 10000 && tap.view.tag < 15000) {
		[self.delegate tapImageView:tap.view.tag];
	} else {
		[self.delegate tapImageView:tap.view.tag];
	}
}

- (void)setAdsArr:(NSMutableArray *)adsArr {
	// 轮播
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, UNITHEIGHT * 235)];
	imageView.backgroundColor = [UIColor blackColor];
	[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, adsArr.lastObject]] placeholderImage:[UIImage imageNamed:@"yc-83"]];
	imageView.layer.borderWidth = 1;
	imageView.tag = 15004;
	imageView.userInteractionEnabled = YES;
	imageView.layer.borderColor = [UIColor blackColor].CGColor;
	[_headScroll addSubview:imageView];

//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
//	[imageView addGestureRecognizer:tap];

	for (NSInteger i = 0; i < adsArr.count; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (i + 1), 0, WIDTH, UNITHEIGHT * 235)];
		imageView.backgroundColor = [UIColor blackColor];
		[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, adsArr[i]]] placeholderImage:[UIImage imageNamed:@"yc-83"]];
		imageView.layer.borderWidth = 1;
		imageView.tag = 15000 + i;
		imageView.userInteractionEnabled = YES;
		imageView.layer.borderColor = [UIColor blackColor].CGColor;
		[_headScroll addSubview:imageView];

//		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
//		[imageView addGestureRecognizer:tap];
	}

	UIImageView *endImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH * (adsArr.count + 1), 0, WIDTH, UNITHEIGHT * 235)];
	endImageView.backgroundColor = [UIColor blackColor];
	[endImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, adsArr.firstObject]] placeholderImage:[UIImage imageNamed:@"yc-83"]];
	endImageView.layer.borderWidth = 1;
	endImageView.tag = 15000;
	endImageView.userInteractionEnabled = YES;
	endImageView.layer.borderColor = [UIColor blackColor].CGColor;
	[_headScroll addSubview:endImageView];

//	UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
//	[endImageView addGestureRecognizer:endTap];

	_headScroll.contentSize = CGSizeMake((adsArr.count + 2) * WIDTH, 0);
	_page.numberOfPages = adsArr.count;
}

- (void)setBestArr:(NSMutableArray *)bestArr {
	for (NSInteger i = 0; i < bestArr.count; i++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UNITWIDTH * 158.4 * i, 0, UNITWIDTH * 152, UNITWIDTH * 158.4)];
		[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, bestArr[i]]] placeholderImage:[UIImage imageNamed:@""]];
		imageView.tag = 10000 + i;
		imageView.userInteractionEnabled = YES;
		imageView.layer.cornerRadius = UNITHEIGHT * 2;
		imageView.layer.masksToBounds = YES;
		[_scrollView addSubview:imageView];

		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
		[imageView addGestureRecognizer:tap];
	}
	_scrollView.contentSize = CGSizeMake(UNITWIDTH * 158.4 * bestArr.count, 0);
}

@end
