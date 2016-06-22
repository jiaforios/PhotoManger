
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
@property(nonatomic,strong)UIView *cotrolView;

@end

@implementation PhotosBrowserView


- (UIView *)cotrolView
{
    if (_cotrolView == nil) {
        
        _cotrolView = [[UIView alloc] initWithFrame:Frame(0, SCREEN_HEIGHT+80, SCREEN_WIDTH, 80)];
        _cotrolView.backgroundColor = [UIColor whiteColor];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cotrolView addSubview:backBtn];
        [backBtn setTitle:@"back" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        AddAction(backBtn, backToPhoto);
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_cotrolView);
            make.centerY.equalTo(_cotrolView);
            make.width.mas_equalTo(80);
            make.left.equalTo(_cotrolView).with.offset(10);
            
        }];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cotrolView addSubview:shareBtn];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        AddAction(shareBtn, shareAction);
        
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(_cotrolView);
            make.centerY.equalTo(_cotrolView);
            make.width.mas_equalTo(80);
            make.left.equalTo(backBtn.mas_right).with.offset(20);
        
        }];
        
    }
    
    return _cotrolView;
}

- (void)shareAction
{
    NSLog(@"分享");

    _contnBlock(1);
}

- (void)backToPhoto
{
    _contnBlock(0);
    
}


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
        self.backgroundColor = [UIColor whiteColor];
        _tabv = [[UITableView alloc] init];
        _tabv.delegate = self;
        _tabv.dataSource = self;
        _tabv.pagingEnabled = YES;
        _tabv.showsVerticalScrollIndicator = NO;
        _tabv.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tabv.frame = Frame(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tabv.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tabv];
        [self addSubview:self.cotrolView];

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
    sc.minimumZoomScale = 1;
    sc.delegate = self;
    sc.pagingEnabled = YES;
    sc.tag = 100;
    sc.backgroundColor = [UIColor whiteColor];
    sc.showsHorizontalScrollIndicator = NO;
    UIImageView *imgv = [[UIImageView alloc] init];
    [sc addSubview:imgv];
    imgv.tag = 1000;
    imgv.userInteractionEnabled = YES;
    [imgv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    imgv.image = [UIImage imageWithContentsOfFile:path];
    imgv.frame = Frame(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(imgv.image.size.height/imgv.image.size.width));
    imgv.center = sc.center;
    return sc;
}

- (void)tapAction
{
    _tapblock(1);

    static BOOL bTap = YES;
    if (bTap) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _cotrolView.frame = CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 80);
  
        }];

    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            _cotrolView.frame = CGRectMake(0, SCREEN_HEIGHT+80, SCREEN_WIDTH, 80);
            
        }];
    }
    
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissView) object:nil];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:5];
    
    
    bTap = !bTap;

}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        
        _cotrolView.frame = CGRectMake(0, SCREEN_HEIGHT+80, SCREEN_WIDTH, 80);
        
    }];

}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *img = [scrollView viewWithTag:1000];
    
    img.center = scrollView.center;
    
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    // 开始放大时隐藏导航条
    
//    _zoomblock(1);
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
//    if (scale >1.3) {
//        
//        _zoomblock(1);
//    }else
//    _zoomblock(2);

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
