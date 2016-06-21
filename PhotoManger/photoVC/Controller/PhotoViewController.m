//
//  PhotoViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/18.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCoelCell.h"
#import "ImageInfoModel.h"
#import "PhotosBrowserView.h"
static NSString * const reuseIdentifier = @"Cell";

@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *colltionView;
@property(nonatomic,strong)NSMutableArray*datasource;
@property(nonatomic, strong)PhotosBrowserView *pvc;

@end

@implementation PhotoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (NSMutableArray *)datasource
{
    if (_datasource == nil) {
        
        _datasource = [[NSMutableArray alloc] init];
    }
    _datasource = [_remarkDataSource mutableCopy];
    
   _datasource =  [self getImageDataFromRemarkInfoInArr:_remarkDataSource];
    
    return _datasource;
}
/**
 *  根据数组中的元素找到指定的remarkInfo 文件，并且解码数据转化成对应的模型存入数组中
 *
 *  @param arr remarkinfo file 数组
 *  return  图片信息数组
 */
- (NSMutableArray *)getImageDataFromRemarkInfoInArr:(NSArray *)arr
{
    NSMutableArray *imageInfoArr = [[NSMutableArray alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = [ImageVideoFilesManger UnachiveFromFileWithName:obj];  // 解档数据
        ImageInfoModel *infoModel = [[ImageInfoModel alloc] init];
        [infoModel assginToPropertyWithDic:dic];
        infoModel.imageThumbFile = [ImageVideoFilesManger thumbPathFromName:dic[@"cameraTimes"]];
        infoModel.imageFile = [ImageVideoFilesManger imagePathFromName:dic[@"cameraTimes"]];

        [imageInfoArr addObject:infoModel];
        
    }];
    
    return imageInfoArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.colltionView];

    
}


- (UICollectionView *)colltionView
{
    if (_colltionView == nil) {
        
      UICollectionViewFlowLayout*  flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.itemSize = CGSizeMake((SCREEN_WIDTH-6)/4., (SCREEN_WIDTH-6)/4.);
        flowOut.minimumLineSpacing = 2;
        flowOut.minimumInteritemSpacing = 2;

        _colltionView = [[UICollectionView alloc] initWithFrame:Frame(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowOut];
        [_colltionView registerClass:[PhotoCoelCell class] forCellWithReuseIdentifier:reuseIdentifier];

        _colltionView.backgroundColor =[ UIColor whiteColor];
        _colltionView.delegate = self;
        _colltionView.dataSource = self;
        
    }
    return _colltionView;
}


# pragma  mark  collection delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoCoelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ImageInfoModel *infoModel = _datasource[indexPath.item];
    NSString *path = infoModel.imageThumbFile;
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    cell.photoView.image = image;
    return cell;
}


-  (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _pvc = [[PhotosBrowserView alloc] initWithFrame:self.view.bounds];
    _pvc.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [self.view addSubview:_pvc];
    _pvc.dataSource = _datasource;
    _pvc.tapIndex = indexPath.item;
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    __block PhotoViewController *weakself = self;
    _pvc.tapblock = ^(NSInteger count){
    
        if (count == 1) {
            
        weakself.navigationController.navigationBarHidden = NO;
            
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//          weakself.navigationController.navigationBarHidden = YES;
//
//                
//            });
            
         [UIView animateWithDuration:0.25 animations:^{
                
                weakself.pvc.transform = CGAffineTransformMakeScale(0.001, 0.001);
                
          }];
            
            
        }
    };
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _pvc.transform = CGAffineTransformMakeScale(1, 1);
        self.navigationController.navigationBarHidden = YES;
        
    } completion:^(BOOL finished) {
        
        self.navigationController.navigationBarHidden = YES;

    }];
    
}

static int place = 0;

- (void)makeAnimationWithPoint:(CGPoint)point
{
    place = 1;
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:point];
    animation1.toValue = [NSValue valueWithCGPoint:self.view.center];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:0];
    animation2.toValue = [NSNumber numberWithFloat:1.];
    
    CAAnimationGroup *group= [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = 0.5;
    group.animations = @[animation1,animation2];

    [_pvc.layer addAnimation:group forKey:@"animations"];
}

- (void)makeBackAnimationWithPoint:(CGPoint)point
{
    place = 2;
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:point];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointZero];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithFloat:1.];
    animation2.toValue = [NSNumber numberWithFloat:0];
    
    CAAnimationGroup *group= [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = 0.5;
    group.animations = @[animation1,animation2];
    [_pvc.layer addAnimation:group forKey:@"animations"];
    
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
