//
//  EvaluateVC.m
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EvaluateVC.h"
#import "StarView.h"
#import "StarFinishView.h"
#import "EvaluateModel.h"

@interface EvaluateVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *desTextView;// 描述文本

@property (nonatomic, strong) EvaluateModel *model;

@property (nonatomic, strong) NSMutableDictionary *paramsDic;

@end

@implementation EvaluateVC

{
	UIImageView *picImageView;// 图片
	UILabel *titleLabel;
	UILabel *moneyLabel;
	UILabel *nameLabel;
	UILabel *timeLabel;
	UILabel *evaluateLabel;

	UILabel *descriptionLabel;
	UILabel *serveLabel;
	UILabel *sendLabel;
	UILabel *wuliuLabel;

	StarView *descriptionView;
	StarView *serveView;
	StarView *sendView;
	StarView *wuliuView;

	StarFinishView *descriptionFinishView;
	StarFinishView *serveFinishView;
	StarFinishView *sendFinishView;
	StarFinishView *wuliuFinishView;

	UIButton *takeButton;



	// 输入文本
	NSString *textViewStr;
	NSNumber *comment_rank;// 描述评分
	NSNumber *server;// 服务评分
	NSNumber *send;// 发货评分
	NSNumber *shipping;// 物流评分

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\

	self.title = @"评价宝贝";

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_paramsDic = [NSMutableDictionary dictionaryWithObjects:@[@5, @5, @5, @5] forKeys:@[@"comment_rank", @"server", @"send", @"shipping"]];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userComment.php?act=to_comment" params:@{@"goods_id" : _goodsID, @"rec_id" : _rec_id} Success:^(id responseObject) {

		_model = [EvaluateModel mj_objectWithKeyValues:responseObject[@"comment_info"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			if (!_isFinishEvaluate) {
				// 未评论

			} else {
				// 以评论
				takeButton.hidden = YES;
				_desTextView.text = [NSString stringWithFormat:@"%@", _model.content];

				[descriptionFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.centerY.mas_equalTo(descriptionLabel);
					make.left.mas_equalTo(descriptionLabel.mas_right).with.offset(UNITHEIGHT * 20);
					make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_model.comment_rank floatValue]);
					make.height.mas_equalTo(UNITHEIGHT * 40);
				}];

				[serveFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.centerY.mas_equalTo(serveLabel);
					make.left.mas_equalTo(serveLabel.mas_right).with.offset(UNITHEIGHT * 20);
					make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_model.server floatValue]);
					make.height.mas_equalTo(UNITHEIGHT * 40);
				}];

				[sendFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.centerY.mas_equalTo(sendLabel);
					make.left.mas_equalTo(sendLabel.mas_right).with.offset(UNITHEIGHT * 20);
					make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_model.send floatValue]);
					make.height.mas_equalTo(UNITHEIGHT * 40);
				}];

				[wuliuFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
					make.centerY.mas_equalTo(wuliuLabel);
					make.left.mas_equalTo(wuliuLabel.mas_right).with.offset(UNITHEIGHT * 20);
					make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_model.shipping floatValue]);
					make.height.mas_equalTo(UNITHEIGHT * 40);
				}];
			}

			[picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, _model.goods_thumb]] placeholderImage:[UIImage imageNamed:@""]];
			titleLabel.text = _model.goods_name;
			moneyLabel.text = _model.shop_price;
			nameLabel.text = _model.supplier_name;

			NSString *str = _model.on_sale_time;//时间戳
			NSTimeInterval time = [str doubleValue] + 28800;//因为时差问题要加8小时 == 28800 sec
			NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
			//实例化一个NSDateFormatter对象
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			//设定时间格式,这里可以设置成自己需要的格式
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
			timeLabel.text = [NSString stringWithFormat:@"成交时间：%@", currentDateStr];
		});

	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 10, UNITHEIGHT * 65, WIDTH - UNITHEIGHT * 20, 1)];
	lineView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.view addSubview:lineView];

	UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 10, UNITHEIGHT * 165, WIDTH - UNITHEIGHT * 20, 1)];
	bottomLine.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[self.view addSubview:bottomLine];

	picImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	[self.view addSubview:picImageView];

	[picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(lineView);
		make.top.mas_equalTo(lineView).with.offset(UNITHEIGHT * 10);
		make.width.height.mas_equalTo(UNITHEIGHT * 80);
	}];

	titleLabel = [[UILabel alloc] init];
//	titleLabel.text = @"糯冰中晴水飘阳绿";
	titleLabel.font = font(13);
	[self.view addSubview:titleLabel];

	[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(picImageView.mas_right).with.offset(UNITHEIGHT *10);
		make.top.mas_equalTo(picImageView);
		make.height.mas_equalTo(UNITHEIGHT * 20);
	}];

	moneyLabel = [[UILabel alloc] init];
//	moneyLabel.text = @"¥41000";
	moneyLabel.font = font(13);
	[self.view addSubview:moneyLabel];

	[moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.left.mas_equalTo(titleLabel);
		make.top.mas_equalTo(titleLabel.mas_bottom);
	}];

	nameLabel = [[UILabel alloc] init];
//	nameLabel.text = @"店名";
	nameLabel.font = font(13);
	[self.view addSubview:nameLabel];

	[nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.height.mas_equalTo(titleLabel);
		make.top.mas_equalTo(moneyLabel.mas_bottom);
	}];

	timeLabel = [[UILabel alloc] init];
//	timeLabel.text = @"成交时间：2016-6-27";
	timeLabel.font = font(13);
	[self.view addSubview:timeLabel];

	[timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.height.mas_equalTo(titleLabel);
		make.top.mas_equalTo(nameLabel.mas_bottom);
	}];



	// 评分
	evaluateLabel = [[UILabel alloc] init];
	evaluateLabel.text = @"评分：";
	evaluateLabel.font = font(20);
	[self.view addSubview:evaluateLabel];

	[evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(lineView).with.offset(UNITHEIGHT * 20);
		make.top.mas_equalTo(bottomLine).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
	}];

	descriptionLabel = [[UILabel alloc] init];
	descriptionLabel.text = @"描述：";
	descriptionLabel.font = font(15);
	[self.view addSubview:descriptionLabel];

	[descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(evaluateLabel);
		make.top.mas_equalTo(evaluateLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];

	serveLabel = [[UILabel alloc] init];
	serveLabel.text = @"服务：";
	serveLabel.font = font(15);
	[self.view addSubview:serveLabel];

	[serveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(evaluateLabel);
		make.top.mas_equalTo(descriptionLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];

	sendLabel = [[UILabel alloc] init];
	sendLabel.text = @"发货：";
	sendLabel.font = font(15);
	[self.view addSubview:sendLabel];

	[sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(evaluateLabel);
		make.top.mas_equalTo(serveLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];

	wuliuLabel = [[UILabel alloc] init];
	wuliuLabel.text = @"物流：";
	wuliuLabel.font = font(15);
	[self.view addSubview:wuliuLabel];

	[wuliuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(evaluateLabel);
		make.top.mas_equalTo(sendLabel.mas_bottom).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 30);
		make.width.mas_equalTo(UNITHEIGHT * 50);
	}];

#warning 星星
	// 星星
	descriptionView = [[StarView alloc] initWithbig:1];
	[self.view addSubview:descriptionView];

	[descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(descriptionLabel);
		make.left.mas_equalTo(descriptionLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 200);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];



	descriptionFinishView = [[StarFinishView alloc] initWithbig:1];
	descriptionFinishView.backgroundColor = [UIColor clearColor];
	descriptionFinishView.clipsToBounds = YES;
	[self.view addSubview:descriptionFinishView];

	if (!_isFinishEvaluate) {

		[descriptionFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(descriptionLabel);
			make.left.mas_equalTo(descriptionLabel.mas_right).with.offset(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 200);
			make.height.mas_equalTo(UNITHEIGHT * 40);
		}];
	}



	serveView = [[StarView alloc] initWithbig:1];
	[self.view addSubview:serveView];

	[serveView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(serveLabel);
		make.left.mas_equalTo(serveLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 200);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];



	serveFinishView = [[StarFinishView alloc] initWithbig:1];
	serveFinishView.backgroundColor = [UIColor clearColor];
	serveFinishView.clipsToBounds = YES;
	[self.view addSubview:serveFinishView];

	if (!_isFinishEvaluate) {

		[serveFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(serveLabel);
			make.left.mas_equalTo(serveLabel.mas_right).with.offset(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 200);
			make.height.mas_equalTo(UNITHEIGHT * 40);
		}];
	}



	sendView = [[StarView alloc] initWithbig:1];
	[self.view addSubview:sendView];

	[sendView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(sendLabel);
		make.left.mas_equalTo(sendLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 200);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	sendFinishView = [[StarFinishView alloc] initWithbig:1];
	sendFinishView.backgroundColor = [UIColor clearColor];
	sendFinishView.clipsToBounds = YES;
	[self.view addSubview:sendFinishView];

	if (!_isFinishEvaluate) {

		[sendFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(sendLabel);
			make.left.mas_equalTo(sendLabel.mas_right).with.offset(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 200);
			make.height.mas_equalTo(UNITHEIGHT * 40);
		}];
	}



	wuliuView = [[StarView alloc] initWithbig:1];
	[self.view addSubview:wuliuView];

	[wuliuView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(wuliuLabel);
		make.left.mas_equalTo(wuliuLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 200);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	wuliuFinishView = [[StarFinishView alloc] initWithbig:1];
	wuliuFinishView.backgroundColor = [UIColor clearColor];
	wuliuFinishView.clipsToBounds = YES;
	[self.view addSubview:wuliuFinishView];

	if (!_isFinishEvaluate) {

		[wuliuFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.centerY.mas_equalTo(wuliuLabel);
			make.left.mas_equalTo(wuliuLabel.mas_right).with.offset(UNITHEIGHT * 20);
			make.width.mas_equalTo(UNITHEIGHT * 200);
			make.height.mas_equalTo(UNITHEIGHT * 40);
		}];
	}



	self.desTextView = [[UITextView alloc] init];
	_desTextView.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
	_desTextView.layer.borderWidth = 1;
	_desTextView.delegate = self;
	_desTextView.layer.borderColor = [UIColor colorWithRed:185 / 255.0 green:185 / 255.0 blue:185 / 255.0 alpha:1].CGColor;
	[self.view addSubview:_desTextView];

	[_desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.top.mas_equalTo(wuliuLabel.mas_bottom).with.offset(UNITHEIGHT * 30);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 100);
	}];

	takeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	takeButton.backgroundColor = [UIColor colorWithHexString:@"#792b34"];
	[takeButton setTitle:@"提交" forState:UIControlStateNormal];
	[takeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[takeButton addTarget:self action:@selector(takeButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:takeButton];

	[takeButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.view).with.offset(UNITHEIGHT * 20);
		make.right.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 20);
		make.bottom.mas_equalTo(self.view).with.offset(-UNITHEIGHT * 15);
		make.height.mas_equalTo(UNITHEIGHT * 45);
	}];
}



#pragma mark - takeButton
- (void)takeButton:(UIButton *)button {
	[self.view endEditing:YES];

	if (textViewStr.length == 0) {
		textViewStr = @"";
	}
	
	NSDictionary *dic = @{@"rec_id" : _rec_id, @"goods_id" : _goodsID, @"content" : textViewStr, @"comment_rank" : _paramsDic[@"comment_rank"], @"server" : _paramsDic[@"server"], @"send" : _paramsDic[@"send"], @"shipping" : _paramsDic[@"shipping"], @"order_id" : _model.order_id};

//	NSLog(@"%@", dic);

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userComment.php?act=do_comment" params:dic Success:^(id responseObject) {
		if ([responseObject[@"status"] isEqual:@1]) {
			[self showAlert:@"评价成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"评价失败" err:responseObject[@"info"]];
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



#pragma mark - textViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
	textViewStr = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
	[descriptionFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(descriptionLabel);
		make.left.mas_equalTo(descriptionLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_paramsDic[@"comment_rank"] floatValue]);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	[serveFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(serveLabel);
		make.left.mas_equalTo(serveLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_paramsDic[@"server"] floatValue]);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	[sendFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(sendLabel);
		make.left.mas_equalTo(sendLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_paramsDic[@"send"] floatValue]);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];

	[wuliuFinishView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(wuliuLabel);
		make.left.mas_equalTo(wuliuLabel.mas_right).with.offset(UNITHEIGHT * 20);
		make.width.mas_equalTo(UNITHEIGHT * 40 * (NSInteger)[_paramsDic[@"shipping"] floatValue]);
		make.height.mas_equalTo(UNITHEIGHT * 40);
	}];
}



#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint = [touch locationInView:self.view];

	if (_isFinishEvaluate) {
		// 以评论 不操作

	} else {
		// 未评论 可操作
		// 描述
		if (touchPoint.y > UNITHEIGHT * 210 && touchPoint.y < UNITHEIGHT * 250) {
			if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 300.0) {

				CGRect clipFrame = descriptionFinishView.frame;
				if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 140) {
					clipFrame.size.width = UNITHEIGHT * 40;
					[_paramsDic setObject:@1 forKey:@"comment_rank"];
				} else if (touchPoint.x > UNITHEIGHT * 140.0 && touchPoint.x < UNITHEIGHT * 180) {
					clipFrame.size.width = UNITHEIGHT * 80;
					[_paramsDic setObject:@2 forKey:@"comment_rank"];
				} else if (touchPoint.x > UNITHEIGHT * 180.0 && touchPoint.x < UNITHEIGHT * 220) {
					clipFrame.size.width = UNITHEIGHT * 120;
					[_paramsDic setObject:@3 forKey:@"comment_rank"];
				} else if (touchPoint.x > UNITHEIGHT * 220.0 && touchPoint.x < UNITHEIGHT * 260) {
					clipFrame.size.width = UNITHEIGHT * 160;
					[_paramsDic setObject:@4 forKey:@"comment_rank"];
				} else {
					clipFrame.size.width = UNITHEIGHT * 200;
					[_paramsDic setObject:@5 forKey:@"comment_rank"];
				}
				descriptionFinishView.frame = clipFrame;
			} else if (touchPoint.x < UNITHEIGHT * 100.0) {
				CGRect clipFrame = descriptionFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 0;
				descriptionFinishView.frame = clipFrame;
				[_paramsDic setObject:@0 forKey:@"comment_rank"];
			} else {
				CGRect clipFrame = descriptionFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 200;
				descriptionFinishView.frame = clipFrame;
				[_paramsDic setObject:@5 forKey:@"comment_rank"];
			}
		}

		if (touchPoint.y > UNITHEIGHT * 250 && touchPoint.y < UNITHEIGHT * 290) {
			if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 300.0) {
				CGRect clipFrame = serveFinishView.frame;
				if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 140) {
					clipFrame.size.width = UNITHEIGHT * 40;
					[_paramsDic setObject:@1 forKey:@"server"];
				} else if (touchPoint.x > UNITHEIGHT * 140.0 && touchPoint.x < UNITHEIGHT * 180) {
					clipFrame.size.width = UNITHEIGHT * 80;
					[_paramsDic setObject:@2 forKey:@"server"];
				} else if (touchPoint.x > UNITHEIGHT * 180.0 && touchPoint.x < UNITHEIGHT * 220) {
					clipFrame.size.width = UNITHEIGHT * 120;
					[_paramsDic setObject:@3 forKey:@"server"];
				} else if (touchPoint.x > UNITHEIGHT * 220.0 && touchPoint.x < UNITHEIGHT * 260) {
					clipFrame.size.width = UNITHEIGHT * 160;
					[_paramsDic setObject:@4 forKey:@"server"];
				} else {
					clipFrame.size.width = UNITHEIGHT * 200;
					[_paramsDic setObject:@5 forKey:@"server"];
				}
				serveFinishView.frame = clipFrame;
			} else if (touchPoint.x < UNITHEIGHT * 100.0) {
				CGRect clipFrame = serveFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 0;
				serveFinishView.frame = clipFrame;
				[_paramsDic setObject:@0 forKey:@"server"];
			} else {
				CGRect clipFrame = serveFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 200;
				serveFinishView.frame = clipFrame;
				[_paramsDic setObject:@5 forKey:@"server"];
			}
		}

		if (touchPoint.y > UNITHEIGHT * 290 && touchPoint.y < UNITHEIGHT * 330) {
			if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 300.0) {
				CGRect clipFrame = sendFinishView.frame;
				if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 140) {
					clipFrame.size.width = UNITHEIGHT * 40;
					[_paramsDic setObject:@1 forKey:@"send"];
				} else if (touchPoint.x > UNITHEIGHT * 140.0 && touchPoint.x < UNITHEIGHT * 180) {
					clipFrame.size.width = UNITHEIGHT * 80;
					[_paramsDic setObject:@2 forKey:@"send"];
				} else if (touchPoint.x > UNITHEIGHT * 180.0 && touchPoint.x < UNITHEIGHT * 220) {
					clipFrame.size.width = UNITHEIGHT * 120;
					[_paramsDic setObject:@3 forKey:@"send"];
				} else if (touchPoint.x > UNITHEIGHT * 220.0 && touchPoint.x < UNITHEIGHT * 260) {
					clipFrame.size.width = UNITHEIGHT * 160;
					[_paramsDic setObject:@4 forKey:@"send"];
				} else {
					clipFrame.size.width = UNITHEIGHT * 200;
					[_paramsDic setObject:@5 forKey:@"send"];
				}
				sendFinishView.frame = clipFrame;
			} else if (touchPoint.x < UNITHEIGHT * 100.0) {
				CGRect clipFrame = sendFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 0;
				sendFinishView.frame = clipFrame;
				[_paramsDic setObject:@0 forKey:@"send"];
			} else {
				CGRect clipFrame = sendFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 200;
				sendFinishView.frame = clipFrame;
				[_paramsDic setObject:@5 forKey:@"send"];
			}
		}

		if (touchPoint.y > UNITHEIGHT * 330 && touchPoint.y < UNITHEIGHT * 370) {
			if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 300.0) {
				CGRect clipFrame = wuliuFinishView.frame;
				if (touchPoint.x > UNITHEIGHT * 100.0 && touchPoint.x < UNITHEIGHT * 140) {
					clipFrame.size.width = UNITHEIGHT * 40;
					[_paramsDic setObject:@1 forKey:@"shipping"];
				} else if (touchPoint.x > UNITHEIGHT * 140.0 && touchPoint.x < UNITHEIGHT * 180) {
					clipFrame.size.width = UNITHEIGHT * 80;
					[_paramsDic setObject:@2 forKey:@"shipping"];
				} else if (touchPoint.x > UNITHEIGHT * 180.0 && touchPoint.x < UNITHEIGHT * 220) {
					clipFrame.size.width = UNITHEIGHT * 120;
					[_paramsDic setObject:@3 forKey:@"shipping"];
				} else if (touchPoint.x > UNITHEIGHT * 220.0 && touchPoint.x < UNITHEIGHT * 260) {
					clipFrame.size.width = UNITHEIGHT * 160;
					[_paramsDic setObject:@4 forKey:@"shipping"];
				} else {
					clipFrame.size.width = UNITHEIGHT * 200;
					[_paramsDic setObject:@5 forKey:@"shipping"];
				}
				wuliuFinishView.frame = clipFrame;
			} else if (touchPoint.x < UNITHEIGHT * 100.0) {
				CGRect clipFrame = wuliuFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 0;
				wuliuFinishView.frame = clipFrame;
				[_paramsDic setObject:@0 forKey:@"shipping"];
			} else {
				CGRect clipFrame = wuliuFinishView.frame;
				clipFrame.size.width = UNITHEIGHT * 200;
				wuliuFinishView.frame = clipFrame;
				[_paramsDic setObject:@5 forKey:@"shipping"];
			}
		}
	}
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//	UITouch *touch = [touches anyObject];
//	CGPoint touchPoint = [touch locationInView:self.view];
//	CGRect clipFrame = descriptionFinishView.frame;
//	clipFrame.size.width = touchPoint.x;
//	descriptionFinishView.frame = clipFrame;
//}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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

