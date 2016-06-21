
//  PhotosBrowserView.m
//  PhotoManger
//
//  Created by foscom on 16/6/21.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PhotosBrowserView.h"
#import "ImageInfoModel.h"
@interface PhotosBrowserView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tabv;
@end

@implementation PhotosBrowserView

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [[NSMutableArray alloc] init];
        
    }
    return _dataSource;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _tabv = [[UITableView alloc] init];
        _tabv.delegate = self;
        _tabv.dataSource = self;
        _tabv.pagingEnabled = YES;
        _tabv.showsVerticalScrollIndicator = NO;
        _tabv.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tabv.frame = Frame(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tabv.backgroundColor = [UIColor blackColor];
        [self addSubview:_tabv];

    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
    }
    
    [cell.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    ImageInfoModel *imageModel = _dataSource[indexPath.row];
    [cell addSubview:[self imageScrollViewWithPath:imageModel.imageFile]];
    
    return cell;
}



- (UIScrollView *)imageScrollViewWithPath:(NSString *)path
{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:Frame(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT)];
    sc.maximumZoomScale = 5;
    sc.minimumZoomScale = 0.5;
    sc.delegate = self;
    sc.pagingEnabled = YES;
    sc.tag = 100;
    sc.backgroundColor = [UIColor blackColor];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:Frame(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [sc addSubview:imgv];
    imgv.tag = 1000;
    imgv.userInteractionEnabled = YES;
    [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    imgv.image = [UIImage imageWithContentsOfFile:path];
    return sc;
}

- (void)tapAction
{
    _tapblock(1);
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *img = [scrollView viewWithTag:1000];
    
    img.center = scrollView.center;
    
}

- (UIImageView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    UIImageView *img = [scrollView viewWithTag:1000];
    
    return img;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)setTapIndex:(NSInteger)tapIndex
{
  [_tabv setContentOffset:CGPointMake(0, tapIndex *SCREEN_WIDTH)];
}


@end
