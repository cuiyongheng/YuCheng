//
//  CYHRollView.m
//  Watch
//
//  Created by dllo on 15/10/23.
//
//

#import "CYHRollView.h"
#import "RollCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CYHRollView
{
    NSMutableArray *_imageArr;
    NSMutableArray *_titleArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame image:(NSMutableArray *)imageArr   title:(NSMutableArray *)titleArr{
    self = [super initWithFrame:frame];
    if (self) {
//        _imageArr = [NSMutableArray array];
//        _titleArr = [NSMutableArray array];
        _imageArr = imageArr;
        _titleArr = titleArr;
        
        [self createView];
        
        // 滚动
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)createView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    flowLayout.itemSize = CGSizeMake(WIDTH - UNITWIDTH * 10, UNITHEIGHT * 235 - UNITHEIGHT * 20);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT / 3 - 20) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    

    
    // 设置偏移量
    self.collectionView.contentSize = CGSizeMake(WIDTH * _imageArr.count + 1, 0);
    self.collectionView.pagingEnabled = YES;
    self.collectionView.contentOffset = CGPointMake(WIDTH, 0);
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[RollCell class] forCellWithReuseIdentifier:@"resue"];
    
    
    
    // page
//    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH - 105, HEIGHT / 3 - 30, 100, 20)];
//    [self addSubview:page];
//    page.numberOfPages = _imageArr.count;
//    page.currentPageIndicatorTintColor = [UIColor redColor];
//    page.pageIndicatorTintColor = [UIColor blackColor];
//    page.backgroundColor = [UIColor clearColor];
//    page.tag = 999;
//    [page release];
//    [page addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArr.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resue" forIndexPath:indexPath];
    
    // 赋值图片, 标题
    if (indexPath.row == 0) {
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:_imageArr.lastObject]];
        cell.titleLabel.text = _titleArr.lastObject;
        
    } else if (indexPath.row == _imageArr.count + 1) {
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:_imageArr.firstObject]];
        cell.titleLabel.text = _titleArr.firstObject;
        
    } else {
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:_imageArr[indexPath.row - 1]]];
        cell.titleLabel.text = _titleArr[indexPath.row - 1];
        
    }
    return cell;
}

//- (void)timerAction{
//    
//    // 滚动
//    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + WIDTH, 0) animated:YES];
//    if (self.collectionView.contentOffset.x == WIDTH * (_imageArr.count + 1)) {
//        self.collectionView.contentOffset = CGPointMake(WIDTH, 0);
//        
//    } else if (self.collectionView.contentOffset.x == 0) {
//        self.collectionView.contentOffset = CGPointMake(_imageArr.count * WIDTH, 0);
//    }
//}




//#pragma mark - page
//- (void)pageAction:(UIPageControl *)page {
//    
//    [self.collectionView setContentOffset:CGPointMake((page.currentPage + 1) * WIDTH, 0) animated:YES];
//}

@end
