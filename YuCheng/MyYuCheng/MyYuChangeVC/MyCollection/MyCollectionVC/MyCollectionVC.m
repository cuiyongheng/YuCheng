//
//  MyCollectionVC.m
//  YuCheng
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyCollectionVC.h"
#import "MyCollectionCell.h"
#import "MyCollectionModel.h"
#import "ProductInfoVC.h"

@interface MyCollectionVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *editView;

@property (nonatomic, strong) UIButton *itemButton;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSMutableArray *collectionArr;

@property (nonatomic, strong) NSMutableDictionary *chooseDic;

@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self createView];

	[self createData];

	[self rightNavigation];

	self.title = @"我的收藏";
}



#pragma mark - rightNavigation
- (void)rightNavigation {
	self.itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_itemButton setTitle:@"编辑" forState:UIControlStateNormal];
	_itemButton.titleLabel.font = font(14);
	[_itemButton setTitleColor:[UIColor colorWithHexString:@"#595757"] forState:UIControlStateNormal];
	[_itemButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
	_itemButton.frame = CGRectMake(0, 0, UNITHEIGHT * 40, UNITHEIGHT * 40);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_itemButton];
}



#pragma mark - createData
- (void)createData {
	_collectionArr = [NSMutableArray arrayWithCapacity:0];
	_chooseDic = [NSMutableDictionary dictionaryWithCapacity:0];
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/userCollect.php?act=list" Params:nil Success:^(id responseObject) {

		if ([responseObject[@"goods_list"] count] > 0) {
			for (NSDictionary *dic in [responseObject[@"goods_list"] allValues]) {
				MyCollectionModel *model = [MyCollectionModel mj_objectWithKeyValues:dic];
				[_collectionArr addObject:model];
			}

			for (NSInteger i = 0; i < _collectionArr.count; i++) {
				[_chooseDic setObject:@0 forKey:[NSIndexPath indexPathForItem:i inSection:0]];
			}

		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.rowHeight = UNITHEIGHT * 144;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[MyCollectionCell class] forCellReuseIdentifier:@"myCollectionCell"];



	// 编辑
	self.editView = [[UIView alloc] init];
	_editView.hidden = YES;
	_editView.backgroundColor = [UIColor colorWithHexString:@"792b34"];
	[self.view addSubview:_editView];

	[_editView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.view);
		make.height.mas_equalTo(UNITHEIGHT * 135.8);
		make.left.right.mas_equalTo(self.view);
	}];

	UIImageView *allImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteRound"]];
	[_editView addSubview:allImageView];

	[allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_editView.mas_left).with.offset(WIDTH / 3);
		make.top.mas_equalTo(UNITHEIGHT * 30);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *allLabel = [[UILabel alloc] init];
	allLabel.text = @"全选";
	allLabel.textAlignment = NSTextAlignmentCenter;
	allLabel.textColor = [UIColor whiteColor];
	[_editView addSubview:allLabel];

	[allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(allImageView.mas_bottom).with.offset(UNITHEIGHT * 25);
		make.centerX.mas_equalTo(allImageView);
	}];

	UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[allButton addTarget:self action:@selector(allButton:) forControlEvents:UIControlEventTouchUpInside];
	[_editView addSubview:allButton];

	[allButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(allImageView);
		make.bottom.mas_equalTo(allLabel);
	}];



	UIImageView *deleteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lajixiang"]];
	[_editView addSubview:deleteImageView];

	[deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(_editView.mas_left).with.offset(WIDTH / 3 * 2);
		make.top.mas_equalTo(UNITHEIGHT * 30);
		make.height.width.mas_equalTo(UNITHEIGHT * 30);
	}];

	UILabel *deleteLabel = [[UILabel alloc] init];
	deleteLabel.text = @"删除";
	deleteLabel.textAlignment = NSTextAlignmentCenter;
	deleteLabel.textColor = [UIColor whiteColor];
	[_editView addSubview:deleteLabel];

	[deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.mas_equalTo(deleteImageView.mas_bottom).with.offset(UNITHEIGHT * 25);
		make.centerX.mas_equalTo(deleteImageView);
	}];

	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
	[_editView addSubview:deleteButton];

	[deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.mas_equalTo(deleteImageView);
		make.bottom.mas_equalTo(deleteLabel);
	}];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _collectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCollectionCell"];
	cell.tag = 130000 + indexPath.row;
	cell.model = _collectionArr[indexPath.row];

	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headView = [[UIView alloc] init];
	UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(UNITHEIGHT * 20, 0, WIDTH - UNITHEIGHT * 40, 1)];
	backView.backgroundColor = [UIColor colorWithHexString:@"#a5a5a5"];
	[headView addSubview:backView];

	return headView;
}


- (void)rightButton:(UIButton *)button {
	//	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑" message:@"是否删除所有" preferredStyle:UIAlertControllerStyleAlert];
	//
	//	UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
	//
	//	}];
	//
	//	UIAlertAction *alertCancle = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
	//
	//	}];
	//
	//	[alert addAction:alertAction];
	//	[alert addAction:alertCancle];
	//
	//	[self presentViewController:alert animated:YES completion:nil];



	//	for (NSInteger i = 0; i < self.titleArr.count; i++) {

	//		UIView *deleteView = (UIView *)[self.view viewWithTag:80000 + i];
	//
	//		if (_isEdit) {
	//			// 动画效果
	//			CATransition *animation = [CATransition animation];
	//			animation.duration = 0.3f;
	//			animation.timingFunction = UIViewAnimationCurveEaseInOut;
	//			// 改编动画样式
	//			animation.type = kCATransitionFade;
	//			// animation.type = @"";
	////			animation.subtype = kCATransitionFromRight;
	//			[deleteView.layer addAnimation:animation forKey:@"animation"];
	//
	//			deleteView.transform = CGAffineTransformMakeTranslation(0, 0);
	//		} else {
	//			// 动画效果
	//			CATransition *animation = [CATransition animation];
	//			animation.duration = 0.3f;
	//			animation.timingFunction = UIViewAnimationCurveEaseInOut;
	//			// 改编动画样式
	//			animation.type = kCATransitionFade;
	//			// animation.type = @"";
	////			animation.subtype = kCATransitionFromLeft;
	//			[deleteView.layer addAnimation:animation forKey:@"animation"];
	//
	//			deleteView.transform = CGAffineTransformMakeTranslation(UNITHEIGHT * 50, 0);
	//		}
	//	}

	// 下面编辑
	if (_isEdit) {
		_editView.hidden = YES;
		[_itemButton setTitle:@"编辑" forState:UIControlStateNormal];
	} else {
		_editView.hidden = NO;
		[_itemButton setTitle:@"完成" forState:UIControlStateNormal];
	}

	for (NSInteger i = 0; i < _collectionArr.count; i++) {
		MyCollectionCell *cell = (MyCollectionCell *)[self.view viewWithTag:130000 + i];
		if (_isEdit) {
			[UIView animateWithDuration:0.3 animations:^{
				// 动画部分都写在block里
				cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
			}];
		} else {
			[UIView animateWithDuration:0.3 animations:^{
				// 动画部分都写在block里
				cell.frame = CGRectMake(UNITHEIGHT * 50, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
			}];
		}
	}

	_isEdit = !_isEdit;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

	for (NSInteger i = 0; i < _collectionArr.count; i++) {
		MyCollectionCell *cell = (MyCollectionCell *)[self.view viewWithTag:130000 + i];
		if (!_isEdit) {
			cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
		} else {
			cell.frame = CGRectMake(UNITHEIGHT * 50, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
		}
	}

}

#pragma mark - editAction
- (void)allButton:(UIButton *)button {
	for (NSInteger i = 0; i < _collectionArr.count; i++) {
		MyCollectionCell *cell = (MyCollectionCell *)[self.view viewWithTag:130000 + i];
		[cell.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
		[_chooseDic setObject:@1 forKey:[NSIndexPath indexPathForItem:i inSection:0]];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (_isEdit) {

		MyCollectionCell *cell = (MyCollectionCell *)[self.view viewWithTag:130000 + indexPath.row];
		if ([_chooseDic[indexPath] isEqual:@1]) {
			// 选中
			[cell.chooseButton setBackgroundImage:[UIImage imageNamed:@"redRound"] forState:UIControlStateNormal];
			[_chooseDic setObject:@0 forKey:indexPath];
		} else {
			// 未选中
			[cell.chooseButton setBackgroundImage:[UIImage imageNamed:@"redBinggou"] forState:UIControlStateNormal];
			[_chooseDic setObject:@1 forKey:indexPath];
		}
	} else {
		ProductInfoVC *infoVC = [[ProductInfoVC alloc] init];
		infoVC.goodsID = [_collectionArr[indexPath.row] goods_id];
		[self.navigationController pushViewController:infoVC animated:YES];
	}
}

- (void)deleteButton:(UIButton *)button {

	NSString *deleteStr;
	for (NSInteger i = 0; i < _chooseDic.count; i++) {
		if ([_chooseDic[[NSIndexPath indexPathForRow:i inSection:0]] isEqual:@1]) {
			if (!deleteStr) {
				deleteStr = [NSString stringWithFormat:@"%@", [_collectionArr[i] goods_id]];
			} else {
				deleteStr = [NSString stringWithFormat:@"%@,%@", deleteStr, [_collectionArr[i] goods_id]];
			}
		}
	}

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/userCollect.php?act=batch_delete" params:@{@"goods_ids" : deleteStr} Success:^(id responseObject) {
		if ([responseObject[@"status"] isEqual:@1]) {
			[RegosterAlert showAlert:@"取消收藏成功" err:responseObject[@"info"]];
		} else {
			[RegosterAlert showAlert:@"取消收藏失败" err:responseObject[@"info"]];
		}

		dispatch_async(dispatch_get_main_queue(), ^{
			[self createData];
			[self rightButton:self.itemButton];
		});
		
	} Failed:^(NSError *error) {

	}];
}



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
