//
//  MapCell.m
//  YuCheng
//
//  Created by apple on 16/6/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MapCell.h"

@interface MapCell ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, BMKMapViewDelegate>

@property (nonatomic, strong) BMKGeoCodeSearch *searcher;

@property (nonatomic, strong) BMKPointAnnotation *annotation;

@end


@implementation MapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self createView];
	}
	return self;
}

- (void)createView {
	self.titleLabel = [[UILabel alloc] init];
	_titleLabel.text = @"实体店址";
	_titleLabel.font = font(12);
	[self.contentView addSubview:_titleLabel];

	self.addLabel = [[UILabel alloc] init];
//	_addLabel.text = @"欣都龙城";
	_addLabel.font = font(14);
	[self.contentView addSubview:_addLabel];

	self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(UNITHEIGHT * 20, UNITHEIGHT * 50, WIDTH - UNITHEIGHT * 40, UNITHEIGHT * 200)];
	[self.contentView addSubview:_mapView];
	[_mapView setZoomLevel:15];

	self.lineView = [[UIView alloc] init];
	_lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
	[self.contentView addSubview:_lineView];



	//初始化检索对象
	_searcher =[[BMKGeoCodeSearch alloc]init];
	_searcher.delegate = self;
//	BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//	geoCodeSearchOption.city= @"昆明市";
//	geoCodeSearchOption.address = @"盘龙区欣都龙城";
//	BOOL flag = [_searcher geoCode:geoCodeSearchOption];
//
//	if(flag)
//	{
//		NSLog(@"geo检索发送成功");
//	}
//	else
//	{
//		NSLog(@"geo检索发送失败");
//	}

	// 添加一个PointAnnotation
	self.annotation = [[BMKPointAnnotation alloc]init];
	[_mapView addAnnotation:_annotation];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
		make.top.mas_equalTo(self.contentView).with.offset(UNITHEIGHT * 16.5);
		make.height.mas_equalTo(UNITHEIGHT * 10);
	}];

	[_addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(_titleLabel);
		make.centerX.mas_equalTo(self.contentView);
		make.width.mas_equalTo(UNITHEIGHT * 220);
	}];

	[_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(self.contentView).with.offset(-UNITHEIGHT * 2);
		make.height.mas_equalTo(1);
		make.width.mas_equalTo(UNITHEIGHT * 342);
		make.centerX.mas_equalTo(self.contentView);
	}];

}



//实现Deleage处理回调结果
//接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
	if (error == BMK_SEARCH_NO_ERROR) {
		//在此处理正常结果
		CLLocationCoordinate2D coor;
		coor.latitude = result.location.latitude;
		coor.longitude = result.location.longitude;
		_annotation.coordinate = coor;
//		_annotation.title = @"这里是北京";
		[_mapView setCenterCoordinate:result.location];
	}
	else {
		NSLog(@"抱歉，未找到结果");
	}
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
		newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
		newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
		return newAnnotationView;
	}
	return nil;
}

- (void)setAddressStr:(NSString *)addressStr {
	_addressStr = addressStr;

	_annotation.title = [NSString stringWithFormat:@"%@", addressStr];
	_addLabel.text = [NSString stringWithFormat:@"%@", addressStr];

	BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
	geoCodeSearchOption.address = addressStr;
	BOOL flag = [_searcher geoCode:geoCodeSearchOption];

	if(flag)
	{
		NSLog(@"geo检索发送成功");
	}
	else
	{
		NSLog(@"geo检索发送失败");
	}

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
