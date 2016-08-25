//
//  RefundLogisticsVC.m
//  YuCheng
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RefundLogisticsVC.h"
#import "InfoOrderGoodsModel.h"

@interface RefundLogisticsVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) UILabel *otherStartLabel;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UIButton *tureButton;

@property (nonatomic, strong) UILabel *refundLabel;

@property (nonatomic, strong) UILabel *timeView;

@end

@implementation RefundLogisticsVC

{
	NSString *descStr;
	NSMutableDictionary *modelDic;
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
	__weak __typeof(&*self)weakSelf = self;
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=detail" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		InfoOrderGoodsModel *model = [InfoOrderGoodsModel mj_objectWithKeyValues: responseObject[@"back_order"]];
		modelDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];

		dispatch_async(dispatch_get_main_queue(), ^{
			weakSelf.titleLabel.text = model.goods_name;
			weakSelf.nameLabel.text = model.supplier_name;
			weakSelf.moneyLabel.text = model.back_goods_price;
			[weakSelf.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
			weakSelf.otherStartLabel.text = model.status_back_desc;
			weakSelf.timeView.text = [NSString stringWithFormat:@"%@天" ,responseObject[@"delback_time"]];
			
			[self reloadInputViews];
		});


	} Failed:^(NSError *error) {
		
	}];

}

#pragma mark - createView
- (void)createView {

	[self createGoodsInfoView];

	[self createContent];

	[self createButton];
}

- (void)createGoodsInfoView {
	UIView *topLine = [[UIView alloc] init];
	topLine.backgroundColor = [UIColor blackColor];
	[self.view addSubview:topLine];

	[topLine mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(1);
		make.top.mas_equalTo(self.view).with.offset(64);
	}];

	self.picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
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
//	_titleLabel.text = @"糯冰种晴水飘阳绿";
	_titleLabel.font = boldFont(14);
	[self.view addSubview:_titleLabel];

	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView.mas_right).with.offset(UNITHEIGHT * 10);
		make.top.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	self.moneyLabel = [[UILabel alloc] init];
//	_moneyLabel.text = @"¥41000";
	_moneyLabel.font = font(14);
	[self.view addSubview:_moneyLabel];

	[_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.nameLabel = [[UILabel alloc] init];
//	_nameLabel.text = @"店名";
	_nameLabel.font = font(14);
	[self.view addSubview:_nameLabel];

	[_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_titleLabel);
		make.top.mas_equalTo(_moneyLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	self.startLabel = [[UILabel alloc] init];
	_startLabel.font = font(14);
//	_startLabel.text = @"状态：退款中";
	_startLabel.textColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1];
	[self.view addSubview:_startLabel];

	[_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.left.mas_equalTo(_titleLabel);
	}];
}

- (void)createContent {

	self.otherStartLabel = [[UILabel alloc] init];
//	_otherStartLabel.text = @"状态：退货";
	_otherStartLabel.font = font(14);
	[self.view addSubview:_otherStartLabel];

	[_otherStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 10);
		make.top.mas_equalTo(_picImageView.mas_bottom).with.offset(UNITHEIGHT * 30);
	}];

	self.textField = [[UITextField alloc] init];
	_textField.placeholder = @"物流单号";
	_textField.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
	_textField.layer.borderColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1].CGColor;
	_textField.layer.borderWidth = 1;
	_textField.delegate = self;
	[self.view addSubview:_textField];

	[_textField mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_otherStartLabel);
		make.top.mas_equalTo(_otherStartLabel.mas_bottom).with.offset(UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 40);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
	}];

	self.descriptionLabel = [[UILabel alloc] init];
	_descriptionLabel.text = @"为了保障您的退款顺利，\n请使用顺丰速运，并为产品保价，\n如未保价，出现货物损坏、丢失等问题，\n损失将由买家自行承担";
	_descriptionLabel.font = font(14);
	_descriptionLabel.numberOfLines = 0;
	[_descriptionLabel sizeToFit];
	[self.view addSubview:_descriptionLabel];

	[_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_otherStartLabel);
		make.top.mas_equalTo(_textField.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.width.mas_equalTo(_textField);
	}];
}

- (void)createButton {
	self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
	_cancleButton.backgroundColor = [UIColor whiteColor];
	_cancleButton.layer.borderWidth = 1;
	_cancleButton.layer.borderColor = [UIColor colorWithHexString:@"#792b34"].CGColor;
	[_cancleButton setTitle:@"取消退款" forState:UIControlStateNormal];
	[_cancleButton setTitleColor:[UIColor colorWithHexString:@"#792b34"] forState:UIControlStateNormal];
	[_cancleButton addTarget:self action:@selector(cancleButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_cancleButton];

	[_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_picImageView);
		make.right.mas_equalTo(self.view.mas_centerX);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
	}];

	self.tureButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_tureButton setTitle:@"提交单号" forState:UIControlStateNormal];
	[_tureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_tureButton addTarget:self action:@selector(tureButton:) forControlEvents:UIControlEventTouchUpInside];
	_tureButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[self.view addSubview:_tureButton];

	[_tureButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_cancleButton.mas_right);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 45);
		make.bottom.mas_equalTo(_cancleButton);
	}];

//	self.timeView = [[JustStartTimeView alloc] init];
//	[_timeView countDownViewWithEndString:@"2016-8-20"];
//	_timeView.dayLabel.font = font(14);
//	_timeView.hourLabel.font = font(14);
//	_timeView.minuteLabel.font = font(14);
//	_timeView.secondLabel.font = font(14);
//	[self.view addSubview:_timeView];

	self.timeView = [[UILabel alloc] init];
	_timeView.font = font(14);
	[self.view addSubview:_timeView];

	[_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_cancleButton).with.offset(UNITHEIGHT * 10);
		make.bottom.mas_equalTo(_cancleButton.mas_top).with.offset(-UNITHEIGHT * 20);
		make.height.mas_equalTo(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 100);
	}];

	self.refundLabel = [[UILabel alloc] init];
	_refundLabel.text = @"退货时限";
	_refundLabel.font = font(14);
	[self.view addSubview:_refundLabel];

	[_refundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(_cancleButton);
		make.bottom.mas_equalTo(_timeView.mas_top);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

}



#pragma mark - textField
- (void)textFieldDidEndEditing:(UITextField *)textField {
	descStr = textField.text;
}

#pragma mark - buttonAction
- (void)cancleButton:(UIButton *)button {
	[self.view endEditing:YES];
	NSLog(@"取消退款");

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=cancel" params:@{@"back_order_id" : _back_order_id} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"取消退款成功" err:nil];
		} else {
			[RegosterAlert showAlert:@"取消退款失败" err:responseObject[@"info"]];
		}

	} Failed:^(NSError *error) {

	}];
}

- (void)tureButton:(UIButton *)button {
	[self.view endEditing:YES];
	NSLog(@"提交单号");

	if (descStr.length == 0) {
		descStr = @"";
	}
	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/backOrder.php?act=commit_back_info" params:@{@"back_order_id" : _back_order_id, @"shipping_id" : modelDic[@"shipping_id"], @"invoice_no" : descStr} Success:^(id responseObject) {

		if ([responseObject[@"status"] isEqual:@1]) {
			[self showAlert:@"提交单号成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"提交单号失败" err:responseObject[@"info"]];
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
