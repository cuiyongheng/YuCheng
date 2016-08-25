//
//  ShopStoreVC.m
//  YuCheng
//
//  Created by apple on 16/6/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ShopStoreVC.h"
#import "ShopStoreBannerCell.h"
#import "ShopStoreTwoCell.h"
#import "ShopStoreThreeCell.h"
#import "ShopStoreFourCell.h"
#import "personalStoreVC.h"
#import "MapCell.h"
#import "ShopStoreModel.h"
#import "SDPhotoBrowser.h"

@interface ShopStoreVC ()<UITableViewDataSource, UITableViewDelegate, ShopStoreTwoCellDelegate,BMKGeoCodeSearchDelegate, ShopStoreThreeCellDelegate, SDPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BMKGeoCodeSearch *searcher;

@property (nonatomic, strong) ShopStoreModel *shopModel;

//@property (nonatomic, strong) UIView *backView;

//@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation ShopStoreVC

{
	BOOL isOpenInfo;
	BOOL isCertificateOpen;
	BOOL isAddressOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.navigationItem.rightBarButtonItem = nil;

	[self createView];

	[self createData];
}

#pragma mark - createData
- (void)createData {

	__weak __typeof(&*self)weakSelf = self;
	NSLog(@"%@", _supplier_id);
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/supplierIndex.php" params:@{@"supplier_id" : _supplier_id} Success:^(id responseObject) {

		_shopModel = [ShopStoreModel mj_objectWithKeyValues:responseObject];
		weakSelf.title = [NSString stringWithFormat:@"%@", _shopModel.shop_name];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	self.automaticallyAdjustsScrollViewInsets = NO;
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - UNITHEIGHT * 80 - 44) style:UITableViewStylePlain];
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[ShopStoreBannerCell class] forCellReuseIdentifier:@"shopstoreCell"];

	[_tableView registerClass:[ShopStoreTwoCell class] forCellReuseIdentifier:@"shopstoreTwoCell"];

	[_tableView registerClass:[ShopStoreThreeCell class] forCellReuseIdentifier:@"shopstoreThreeCell"];

	[_tableView registerClass:[MapCell class] forCellReuseIdentifier:@"shopstoreFourCell"];

	// button
	UIButton *comeShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[comeShopButton setTitle:@"进入店铺" forState:UIControlStateNormal];
	[comeShopButton setTitleColor:[UIColor colorWithHexString:@"#fefefe"] forState:UIControlStateNormal];
	[comeShopButton addTarget:self action:@selector(comeShopButton:) forControlEvents:UIControlEventTouchUpInside];
	comeShopButton.titleLabel.font = font(19);
	comeShopButton.backgroundColor = [UIColor colorWithHexString:@"#2d2f30"];
	[self.view addSubview:comeShopButton];

	[comeShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 16.5);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 16.5);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 45);
	}];



	// 放大
//	self.backView = [[UIView alloc] initWithFrame:self.view.frame];
//	_backView.alpha = 0.8;
//	_backView.backgroundColor = [UIColor blackColor];
//	_backView.hidden = YES;
//	[self.view addSubview:_backView];
//
//	UITapGestureRecognizer *backViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backHidden:)];
//	[_backView addGestureRecognizer:backViewTap];

//	self.backImageView = [[UIImageView alloc] init];
//	_backImageView.hidden = YES;
//	_backImageView.contentMode = UIViewContentModeScaleAspectFill;
//	_backImageView.clipsToBounds = YES;
//	[self.view addSubview:_backImageView];
//
//	[_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.centerX.centerY.mas_equalTo(self.view);
//		make.width.mas_equalTo(WIDTH - UNITHEIGHT * 40);
//		make.height.mas_equalTo(HEIGHT - UNITHEIGHT * 200);
//	}];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		ShopStoreBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopstoreCell"];
		[cell.bannerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, _shopModel.shop_index_img]] placeholderImage:[UIImage imageNamed:@""]];
		cell.numberValueLabel.text = [NSString stringWithFormat:@"%@", _shopModel.goods_number];
		cell.sellOutValueLabel.text = [NSString stringWithFormat:@"%@", _shopModel.sellgoods_number];
		cell.goodLabel.text = [NSString stringWithFormat:@"%@", _shopModel.evaluation];

		return cell;
	} else if (indexPath.row == 1) {
		ShopStoreTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopstoreTwoCell"];
		cell.infoLabel.text = [NSString stringWithFormat:@"%@", _shopModel.shop_desc];

		if (isOpenInfo) {
			cell.infoLabel.hidden = NO;
		} else {
			cell.infoLabel.hidden = NO;
		}

		return cell;
	} else if (indexPath.row == 3) {
		ShopStoreThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopstoreThreeCell"];
		cell.creditArr = _shopModel.shop_credit;
		cell.delegate = self;
		cell.oneImageView.tag = 500;
		cell.twoImageView.tag = 501;
		cell.threeImageView.tag = 502;
		cell.fourImageView.tag = 503;

		if (isCertificateOpen) {
			cell.oneImageView.hidden = NO;
			cell.twoImageView.hidden = NO;
			cell.threeImageView.hidden = NO;
			cell.fourImageView.hidden = NO;
		} else {
			cell.oneImageView.hidden = YES;
			cell.twoImageView.hidden = YES;
			cell.threeImageView.hidden = YES;
			cell.fourImageView.hidden = YES;
		}

		return cell;
	} else {
		MapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopstoreFourCell"];
		cell.addressStr = _shopModel.shop_address;

		if (isAddressOpen) {
			cell.mapView.hidden = NO;
		} else {
			cell.mapView.hidden = YES;
		}

		return cell;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return UNITHEIGHT * 475;
	} else if (indexPath.row == 1) {
		if (isOpenInfo) {
			// 要注意字体大小保持一致
			// 文字的大小作为一个描述信息放到字典中成为一对 key- value
			NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil];
			// 根据文本字体大小来计算文本的cell高度
			// 第一个参数: 文字显示的最大尺寸范围(375, 0)(0 代表最大的意思)
			// 第二个参数:
			CGRect rect = [_shopModel.shop_desc boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];

			return UNITHEIGHT * 60 + rect.size.height;
		} else {
			return UNITHEIGHT * 50;
		}
	} else if (indexPath.row == 3) {
		if (isCertificateOpen) {
			return UNITHEIGHT * 157.5;
		} else {
			return UNITHEIGHT * 50;
		}
	} else if (indexPath.row == 2) {
		if (isAddressOpen) {
			return UNITHEIGHT * 300;
		} else {
			return UNITHEIGHT * 50;
		}
	} else {
		return 0;
	}

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 2) {
		[self arrowButtonOpenInfo:indexPath.row];
	}
}



#pragma mark - CellDelegate
- (void)arrowButtonOpenInfo:(NSInteger)indexRow {
	if (indexRow == 1) {
		isOpenInfo = !isOpenInfo;
	} else if (indexRow == 3) {
		isCertificateOpen = !isCertificateOpen;
	} else if (indexRow == 2) {
		isAddressOpen = !isAddressOpen;
	}

	NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexRow inSection:0];
	NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
	[_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - 进入商铺
- (void)comeShopButton:(UIButton *)button {
	personalStoreVC *personalVC = [[personalStoreVC alloc] init];
	personalVC.supplier_id = _shopModel.supplier_id;
	personalVC.titleStr = _shopModel.shop_name;
	[self.navigationController pushViewController:personalVC animated:YES];
}

#pragma mark - 放大图片
- (void)multiplyingImageView:(NSInteger)imageViewTag {
//	NSLog(@"%@", _shopModel.shop_credit[imageViewTag - 500]);

//	_backView.hidden = NO;
//	_backImageView.hidden = NO;
//	[_backImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, _shopModel.shop_credit[imageViewTag - 500]]] placeholderImage:[UIImage imageNamed:@""]];

	SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
	photoBrowser.delegate = self;
	photoBrowser.currentImageIndex = imageViewTag - 500;
	photoBrowser.sourceImagesContainerView = self.view;
	photoBrowser.imageCount = _shopModel.shop_credit.count;

	[photoBrowser show];
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
	// 不建议用此种方式获取小图，这里只是为了简单实现展示而已
	UIImageView *imageView;
	[imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, _shopModel.shop_credit[index]]] placeholderImage:[UIImage imageNamed:@""]];

	return imageView.image;

}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, _shopModel.shop_credit[index]]];
}

- (void)backHidden:(UITapGestureRecognizer *)tap {
//	_backView.hidden = YES;
//	_backImageView.hidden = YES;
}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
//		self.navigationController.navigationBar.translucent = YES;
	self.tabBarController.tabBar.hidden = YES;
	self.navigationController.navigationBar.hidden = NO;
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor blackColor]];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
	self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	self.navigationController.navigationBar.hidden = NO;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//	self.navigationController.navigationBar.translucent = NO;
	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor whiteColor]];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
	self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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
