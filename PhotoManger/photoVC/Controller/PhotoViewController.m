//
//  PhotoViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/18.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollviewCell.h"
static NSString * const reuseIdentifier = @"Cell";

@interface PhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *colltionView;
@property(nonatomic,strong)NSMutableArray*datasource;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowOut;

@end

@implementation PhotoViewController


- (NSMutableArray *)datasource
{
    if (_datasource == nil) {
        
        _datasource = [[NSMutableArray alloc] init];
    }
    
    return _datasource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // datasoure 中装的是photoFile 目录下每天的数组
    // rowArr 中装的应该是imageRemarInfo 图片配置路径
    
    NSMutableArray *rowArr = [[NSMutableArray alloc] init];
    [rowArr addObject:@"1"];
    [rowArr addObject:@"1"];
    [rowArr addObject:@"1"];
    [rowArr addObject:@"1"];

    
    [self.datasource addObject:rowArr];
    [self.datasource addObject:rowArr];
    [self.datasource addObject:rowArr];

    [self.view addSubview:self.colltionView];
    
}


- (UICollectionView *)colltionView
{
    if (_colltionView == nil) {
        
        _flowOut = [[UICollectionViewFlowLayout alloc] init];
        _flowOut.itemSize = CGSizeMake(100, 100);
        _flowOut.minimumLineSpacing = 10;
        _flowOut.minimumInteritemSpacing = 10;

        _colltionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowOut];
        
        [_colltionView registerNib:[UINib nibWithNibName:@"PhotoCollviewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        _colltionView.backgroundColor =[ UIColor whiteColor];
        _colltionView.delegate = self;
        _colltionView.dataSource = self;
        
    }
    return _colltionView;
}


# pragma  mark  collection delegate

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
////    return self.datasource.count;
//    
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
 
//    NSArray *rowArr =self.datasource[section];
//    return rowArr.count;
//    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    
    PhotoCollviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.imageRemarkPath = _datasource[indexPath.section][indexPath.item];

    cell.backgroundColor = RGBCOLOR(arc4random()%256/255., arc4random()%256/255., arc4random()%256/255.);
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
