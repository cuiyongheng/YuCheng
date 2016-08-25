//
//  ProvinceVC.m
//  YuCheng
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ProvinceVC.h"
#import "ProvinceModel.h"

@interface ProvinceVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *provinceTableView;

@property (nonatomic, strong) UITableView *cityTableView;

@property (nonatomic, strong) UITableView *zoomTableView;

@property (nonatomic, strong) NSMutableArray *provinceArr;

@property (nonatomic, strong) NSMutableArray *cityArr;

@property (nonatomic, strong) NSMutableArray *zoomArr;

@property (nonatomic, strong) NSMutableDictionary *provinceDic;

@end

@implementation ProvinceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self createView];

	[self createData];
}



#pragma mark - createData
- (void)createData {
	_provinceArr = [NSMutableArray arrayWithCapacity:0];
	_zoomArr = [NSMutableArray arrayWithCapacity:0];
	_cityArr = [NSMutableArray arrayWithCapacity:0];
	_provinceDic = [NSMutableDictionary dictionaryWithCapacity:0];

	[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/region.php" params:@{@"type" : @1, @"parent" : @1} Success:^(id responseObject) {

		_provinceArr = [ProvinceModel BaseModel:responseObject[@"regions"]];

		dispatch_async(dispatch_get_main_queue(), ^{
			[_provinceTableView reloadData];
		});
	} Failed:^(NSError *error) {

	}];
}

#pragma mark - createView
- (void)createView {
	self.provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , WIDTH / 3, HEIGHT) style:UITableViewStylePlain];
	_provinceTableView.backgroundColor = [UIColor whiteColor];
	_provinceTableView.delegate = self;
	_provinceTableView.dataSource = self;
	_provinceTableView.bounces = NO;
	_provinceTableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_provinceTableView];

	self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH / 3, 64, WIDTH / 3, HEIGHT - 64) style:UITableViewStylePlain];
	_cityTableView.delegate = self;
	_cityTableView.dataSource = self;
	_cityTableView.backgroundColor = [UIColor whiteColor];
	_cityTableView.bounces = NO;
	_cityTableView.showsVerticalScrollIndicator = NO;
	[self.view addSubview:_cityTableView];

	self.zoomTableView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH / 3 * 2, 64, WIDTH / 3, HEIGHT - 64) style:UITableViewStylePlain];
	_zoomTableView.dataSource = self;
	_zoomTableView.delegate = self;
	_zoomTableView.bounces = NO;
	_zoomTableView.showsVerticalScrollIndicator = NO;
	_zoomTableView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:_zoomTableView];

	[_provinceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"provinceCell"];

	[_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];

	[_zoomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"zoomCell"];
}



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == _provinceTableView) {
		return _provinceArr.count;
	} else if (tableView == _cityTableView) {
		return _cityArr.count;
	} else {
		return _zoomArr.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _provinceTableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"provinceCell"];
		cell.textLabel.text = [_provinceArr[indexPath.row] region_name];
		cell.textLabel.textAlignment = NSTextAlignmentCenter;

		return cell;
	} else if (tableView == _cityTableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell"];
		cell.textLabel.text = [_cityArr[indexPath.row] region_name];
		cell.textLabel.textAlignment = NSTextAlignmentCenter;

		return cell;
	} else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zoomCell"];
		cell.textLabel.text = [_zoomArr[indexPath.row] region_name];
		cell.textLabel.textAlignment = NSTextAlignmentCenter;

		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == _provinceTableView) {
		NSDictionary *paramsDic = @{@"type" : @2, @"parent" : [_provinceArr[indexPath.row] region_id]};
		[_provinceDic setObject:[_provinceArr[indexPath.row] region_id] forKey:@"provinceID"];
		[_provinceDic setObject:[_provinceArr[indexPath.row] region_name] forKey:@"province"];
		_zoomArr = [NSMutableArray arrayWithCapacity:0];

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/region.php" params:paramsDic Success:^(id responseObject) {

			_cityArr = [ProvinceModel BaseModel:responseObject[@"regions"]];
			dispatch_async(dispatch_get_main_queue(), ^{
				[_cityTableView reloadData];
				[_zoomTableView reloadData];
			});
		} Failed:^(NSError *error) {

		}];
	} else if (tableView == _cityTableView) {
		NSDictionary *paramsDic = @{@"type" : @3, @"parent" : [_cityArr[indexPath.row] region_id]};
		[_provinceDic setObject:[_cityArr[indexPath.row] region_id] forKey:@"cityID"];
		[_provinceDic setObject:[_cityArr[indexPath.row] region_name] forKey:@"city"];

		[NetWorkingTool PostNetWorking:@"http://www.jadechina.cn/mapi/region.php" params:paramsDic Success:^(id responseObject) {

			_zoomArr = [ProvinceModel BaseModel:responseObject[@"regions"]];
			dispatch_async(dispatch_get_main_queue(), ^{
				[_zoomTableView reloadData];
			});

			if (_zoomArr.count == 0) {

				_block(_provinceDic);
				[self dismissViewControllerAnimated:YES completion:nil];
			}
		} Failed:^(NSError *error) {

		}];
	} else {
		[_provinceDic setObject:[_zoomArr[indexPath.row] region_id] forKey:@"zoomID"];
		[_provinceDic setObject:[_zoomArr[indexPath.row] region_name] forKey:@"zoom"];

		_block(_provinceDic);
		[self dismissViewControllerAnimated:YES completion:nil];
	}
}



- (void)leftItemAction:(UIButton *)button {
	[self dismissViewControllerAnimated:YES completion:nil];
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
