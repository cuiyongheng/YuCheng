//
//  OrderRefundVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderRefundVC.h"
#import "OrderlogisticsHeadView.h"
#import "refundCell.h"

@interface OrderRefundVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) OrderlogisticsHeadView *headView;

@property (nonatomic, strong) UILabel *cardLabel;

@property (nonatomic, strong) UILabel *refundTimeLabel;

@property (nonatomic, strong) UILabel *cardTimeLabel;

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic, strong) UILabel *reasonLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation OrderRefundVC

{
	NSString *phone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"订单详情";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	__weak __typeof(&*self)weakSelf = self;
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=detail" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		InfoOrderGoodsModel *model = [InfoOrderGoodsModel mj_objectWithKeyValues:responseObject[@"back_order"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			_headView.model = model;

			if (_isSuccess) {
				weakSelf.refundTimeLabel.text = responseObject[@"action_desc"][@"log_time"];
			} else {
				weakSelf.timeLabel.text = responseObject[@"action_desc"][@"log_time"];
				weakSelf.reasonLabel.text = responseObject[@"action_desc"][@"action_note"];
			}
			phone = responseObject[@"service_phone"];
		});

	} Failed:^(NSError *error) {
		
	}];
}

#pragma mark - createView
- (void)createView {
	self.headView = [[OrderlogisticsHeadView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, UNITHEIGHT * 160)];
	_headView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_headView];

	if (_isSuccess) {
		// 同意退款
		_headView.startLabel.text = @"状态：同意退款";

		UILabel *refundLabel = [[UILabel alloc] init];
		refundLabel.text = @"商家已退款";
		refundLabel.font = font(14);
		[self.view addSubview:refundLabel];

		[refundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
			make.top.mas_equalTo(_headView.mas_bottom).with.offset(UNITHEIGHT * 10);
			make.height.mas_equalTo(UNITHEIGHT * 40);
		}];

//		self.cardLabel = [[UILabel alloc] init];
//		_cardLabel.text = @"已转至中国农业信用社5432尾号的信用卡";
//		_cardLabel.font = font(14);
//		_cardLabel.numberOfLines = 0;
//		[_cardLabel sizeToFit];
//		[self.view addSubview:_cardLabel];
//
//		[_cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.left.mas_equalTo(refundLabel);
//			make.height.mas_equalTo(UNITHEIGHT * 40);
//			make.top.mas_equalTo(refundLabel.mas_bottom);
//			make.width.mas_equalTo(WIDTH / 2 - UNITHEIGHT * 40);
//		}];

		self.refundTimeLabel = [[UILabel alloc] init];
		_refundTimeLabel.text = @"2016-06-23 11:00:00";
		_refundTimeLabel.font = font(14);
		[self.view addSubview:_refundTimeLabel];

		[_refundTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
			make.height.mas_equalTo(UNITHEIGHT * 20);
			make.centerY.mas_equalTo(refundLabel);
			make.left.mas_equalTo(self.view.centerX);
		}];

//		self.cardTimeLabel = [[UILabel alloc] init];
//		_cardTimeLabel.text = @"2016-06-23 11:00:00";
//		[self.view addSubview:_cardTimeLabel];
//		_cardTimeLabel.font = font(14);
//
//		[_cardTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.height.right.left.mas_equalTo(_refundTimeLabel);
//			make.centerY.mas_equalTo(_cardLabel);
//		}];

	} else {
		// 拒绝退款
		_headView.startLabel.text = @"状态：拒绝退款";

		self.timeLabel = [[UILabel alloc] init];
		_timeLabel.font = font(14);
		[self.view addSubview:_timeLabel];

		[_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
			make.top.mas_equalTo(_headView.mas_bottom).with.offset(UNITHEIGHT * 20);
			make.height.mas_equalTo(UNITHEIGHT * 20);
		}];

		self.reasonLabel = [[UILabel alloc] init];
		_reasonLabel.text = @"拒退理由：因为各种原因，本商品无法退款";
		_reasonLabel.font = font(14);
		[self.view addSubview:_reasonLabel];

		[_reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
			make.top.mas_equalTo(_timeLabel.mas_bottom).with.offset(UNITHEIGHT * 20);
			make.height.mas_equalTo(UNITHEIGHT * 20);
		}];



//		UILabel *certificateLabel = [[UILabel alloc] init];
//		certificateLabel.text = @"图片凭证:";
//		certificateLabel.font = font(14);
//		[self.view addSubview:certificateLabel];
//
//		[certificateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.right.height.left.mas_equalTo(_reasonLabel);
//			make.top.mas_equalTo(_reasonLabel.mas_bottom).with.offset(UNITHEIGHT * 20);
//		}];



//		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//		flowLayout.sectionInset = UIEdgeInsetsMake(UNITHEIGHT * 10, UNITHEIGHT * 20, UNITHEIGHT * 10, UNITHEIGHT * 20);
//		flowLayout.minimumInteritemSpacing = UNITHEIGHT * 25;
//		flowLayout.minimumLineSpacing = UNITHEIGHT * 25;
//		flowLayout.itemSize = CGSizeMake(UNITHEIGHT * 93, UNITHEIGHT * 93);
//
//		self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//		[self.view addSubview:_collection];
//		_collection.delegate = self;
//		_collection.dataSource = self;
//		_collection.backgroundColor = [UIColor whiteColor];
//		_collection.bounces = NO;
//
//		[_collection registerClass:[refundCell class] forCellWithReuseIdentifier:@"refundCell"];
//
//		[_collection mas_makeConstraints:^(MASConstraintMaker *make) {
//			make.left.right.mas_equalTo(self.view);
//			make.height.mas_equalTo(UNITHEIGHT * 250);
//			make.top.mas_equalTo(certificateLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
//		}];

		UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[applyButton setTitle:@"申请维权" forState:UIControlStateNormal];
		[applyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		applyButton.backgroundColor = [UIColor whiteColor];
		applyButton.layer.borderColor = [UIColor blackColor].CGColor;
		applyButton.layer.borderWidth = 1;
		[applyButton addTarget:self action:@selector(applyButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:applyButton];

		[applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
			make.height.mas_equalTo(UNITHEIGHT * 45);
			make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
			make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		}];

	}

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	refundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"refundCell" forIndexPath:indexPath];

	[cell.updateImageView setBackgroundImage:[UIImage imageNamed:@"玉城LOGO-19.jpg"] forState:UIControlStateNormal];

	return cell;
}



#pragma mark - applyButton
- (void)applyButton:(UIButton *)button {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请维权" message:[NSString stringWithFormat:@"申请维权请拨打%@", phone] preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *callAlert = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self callAction];
	}];

	UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		[self dismissViewControllerAnimated:YES completion:nil];
	}];

	[alert addAction:callAlert];
	[alert addAction:cancleAlert];
	[self presentViewController:alert animated:YES completion:^{

	}];

}



- (void)callAction{

	NSString *number = phone;// 此处读入电话号码

	NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表



//	NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核

	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
	
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
