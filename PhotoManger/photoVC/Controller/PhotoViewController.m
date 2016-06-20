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

static NSString * const reuseIdentifier = @"Cell";

@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *colltionView;
@property(nonatomic,strong)NSMutableArray*datasource;

@end

@implementation PhotoViewController


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
        infoModel.imageThumbFile = dic[@"imageThumbFile"];
//        [infoModel assginToPropertyWithDic:dic];
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
        flowOut.itemSize = CGSizeMake(SCREEN_WIDTH/4., SCREEN_WIDTH/4.);
        flowOut.minimumLineSpacing = 0;
        flowOut.minimumInteritemSpacing = 0;

        _colltionView = [[UICollectionView alloc] initWithFrame:Frame(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowOut];
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
//    cell.imageRemarkPath = _datasource[indexPath.section][indexPath.item];
    ImageInfoModel *infoModel = _datasource[indexPath.item];
//    cell.photoView.image = [UIImage imageWithContentsOfFile:infoModel.imageThumbFile];  // 加载缩略图
    cell.photoView.image = [UIImage imageNamed:@"back"];
    cell.backgroundColor = RGBCOLOR(arc4random()%256, arc4random()%256, arc4random()%256);
//     当编辑状态下选中cell 时应该同时修改数据源中的选中属性，下次加载的时候就能保持选中状态

    return cell;
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
