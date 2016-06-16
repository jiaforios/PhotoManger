//
//  MainViewController.m
//  PhotoManger
//
//  Created by foscom on 16/6/14.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "MainViewController.h"
#import "ImagePickerViewController.h"
#import "CameraControlView.h"
#import "ImageVideoFilesManger.h"
#import "SetViewController.h"
#import "LocationManger.h"
@interface MainViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *phontoButton;

@end

@implementation MainViewController



- (void)viewWillAppear:(BOOL)animated
{
    // 2
}
- (void)viewDidAppear:(BOOL)animated
{
    // 5
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1
    // Do any additional setup after loading the view.
    [self valueInit];
    [self setUpViews];
    
    [LocationManger  shareLoacationWithLocationBlock:^(NSString *name) {
        
        NSLog(@"name = %@ ",name);
    }];
}

// 值的初始化
- (void)valueInit
{
   self.view.backgroundColor = [UIColor whiteColor];

    
}
// 界面创建
-(void)setUpViews
{
    [self.view addSubview:self.cameraButton];
    [self.view addSubview:self.phontoButton];

    [self viewLayout];
}

// 界面布局
- (void)viewLayout
{
    
    [_cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.view).with.offset(50);
    
    }];
    [_phontoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.right.equalTo(self.view).with.offset(-50);
    }];
}


- (UIButton *)cameraButton
{
    if (!_cameraButton) {
        _cameraButton  =  [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraButton.backgroundColor = [UIColor blueColor];
        _cameraButton.layer.cornerRadius = CGRectGetWidth(_cameraButton.frame)/2.f;
        AddAction(_cameraButton, cameraAction:);
    }
    return _cameraButton;
}

- (UIButton *)phontoButton
{
    if (!_phontoButton) {
        _phontoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phontoButton.backgroundColor =[UIColor redColor];
        _phontoButton.layer.cornerRadius = CGRectGetWidth(_phontoButton.frame)/2.f;
        AddAction(_phontoButton, photoAction:);
    }
    return _phontoButton;
}


#pragma  mark  -- camera photo 按钮点击事件

- (void)cameraAction:(UIButton *)sender
{
    
    ImagePickerViewController *picker = [ImagePickerViewController sharePickeManger];
        
    [self presentViewController:picker animated:YES completion:nil];
    

}

- (void)photoAction:(UIButton *)sender
{
    SetViewController *set = [[SetViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:set animated:YES];
}
- (void)viewWillLayoutSubviews
{
    // 3

}
- (void)viewDidLayoutSubviews
{
    // 4
    _cameraButton.layer.cornerRadius = CGRectGetWidth(_cameraButton.frame)/2.f;
    
    _phontoButton.layer.cornerRadius = CGRectGetWidth(_phontoButton.frame)/2.f;

    if ([UIDevice currentDevice].orientation  == UIDeviceOrientationPortrait) {
        [_cameraButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).with.offset(50);
        }];
        
        [_phontoButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.view).with.offset(-50);
        }];

        return;
    }
    
    [_cameraButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).with.offset(200);
    }];
    
    [_phontoButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).with.offset(-200);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
