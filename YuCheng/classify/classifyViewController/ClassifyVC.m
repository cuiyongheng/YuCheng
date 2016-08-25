//
//  ClassifyVC.m
//  YuCheng
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClassifyVC.h"
#import "ClassifyCell.h"
#import "NewProductVC.h"
#import "ClassifyModel.h"
#import "BreedModel.h"

@interface ClassifyVC ()<UITableViewDataSource, UITableViewDelegate, ClassifyCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *tableItems;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, strong) NSMutableArray *breedArr;

@end

@implementation ClassifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"分类";

	[self createView];

	[self createData];

	[self setNavigation];
}



#pragma mark - setNavigation
- (void)setNavigation {
	self.view.backgroundColor = [UIColor blackColor];

	// 导航栏设置
	self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor blackColor]];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];

	//用于去除导航栏的底线，也就是周围的边线
//	[[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//	[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//	[self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

#pragma mark - createData
- (void)createData {
	self.titleArr = [NSMutableArray arrayWithCapacity:0];
	self.breedArr = [NSMutableArray arrayWithCapacity:0];
	self.tableItems = @[[UIImage imageNamed:@"yc-77.jpg"],
						[UIImage imageNamed:@"yc-78.jpg"],
						[UIImage imageNamed:@"yc-79.jpg"],
						[UIImage imageNamed:@"yc-80.jpg"],
						[UIImage imageNamed:@"yc-81.jpg"]];
	
	[NetWorkingTool GetNetWorking:@"http://www.jadechina.cn/mapi/goodsAttr.php" Params:nil Success:^(id responseObject) {

		_breedArr = [BreedModel BaseModel:responseObject[@"category_list"]];
		_titleArr = [ClassifyModel BaseModel:responseObject[@"attr_list"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_tableView reloadData];
		});

	} Failed:^(NSError *error) {

	}];
}

- (void)createView {
	// 背景图片
	UIImageView *upImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (4)"]];
	upImageView.alpha = 0.1;
	[self.view addSubview:upImageView];

	[upImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.top.mas_equalTo(self.view).with.offset(UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 85);
		make.width.mas_equalTo(UNITHEIGHT * 101);
	}];

	UIImageView *downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon (4)"]];
	downImageView.alpha = 0.1;
	[self.view addSubview:downImageView];

	[downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.view);
		make.bottom.mas_equalTo(self.view).with.offset(-49 - UNITHEIGHT * 10);
		make.height.mas_equalTo(UNITHEIGHT * 85);
		make.width.mas_equalTo(UNITHEIGHT * 101);
	}];

	// tableView
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.backgroundColor = [UIColor clearColor];
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.rowHeight = UNITHEIGHT * 149;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];

	[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _titleArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 定义cell标识  每个cell对应一个自己的标识
	NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
	// 通过不同标识创建cell实例
	ClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	// 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
	if (!cell) {
		cell = [[ClassifyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}

	// 对cell 进行简单地数据配置
	cell.backImageView.image = self.tableItems[indexPath.row];
	cell.delegate = self;

	if (indexPath.row == 0) {
		cell.titleLabel.text = @"品种";
		cell.nameLabel.text = @"品种";
		cell.breedArr = _breedArr;
	} else {
		cell.model = _titleArr[indexPath.row - 1];
	}

	cell.foldView.tag = 21000 + indexPath.row;
	cell.collectionView.tag = 22000 + indexPath.row;
	cell.nameLabel.tag = 23000 + indexPath.row;
	cell.delegate = self;

	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	return cell;
}



#pragma mark - 点击动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	//
	//	UIView *foldView = (UIView *)[self.view viewWithTag:1000 + indexPath.row];
	//	UIButton *foldButton = (UIButton *)[self.view viewWithTag:2000 + indexPath.row];
	//
	//
	//
	//	if ((CGFloat)foldView.frame.size.height >= 200.0f) {
	//		[UIView animateWithDuration:0.4 animations:^{
	//			// 动画部分都写在block里
	//			foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)300);
	//			foldButton.hidden = YES;
	//		}];
	//
	//		[self performSelector:@selector(foldToHiddenView:) withObject:foldView afterDelay:0.4];
	//
	//	} else {
	//
	//		[UIView animateWithDuration:0.4 animations:^{
	//			// 动画部分都写在block里
	//			foldView.transform = CGAffineTransformScale(foldView.transform, 1, 300);
	//			foldView.hidden = NO;
	//			foldButton.hidden = NO;
	//		}];
	//		_rowHeight = foldView.frame.size.height;
	//		[self performSelector:@selector(reloadTableView:) withObject:tableView afterDelay:0.4];
	//	}



	for (NSInteger i = 0; i < _titleArr.count + 1; i++) {
		UIView *foldView = (UIView *)[self.view viewWithTag:21000 + i];
		UICollectionView *foldButton = (UICollectionView *)[self.view viewWithTag:22000 + i];
		UIView *nameLabel = (UIView *)[self.view viewWithTag:23000 + i];

		if (foldView.tag == indexPath.row + 21000) {

			if ((CGFloat)foldView.frame.size.height >= UNITHEIGHT * 149.0f) {
				[UIView animateWithDuration:0.4 animations:^{
					// 动画部分都写在block里

					if (foldView.tag == 21001) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)430);
					} else if (foldView.tag == 21000) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)270);
					} else if (foldView.tag == 21002) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)230);
					} else if (foldView.tag == 21003) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)280);
					} else if (foldView.tag == 21004) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)250);
					}

					foldButton.hidden = YES;
					nameLabel.hidden = YES;
				}];

				[self performSelector:@selector(foldToHiddenView:) withObject:foldView afterDelay:0.4];

			} else {

				[UIView animateWithDuration:0.4 animations:^{
					// 动画部分都写在block里

					if (foldView.tag == 21001) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, 430);
					} else if (foldView.tag == 21000) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, 270);
					} else if (foldView.tag == 21002) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, 230);
					} else if (foldView.tag == 21003) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, 280);
					} else if (foldView.tag == 21004) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, 250);
					}



				[self performSelector:@selector(foldToShowView:) withObject:foldView afterDelay:0.4];
					foldView.hidden = NO;
					nameLabel.hidden = NO;
				}];

				_rowHeight = foldView.frame.size.height;
				[self performSelector:@selector(reloadTableView:) withObject:tableView afterDelay:0.4];
			}

		} else {
			if ((CGFloat)foldView.frame.size.height >= UNITHEIGHT * 149.0f) {
				[UIView animateWithDuration:0.4 animations:^{
					// 动画部分都写在block里

					if (foldView.tag == 21001) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)430);
					} else if (foldView.tag == 21000) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)270);
					} else if (foldView.tag == 21002) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)230);
					} else if (foldView.tag == 21003) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)280);
					} else if (foldView.tag == 21004) {
						foldView.transform = CGAffineTransformScale(foldView.transform, 1, (CGFloat)1 / (CGFloat)250);
					}

					foldButton.hidden = YES;
					nameLabel.hidden = YES;
				}];

				[self performSelector:@selector(foldToHiddenView:) withObject:foldView afterDelay:0.4];
			}
		}
	}

	
	
	[tableView beginUpdates];
	[tableView endUpdates];
	
}

- (void)reloadTableView:(UITableView *)table {

	//	[_tableView reloadData];

	//	NSIndexPath *te=[NSIndexPath indexPathForRow:1 inSection:0];//刷新第一个section的第二行
	//	[table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];



	//	NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
	//	[table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	UIView *foldView = (UIView *)[self.view viewWithTag:21000 + indexPath.row];

	if ((CGFloat)foldView.frame.size.height >= 149.0f) {

		if (indexPath.row ==  foldView.tag - 21000) {

			return _rowHeight;
		} else {
			return 149;
		}
	} else {
		return 149;
	}
}

//- (void)foldToView:(UIView *)foldview {
//	[UIView animateWithDuration:0.4 animations:^{
//		// 动画部分都写在block里
//		foldview.transform = CGAffineTransformScale(foldview.transform, 1, (CGFloat)1 / (CGFloat)300);
//	}];
//
//	[self performSelector:@selector(foldToHiddenView:) withObject:foldview afterDelay:0.4];
//
//}

- (void)foldToShowView:(UIView *)foldView {

//	foldView.hidden = NO;
	UICollectionView *foldButton = (UICollectionView *)[self.view viewWithTag:foldView.tag + 1000];
	foldButton.hidden = NO;
	UIView *nameLabel = (UIView *)[self.view viewWithTag:foldView.tag + 2000];
	nameLabel.hidden = NO;

}

- (void)foldToHiddenView:(UIView *)foldView {
	foldView.hidden = YES;
	[_tableView reloadData];

	//	UIButton *foldButton = (UIButton *)[self.view viewWithTag:foldView.tag + 1000];
	//	foldButton.hidden = YES;
}



#pragma mark - 视差效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Get visible cells on table view.
	NSArray *visibleCells = [self.tableView visibleCells];

	for (ClassifyCell *cell in visibleCells) {
		[cell cellOnTableView:self.tableView didScrollOnView:self.view];
	}
}



//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//	return UIStatusBarStyleLightContent;
//}

#pragma mark - push
- (void)pushNextVC:(NSString *)seleteString {
	NewProductVC *productVC = [[NewProductVC alloc] init];
	productVC.isNewProduct = 0;
	productVC.attr_key = seleteString;

	// 筛选
	for (BreedModel *model in _breedArr) {
		if ([model.cat_name isEqualToString:seleteString]) {
			productVC.cat_id = model.cat_id;
		}
	}

	[self.navigationController pushViewController:productVC animated:YES];
}


#pragma mark - viewDidAppear
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self scrollViewDidScroll:nil];
	
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBar.translucent = NO;
	//	self.navigationController.navigationBar.translucent = YES;
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor]}];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//	[self.navigationController.navigationBar cnSetBackgroundColor:[UIColor blackColor]];
	self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//	self.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.translucent = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
