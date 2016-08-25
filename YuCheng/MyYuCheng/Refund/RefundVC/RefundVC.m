//
//  RefundVC.m
//  YuCheng
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RefundVC.h"
#import "refundCell.h"
#import "RefundLogisticsVC.h"
#import "infoProductModel.h"

@interface RefundVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, refundCellDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UITextView *descTextView;

//@property (nonatomic, strong) UITextView *messageTextView;
//
//@property (nonatomic, strong) UIButton *updataButton;

@property (nonatomic, strong) UIButton *refundButton;

@property (nonatomic, strong) UICollectionView *updateCollection;

@property (nonatomic, strong) NSMutableArray *updateArr;

@property (nonatomic, strong) NSMutableDictionary *modelDic;

@end

@implementation RefundVC

{
	NSString *descStr;// 问题描述
	NSMutableArray *picArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = @"申请退款";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_updateArr = [NSMutableArray arrayWithCapacity:0];

	UIImage *image = [UIImage imageNamed:@"yc6.24-90.png"];
	[_updateArr addObject:image];

	__weak __typeof(&*self)weakSelf = self;
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=to_apply" params:@{@"order_id" : _order_id, @"goods_id" : _goods_id, @"product_id" : _product_id} Success:^(id responseObject) {

		infoProductModel *model = [infoProductModel mj_objectWithKeyValues:responseObject[@"back_goods"]];
		_modelDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];

		dispatch_async(dispatch_get_main_queue(), ^{
			weakSelf.titleLabel.text = model.goods_name;
			weakSelf.moneyLabel.text = model.goods_price;
			weakSelf.nameLabel.text = model.supplier_name;
			[weakSelf.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	UIView *topLine = [[UIView alloc] init];
	topLine.backgroundColor = [UIColor blackColor];
	[self.view addSubview:topLine];

	[topLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(self.view).with.offset(64);
	}];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"玉城LOGO-16.jpg"]];
	[self.view addSubview:_picImageView];

	[_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(topLine);
		make.width.height.mas_equalTo(UNITHEIGHT * 100);
		make.top.mas_equalTo(topLine).with.offset(UNITHEIGHT * 10);
	}];

	UIView *bottomLine = [[UIView alloc] init];
	bottomLine.backgroundColor = [UIColor blackColor];
	[self.view addSubview:bottomLine];

	[bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.left.mas_equalTo(topLine);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(1);
	}];

	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = boldFont(14);
	[self.view addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.moneyLabel = [[UILabel alloc] init];
	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(14);
	[self.view addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.nameLabel = [[UILabel alloc] init];
	_nameLabel.text = @"店名";
	_nameLabel.font = font(14);
	[self.view addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.descTextView = [[UITextView alloc] init];
	_descTextView.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1];
	_descTextView.text = @"问题描述";
	_descTextView.delegate = self;
	[self.view addSubview:_descTextView];

	[_descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(topLine);
		make.top.mas_equalTo(bottomLine).with.offset(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 100);
	}];

//	self.messageTextView = [[UITextView alloc] init];
//	_messageTextView.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1];
//	_messageTextView.text = @"留言";
//	[self.view addSubview:_messageTextView];
//
//	[_messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(_descTextView);
//		make.top.mas_equalTo(_descTextView.mas_bottom).with.offset(UNITHEIGHT * 15);
//		make.right.mas_equalTo(self.view.mas_centerX).with.offset(-UNITHEIGHT * 5);
//		make.height.mas_equalTo(UNITHEIGHT * 150);
//	}];
//
//	self.updataButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[_updataButton setBackgroundImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
//	[self.view addSubview:_updataButton];
//
//	[_updataButton mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.mas_equalTo(self.view.mas_centerX).with.offset(UNITHEIGHT * 5);
//		make.height.top.mas_equalTo(_messageTextView);
//		make.right.mas_equalTo(topLine);
//	}];

	UILabel *updateLabel = [[UILabel alloc] init];
	updateLabel.font = font(14);
	updateLabel.text = @"上传凭证：";
	[self.view addSubview:updateLabel];

	[updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_descTextView);
		make.top.mas_equalTo(_descTextView.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_refundButton.layer.borderWidth = 1;
	_refundButton.layer.borderColor = [UIColor blackColor].CGColor;
	[_refundButton setTitle:@"提交退款" forState:UIControlStateNormal];
	[_refundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[_refundButton addTarget:self action:@selector(refundButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_refundButton];

	[_refundButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(topLine);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-UNITHEIGHT * 15);
	}];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.sectionInset = UIEdgeInsetsMake(UNITHEIGHT * 10, UNITHEIGHT * 20, UNITHEIGHT * 10, UNITHEIGHT * 20);
	flowLayout.minimumInteritemSpacing = UNITHEIGHT * 25;
	flowLayout.minimumLineSpacing = UNITHEIGHT * 25;
	flowLayout.itemSize = CGSizeMake(UNITHEIGHT * 93, UNITHEIGHT * 93);

	self.updateCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	[self.view addSubview:_updateCollection];
	_updateCollection.delegate = self;
	_updateCollection.dataSource = self;
	_updateCollection.backgroundColor = [UIColor whiteColor];
	_updateCollection.bounces = NO;

	[_updateCollection registerClass:[refundCell class] forCellWithReuseIdentifier:@"refundCell"];

	[_updateCollection mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 250);
		make.top.mas_equalTo(updateLabel.mas_bottom).with.offset(UNITHEIGHT * 15);
	}];

}



#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _updateArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	refundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"refundCell" forIndexPath:indexPath];
	cell.delegate = self;
	[cell.updateImageView setBackgroundImage:_updateArr[_updateArr.count - indexPath.item - 1] forState:UIControlStateNormal];

	return cell;
}



#pragma mark - 图片上传
- (void)updateImageView:(UIButton *)button {
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	// 可编辑
	picker.allowsEditing = YES;
	// 要通过choose获取本地图片就必须签订协议
	picker.delegate = self;
	// 模态显示出来
	[self presentViewController:picker animated:YES completion:^{

	}];

	button.userInteractionEnabled = NO;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	// 先让相册消失
	[picker dismissViewControllerAnimated:YES completion:^{

	}];
	UIImage *image = info[UIImagePickerControllerEditedImage];


	
	[_updateArr addObject:image];
	dispatch_async(dispatch_get_main_queue(), ^{
		[_updateCollection reloadData];
	});
	
}



#pragma mark - textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
	textView.text = nil;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
	descStr = textView.text;
}



#pragma mark - refundButton
- (void)refundButton:(UIButton *)button {
	[self.view endEditing:YES];
	if (_updateArr.count == 1 || _updateArr.count == 0) {
		return;
	} else {

		// 上传图片
		picArr = [NSMutableArray arrayWithCapacity:0];
		for (__block NSInteger i = 0; i < _updateArr.count; i++) {

			NetWorkingTool *tool = [[NetWorkingTool alloc] init];
			[tool uploadImg:_updateArr[i] URL:@"http://www.jadechina.cn/mapi/backImgUpload.php" type:nil Success:^(id responseObject) {

				[picArr addObject:responseObject[@"img_url"]];

				NSLog(@"%@", picArr);
				NSLog(@"%ld", i);

				dispatch_async(dispatch_get_main_queue(), ^{
					NSString *imgs;
					for (NSInteger j = 0; j < picArr.count; j++) {
						if (j == 0) {
							imgs = @"";
						} else {
							imgs = [NSString stringWithFormat:@"%@,%@", imgs, picArr[j]];
						}
					}

					if (picArr.count == i) {
						[self updateImageViewWithPicArr:imgs];
					}
				});
			}];
		}
	}



//	RefundLogisticsVC *logisticsVC = [[RefundLogisticsVC alloc] init];
//	[self.navigationController pushViewController:logisticsVC animated:YES];
}

- (void)updateImageViewWithPicArr:(NSString *)imgs {

	if (descStr.length <= 0) {
		descStr = @"";
	}



	NSDictionary *paramsDic = @{@"tui_goods_price" : _modelDic[@"back_goods"][@"goods_price"], @"product_id_tui" : _modelDic[@"back_goods"][@"product_id"], @"goods_attr_tui" : _modelDic[@"back_goods"][@"goods_attr"], @"tui_goods_number" : @1, @"back_pay" : @2, @"country" : _modelDic[@"order"][@"country"], @"province" : _modelDic[@"order"][@"province"], @"city" : _modelDic[@"order"][@"city"], @"district" : _modelDic[@"order"][@"district"], @"back_address" : _modelDic[@"order"][@"address"], @"back_zipcode" : _modelDic[@"order"][@"zipcode"], @"back_consignee" : _modelDic[@"order"][@"consignee"], @"back_mobile" : _modelDic[@"order"][@"mobile"], @"order_id" : _modelDic[@"back_goods"][@"order_id"], @"order_sn" : _modelDic[@"back_goods"][@"order_sn"], @"goods_id" : _modelDic[@"back_goods"][@"goods_id"], @"goods_name" : _modelDic[@"back_goods"][@"goods_name"], @"goods_sn" : _modelDic[@"back_goods"][@"goods_sn"], @"back_reason" : descStr, @"imgs" : [imgs substringFromIndex:1], @"back_type" : @"1"};

	NSLog(@"%@", paramsDic);

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=do_apply" params:paramsDic Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[self showAlert:@"申请退款成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"申请退款失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];

}

- (void)showAlert:(NSString *)title err:(NSString *)err {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:err preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *tureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self.navigationController popViewControllerAnimated:YES];
	}];
	[alert addAction:tureAction];

	[self presentViewController:alert animated:YES completion:^{

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
